Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUBUSoX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 13:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUBUSoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 13:44:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35973 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261600AbUBUSoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 13:44:21 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
	<Pine.LNX.4.58.0402181502260.18038@home.osdl.org>
	<20040221141608.GB310@elf.ucw.cz>
	<Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org>
	<20040221173449.GA277@elf.ucw.cz>
	<Pine.LNX.4.58.0402210944050.3301@ppc970.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Feb 2004 11:36:14 -0700
In-Reply-To: <Pine.LNX.4.58.0402210944050.3301@ppc970.osdl.org>
Message-ID: <m18yiwl1pd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 21 Feb 2004, Pavel Machek wrote:
> >
> > I'm just afraid that someone will mail you a patch replacing that with
> > >> 32 and you'll overlook it.
> 
> Well, the good news is that ">> 32" should cause gcc to complain with a 
> big warning (exactly because it's undefined brhaviour on a 32-bit 
> architecture), so I don't think it's easy to overlook.

What is wrong with the original?

-       wrmsr(MSR_IA32_UCODE_WRITE, (unsigned int)(uci->mc->bits), 0);

I don't see how anything else could be correct.

Either we have high bits we need to worry about in 32bit mode, in which
case the 32bit variant is wrong.  Or we don't have high bits to worry
about in which case attempting to set them is wrong.

Eric
