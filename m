Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUIVVs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUIVVs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267998AbUIVVs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 17:48:27 -0400
Received: from gprs214-200.eurotel.cz ([160.218.214.200]:26249 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267976AbUIVVpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 17:45:42 -0400
Date: Wed, 22 Sep 2004 23:45:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: year 2038 problem on x86-64
Message-ID: <20040922214529.GA803@elf.ucw.cz>
References: <20040922213028.GE14891@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040922213028.GE14891@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> For testing (read() and write() is returning wrong value on 2.4
> kernels) I played a bit with really big numbers... And I found out we
> have year 9223372034708485227 problem ;-).

And we have some nearer problems, too.

#ifdef __ARCH_WANT_SYS_TIME

/*
 * sys_time() can be implemented in user-level using
 * sys_gettimeofday().  Is this for backwards compatibility?  If so,
 * why not move it into the appropriate arch directory (for those
 * architectures that need it).
 *
 * XXX This function is NOT 64-bit clean!
 */
asmlinkage long sys_time(int __user * tloc)
{
        int i;
        struct timeval tv;

        do_gettimeofday(&tv);
        i = tv.tv_sec;

        if (tloc) {
                if (put_user(i,tloc))
                        i = -EFAULT;
        }
        return i;
}

... __ARCH_WANT_SYS_TIME actually is set on x86-64.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
