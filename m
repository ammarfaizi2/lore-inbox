Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTFXKMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 06:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTFXKMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 06:12:32 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:25066 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S261823AbTFXKMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 06:12:31 -0400
Date: Tue, 24 Jun 2003 12:25:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Re: Provide example copy_in_user implementation
Message-ID: <20030624102551.GE159@elf.ucw.cz>
References: <20030624100610.GC159@elf.ucw.cz> <20030624111820.D6478@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030624111820.D6478@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 24-06-03 11:18:20, Russell King wrote:
> On Tue, Jun 24, 2003 at 12:06:10PM +0200, Pavel Machek wrote:
> > This patch adds example copy_in_user implementation (copy_in_user is
> > needed for new ioctl32 implementation, all 64bit archs will need
> > it)... Please apply,
> 
> get_user / put_user on byte quantities may be faster than using
> copy_from_user/copy_to_user on byte quantities.  Yes, it may be
> a generic implementation, but there's no point in purposely making
> it inefficient.

Actually, it seems that most architectures do...

static inline unsigned long
__copy_from_user(void *to, const void __user *from, unsigned long n)
{
        if (__builtin_constant_p(n)) {
                unsigned long ret;

                switch (n) {
                case 1:


...so it should be exactly as fast. Ahha, not arm.

If I wanted to optimize it, first step would be to copy over something
else than bytes. I'm afraid I do not want to optimize it.
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
