Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUDZUcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUDZUcx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbUDZUcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:32:53 -0400
Received: from gprs214-184.eurotel.cz ([160.218.214.184]:65152 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263457AbUDZUcv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:32:51 -0400
Date: Mon, 26 Apr 2004 22:32:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: ncunningham@linuxmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
Message-ID: <20040426203238.GA24587@elf.ucw.cz>
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl> <20040424183505.GB2525@elf.ucw.cz> <408B7C13.1000708@pointblue.com.pl> <20040425204506.GG24375@elf.ucw.cz> <408D6F77.4060303@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <408D6F77.4060303@pointblue.com.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Funny, now it doesn't run BUG(), but, instead I have two way behavior. 
> >>Either he is complaining that bash
> >>will not stop !! or that there is not enough pages free. Both wrong and 
> >>bizzareus. This really needs fixing before 2.6.6 is out (imo).
> >
> >Dump stack at time when process refuses to stop, and see why it can't
> >be stopped. Then fix that :-).
> >
> Quite easy to say. I don't really understeand all changes that 've been 
> done over mm between 2.6.6-rc2-bk2 and 2.6.5.

I know its easy to say ;-).

> Simple example. Mount something over nfs, than disconnect your network 
> cable, and inside that dir run ls.
> Kernel will not be able to freeze bash !!, obvioulsy bug. I'll try to 
> investigate it my self, but if someone can get with fast explanation, to 
> enlight me problem, that would be nice.

Not obviously, and try to use less "!"s.

If you disconnect your /dev/hda, you'll not be able to suspend. Bug?
I'd call it design decision that allows me to keep it reasonably
simply. And I'd say that disconnected nfs is similar issue.

Anyway, feel free to submit a patch, and if it is simple enough, I'll
probably take it.

> Nfs is maybe a tougth example. Try i.e. dd bs=1 (to make it slower) 
> if=/proc/kmem of=/dev/null,
> or even open mc, and press F3 on /proc/kmem, providing that your 
> machines is slow.  At that point, MC on my computer eats about  900MB of 
> swap ! (I  have only 128MB of ram, so it's quite strange). Anyways,
> echo "4" >/proc/acpi/sleep, and kernel will not be able to freeze
> it.

If you do something stupid, its okay that kernel is not able to
suspend. F3 on /dev/kmem counts as "something stupid". If you find out
something normal user (not root) can do... we are more likely to fix
that.

I'd say that /dev/kmem issue is not worth fixing. NFS issue may be
worth fixing, but I do not use NFS that much. Any other problems?
 
								Pavel
-- 
934a471f20d6580d5aad759bf0d97ddc
