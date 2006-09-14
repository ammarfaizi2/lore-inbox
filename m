Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWINQA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWINQA3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbWINQA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:00:28 -0400
Received: from twin.jikos.cz ([213.151.79.26]:57249 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750917AbWINQA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:00:28 -0400
Date: Thu, 14 Sep 2006 18:00:21 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
In-Reply-To: <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0609141754480.2721@twin.jikos.cz>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz> 
 <200609132200.51342.dtor@insightbb.com>  <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
  <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com> 
 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz> 
 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com> 
 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
 <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2006, Dmitry Torokhov wrote:

> Not yet ;) Is there a way to hide the depth in the spinlock/mutex 
> structure itself so that initialization code could do 
> spin_lock_init_nested() and spare the rest of the code from that 
> knowledge?

(shortened CC list a bit)

In fact I am not sure what you mean. On every lock and unlock operation, 
in case of recursive locking (which our case is), you have to provide 
class identifier, which is used to distinguish if the lock is of the same 
instance, or a different one (deeper or higher in the locking hierarchy). 
There is no way how spin_lock() or mutex_lock() can know this 
"automatically", you always have to provide the nesting level from 
outside, as it depends on the ordering hierarchy, which locking primitives 
are totally unaware of.

Or did I misunderstand you?

Thanks,

-- 
JiKos.
