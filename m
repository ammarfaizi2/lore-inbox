Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750840AbVLGLDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbVLGLDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVLGLDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:03:00 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33482 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750840AbVLGLC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:02:59 -0500
Date: Wed, 7 Dec 2005 12:02:46 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Could not suspend device [VIA UHCI USB controller]: error -22
Message-ID: <20051207110246.GA2563@elf.ucw.cz>
References: <43923479.3020305@tls.msk.ru> <20051205132143.GC7478@elf.ucw.cz> <4396B9DE.40908@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4396B9DE.40908@tls.msk.ru>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Also, "suspend to mem" does just nothing, -- the same as "suspend to disk"
> >>(but for disk, it never worked at all as stated above).
> > 
> > 
> > Can you quote exact messages? Suspend to mem should not have problems
> > without 4MB pages, as it does not do any pagetables related magic. If
> > it does include same check, it is bug and should be easy to fix.
> 
> Hmm.. There's no messages, no at all.
> 
>  echo mem > /sys/power/state
> 
> does exactly nothing.  When writing 'suspend' to that file, the
>system

I think you mean 'standby'?

> at least tries to do something (now with 2.6.15-rc4 it completes the
> syspend procedure; but it wakes up again in a secound or two), with all
> the messages et al, but not 'mem' or 'disk' - no messages at all.

You are hitting something else than missing 4MB pages:

static inline int
arch_prepare_suspend(void)
{
        /* If you want to make non-PSE machine work, turn off paging
           in swsusp_arch_suspend. swsusp_pg_dir should have identity
mapping, so
           it could work...  */
        if (!cpu_has_pse) {
                printk(KERN_ERR "PSE is required for swsusp.\n");
                return -EPERM;
        }
        return 0;
}

...so just insert printks into the code to find out what is going on...

								Pavel
-- 
Thanks, Sharp!
