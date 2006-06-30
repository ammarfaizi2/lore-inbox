Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWF3XPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWF3XPl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWF3XPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:15:41 -0400
Received: from terminus.zytor.com ([192.83.249.54]:61162 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932233AbWF3XPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:15:40 -0400
Message-ID: <44A5B07E.9040007@zytor.com>
Date: Fri, 30 Jun 2006 16:15:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, klibc@zytor.com, torvalds@osdl.org
Subject: Re: klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru>
In-Reply-To: <44A5AE17.4080106@tls.msk.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Pavel Machek wrote:
> [klibc/kinit in kernel]
>> I'd like to eventually move swsusp out of kernel, and klibc means I
>> may be able to do that without affecting users. Being in kinit is good
>> enough, because I can actually share single source between kinit
>> version and suspend.sf.net version.
> 
> Heh.  Take a look at anyone who's using real initramfs for their boot
> process.  Not initrd, not kernel-without-any-preboot-fs, but real
> initramfs.  For them, if kinit/klibc will be in kernel, nothing changes,
> because their initramfs *replaces* in-kernel code and future supplied-
> with-kernel-klibc-based-kinit.  So if you'll move swsusp into kinit,
> it WILL break setups for those users!.. ;)
> 

There are two ways to deal with this.

Either the kernel can unconditionally invoke /kinit, which then would 
invoke the users /init if present, or the swsusp can be a separate 
initramfs binary which the user's initramfs gets to invoke (the second 
is arguably neater, but requires minor changes to the users initramfs.)

Either way, it's a trivial problem to solve.

	-hpa

