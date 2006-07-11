Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWGKW3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWGKW3N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWGKW3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:29:13 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:29579 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932208AbWGKW3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:29:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NUyZ72Gj3UsGXCVRYZMfDyRSaq0bzqMabhaVem15dzu9lgLHnFT+GWoMKRT5HK+X1mm+o3cAeIRvK1jRewP5bmwZPmLLjzCDegwgqncHf5VoKgX38NYeH7aoIlmEUYOh2j4y84MqihuSINhwdw/N0CJbBovSHPyzzOmmhzgOxnE=
Date: Tue, 11 Jul 2006 15:29:03 -0700
From: Clay Barnes <clay.barnes@gmail.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: short term task list for Reiser4
Message-ID: <20060711222903.GG9220@HAL_5000D.tc.ph.cox.net>
References: <44B42064.4070802@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B42064.4070802@namesys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:04 Tue 11 Jul     , Hans Reiser wrote:
> Please feel free to comment on this list and the order of its tasks:
> 
> 0) fix all bugs as they arise
> 
> 1) get batch_write into the -mm kernel --- small task
> 
> 2) get read optimization code into the -mm kernel (coded and probably
> debugged but not fully tested and not sent in yet) --- small task
> 
> 3) get EVERYTHING into wiki (migration has started already, thanks flx).
> 
> 4) review complaints of pauses while using reiser4 --- size of task
> unknown, and it is also unknown how much we may have fixed it while
> writing recent patches.
> 
> 5) review crypt-compress code --- full code review --- substantive task
> 
> 6) optimize fsync --- substantive task which requires using fixed area
> for write twice logging, and using write twice logging for fsync'd
> data.  It might require creating mount options to choose whether to
> optimize for serialized sequential fsyncs vs. lazy fsyncs.
With the serialized sequential fsync, is that essentially what I was
talking about earlier with slowly streaming dirty writes to disk when
the HDD is idle?  If that's the case, I don't see the advantage in having
lazy fsyncs except in situations where you want to keep the HDD spun down
as much as possible.  If you keep as much of the writes in RAM as you
would have if you used lazy fsyncs, then you get the same temporal
locality speed up, with the added advantages that you can clear the RAM
under memory pressure immediately and crashes result in lower likelyhood
of data loss than with lazy fsync.  I suppose it isn't a bad idea to give
people more options (unless you're a GNOME UI developer :-P), but at the
very least I think that slow streaming to disk would be a very wise
default option.

My CS focus is Human Interfaces, so I may be way out of my league here
with FSs, but I thought I'd still throw in my two cents.
> 
> 7) review all of our installation instructions --- I am already doing
> that, but volunteers who will help out our wiki would be sorely
> appreciated.  Installing reiser4 as the root for each distro needs
> step-by-step instructions.
I've been meaning to hose my laptop (assuming I fix one problem with my
desktop), so I am willing to help write Gentoo install docs (or possibly
Arch Linux).  I can also test exsiting instructions.
> 
> 8) review our kernel documentation --- I should do that but when will I
> have time?
> 
> Unfortunately, our code stability is going to decrease for a bit due to
> all these changes to the read and write code --- no way to cure that but
> passage of time.   On the other hand, our CPU usage went way down. 
> Reiser4's only performance weakness now is fsync.  
> 
> Once the crypt-compress code is ready, we will release Reiser4.1-beta
> (with plugins, releasing a beta means telling users that if they mount
> -o reiser4.1-beta then cryptcompress will be their default plugin, and
> if they don't, then they are using Reiser4.0 still).  Doubling our
> performance and halving our disk usage is going to be fun.


--Clay
