Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbTFXKrj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTFXKri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:47:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32530 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261936AbTFXKr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:47:26 -0400
Date: Tue, 24 Jun 2003 12:01:31 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Provide example copy_in_user implementation
Message-ID: <20030624120131.F6478@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, torvalds@transmeta.com,
	kernel list <linux-kernel@vger.kernel.org>,
	Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>
References: <20030624100610.GC159@elf.ucw.cz> <20030624111820.D6478@flint.arm.linux.org.uk> <20030624102551.GE159@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030624102551.GE159@elf.ucw.cz>; from pavel@suse.cz on Tue, Jun 24, 2003 at 12:25:51PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 12:25:51PM +0200, Pavel Machek wrote:
> On Út 24-06-03 11:18:20, Russell King wrote:
> > On Tue, Jun 24, 2003 at 12:06:10PM +0200, Pavel Machek wrote:
> > > This patch adds example copy_in_user implementation (copy_in_user is
> > > needed for new ioctl32 implementation, all 64bit archs will need
> > > it)... Please apply,
> > 
> > get_user / put_user on byte quantities may be faster than using
> > copy_from_user/copy_to_user on byte quantities.  Yes, it may be
> > a generic implementation, but there's no point in purposely making
> > it inefficient.
> 
> Actually, it seems that most architectures do...
> 
> static inline unsigned long
> __copy_from_user(void *to, const void __user *from, unsigned long n)
> {
>         if (__builtin_constant_p(n)) {
>                 unsigned long ret;
> 
>                 switch (n) {
>                 case 1:
> 
> 
> ...so it should be exactly as fast. Ahha, not arm.

Note that ARM isn't 64 bit, I'm not worried about it.  Given that code
does get cut'n'pasted about the place, I still think its a good idea.
But its your code...

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

