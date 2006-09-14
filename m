Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWINPvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWINPvq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 11:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWINPvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 11:51:46 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:16263 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750893AbWINPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 11:51:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jhCSHQ0Yf4IATKdFXUxhh/EIK0yAZDi/SNDhfa0CNzc1+uLacf6lzO6ts2l2xGZkqPFViLi6Au/N2grh75kOl9TR6YQHA4aLDNI6S5i7kN/Xv6tTsT145Ih/inSH2Sz3aBKBzNXutFkS3HJFPUIOhSKoclRjxnyy2SYzXlm4IBg=
Message-ID: <d120d5000609140851r2299c64cv8b0a365be795a1bc@mail.gmail.com>
Date: Thu, 14 Sep 2006 11:51:42 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: "Andrew Morton" <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Dave Jones" <davej@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <200609132200.51342.dtor@insightbb.com>
	 <Pine.LNX.4.64.0609141028540.22181@twin.jikos.cz>
	 <d120d5000609140618h6e929883u2ed82d1cab677e57@mail.gmail.com>
	 <Pine.LNX.4.64.0609141635040.2721@twin.jikos.cz>
	 <d120d5000609140758w7ba5cfdbs399d6831082e7cb4@mail.gmail.com>
	 <Pine.LNX.4.64.0609141700250.2721@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/06, Jiri Kosina <jikos@jikos.cz> wrote:
> On Thu, 14 Sep 2006, Dmitry Torokhov wrote:
>
> > Yes, this is much, much better. Could you please tell me if depth should
> > be a true depth or just an unique number? The reason I am asking is that
> > I hope to get rid of parent/child pointers in serio (they were
> > introduced when driver core could not handle recursive addition/removing
> > of devices on the same bus).
>
> I am afraid you can't generate just any unique number to represent the
> lock class, as the lockdep validator fails if the class number is higher
> than MAX_LOCKDEP_SUBCLASSES, which is by default 8.
>
> Regarding the patches - should I submit them upstream, or will you?
>

Not yet ;) Is there a way to hide the depth in the spinlock/mutex
structure itself so that initialization code could do
spin_lock_init_nested() and spare the rest of the code from that
knowledge?

-- 
Dmitry
