Return-Path: <linux-kernel-owner+w=401wt.eu-S1751263AbXAPR7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbXAPR7S (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbXAPR7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:59:18 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:12942 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbXAPR7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:59:17 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UqDw7AfwWUxLAJyGii7TS2jbGa3Bt0wxcAigm8hdshh9eeSYrftLr4Fx+5fBedHy/rjCKtynOvB10vWE6k7zBsg5FV9Z50hSmf1BCyS2nAgzs2mx8h0xHaIyTyX8PHCzEiBY8YlQSnqPltjCEeTo7MbgrPwE/H+QaNOJn05ZpEI=
Message-ID: <5c8016cf0701160959l1489b56t980779f1f6e49848@mail.gmail.com>
Date: Tue, 16 Jan 2007 17:59:15 +0000
From: "Giuliano Procida" <giuliano.procida@googlemail.com>
To: "Mikael Pettersson" <mikpe@it.uu.se>, rgooch@atnf.csiro.au
Subject: Re: [PATCH]: MTRR: fix 32-bit ioctls on x64_32
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200701161248.l0GCmG7O025771@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701161248.l0GCmG7O025771@harpo.it.uu.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 16/01/07, Mikael Pettersson <mikpe@it.uu.se> wrote:
> On Tue, 16 Jan 2007 08:14:30 +0000, Giuliano Procida wrote:
> These #ifdefs are too ugly.

Agreed that the #ifdefs are rather ugly, but they were the smallest change.
Whoever wrote the original compat changes was relying on the IOC
constants being different for 32- and 64-bit userspace. This allowed the
lazy reuse of the whole ioctl function rather than having to write a complete
replacement compat_ioctl for fops.

> Since you apparently just add aliases for the case labels,
> and do no actual code changes, why not
> 1. make the new cases unconditional, or

The constants are only visible under CONFIG_COMPAT. I think they
should stay that way.

> 2. invoke a translation function before the switch which
>    maps the MTRRCIOC32_ constants to what the kernel uses

Other things I considered:

3. write a wrapper compat function that calls the original, make the
original pure 64-bit
4. macroise the case labels away somehow
5. update cmd in place (cannot do this as it re-used in the third switch)
6. add real_cmd and switch on that instead (your 2.),
   requires yet another switch and #ifdef.

It might be nicer to decode the IOC constants and use action, size and R/W flags
to control all the switches. Not sure myself.

Giuliano.
