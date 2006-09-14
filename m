Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWINSsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWINSsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWINSsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:48:23 -0400
Received: from twin.jikos.cz ([213.151.79.26]:26550 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751019AbWINSsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:48:22 -0400
Date: Thu, 14 Sep 2006 20:48:16 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
In-Reply-To: <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz> 
 <200609132200.51342.dtor@insightbb.com>  <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
  <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com> 
 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz> 
 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com> 
 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz> 
 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com> 
 <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
 <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Dmitry Torokhov wrote:

> Well, we do not really care about nestiness do we? What we trying to 
> achieve is to teach lockdep that 2 locks while appear as the lame lock 
> in fact are different and protect 2 different structures. Ideally 
> lockdep should track every lock individually (based for example on its 
> address) but that would be too taxing so we need to help it. In your 
> implementation you embed this data into structure/code using lock, but 
> this information could be instilled into the lock itself upon 
> initialization and spin_[un]lock() implementation could be taught to use 
> this data thus making specialized spin_[un]lock*_nested() functions 
> unnecessary.

Hi Dmitry,

IMHO this is exactly what the nested locking primitives were introduced in 
lockdep for (we even have natural hierarchy here), so I am not sure if 
this is compliant with lockdep design. I definitely could do a patch that 
would introduce {spin,mutex..}_lock_init_subclass(), which would 
initialize the lock together with defining it's 'class', so that it could 
be distinguishable from any other lock of the same type during proving of 
correctness ... but this is a step towards distinguishing every single 
lock from all others (even of a same type), which I am not sure is the 
right direction.

I added Ingo to CC.

Thanks,

-- 
JiKos.
