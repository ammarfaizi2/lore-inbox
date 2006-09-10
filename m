Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWIJTuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWIJTuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 15:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWIJTuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 15:50:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8644 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964794AbWIJTuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 15:50:12 -0400
Date: Sun, 10 Sep 2006 21:49:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Piotr Gluszenia Slawinski <curious@zjeby.dyndns.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: swsusp problem
Message-ID: <20060910194955.GA1841@elf.ucw.cz>
References: <Pine.LNX.4.63.0609100119180.2685@Jerry.zjeby.dyndns.org> <200609101133.32931.rjw@sisk.pl> <Pine.LNX.4.63.0609102123080.2685@Jerry.zjeby.dyndns.org> <20060910192716.GB5308@elf.ucw.cz> <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609102137240.2685@Jerry.zjeby.dyndns.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >What kind of machine is that? What cpu? Really 486?
> 
> yes, it's viglen dossier 486 based laptop .

Forget it, this thing does not support 4MB pages, and swsusp currently
needs them. (We'll need to fix that, but not now -- fix is port of
page-table handling code from x86-64).

It should die with

        if (!cpu_has_pse) {
                printk(KERN_ERR "PSE is required for swsusp.\n");
                return -EPERM;
        }

...can you investigate why it does not?

							Pavel

> cpuinfo detects it as 'GenuineIntel'
> cpu family : 4
> model : 3
> model name : 486 DX/2
> stepping : 6
> cache_size : 0k
> fdiv_bug : no
> hlt_bug : no
> f00f_bug : no
> coma_bug : no
> fpu : yes
> fpu_exception : yes
> cpuid level : 1
> wp : yes
> flags : fpu vme pse
> bogomips : 31.55

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
