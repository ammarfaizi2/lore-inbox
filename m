Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWGBDBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWGBDBk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 23:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWGBDBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 23:01:40 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:45283 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751542AbWGBDBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 23:01:40 -0400
Date: Sun, 2 Jul 2006 05:01:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Miles Lane <miles.lane@gmail.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm5 -- Busted toolchain? -- usr/klibc/exec_l.c:59: undefined reference to `__stack_chk_fail'
Message-ID: <20060702030121.GA7247@mars.ravnborg.org>
References: <a44ae5cd0607011409m720dd23dvf178a133c2060b6d@mail.gmail.com> <1151788673.3195.58.camel@laptopd505.fenrus.org> <a44ae5cd0607011425n18266b02s81b3d87988895555@mail.gmail.com> <1151789342.3195.60.camel@laptopd505.fenrus.org> <a44ae5cd0607011537o1cf00545td19e568dcb9c06c1@mail.gmail.com> <a44ae5cd0607011556t65b22b06m317baa9a47ff962@mail.gmail.com> <20060701230635.GA19114@mars.ravnborg.org> <44A706C4.7070908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A706C4.7070908@zytor.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2006 at 04:35:32PM -0700, H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> >
> >For klibc you need to patch scripts/Kbuild.klibc
> >
> >Appending it to KLIBCWARNFLAGS seems the right place.
> >
> >Do you know from what gcc version we can start using -fno-stack-protector?
> >
> 
> Here is a patch for klibc.  Miles, could you try it out and see if it 
> does what you need?
> 
> 	-hpa
> 
  
> -KLIBCREQFLAGS     :=
> +KLIBCREQFLAGS     := $(call cc_option, -fno-stack-protector, )

This needs to be $(call cc-option, ...)
'-' not '_'.

> +++ b/usr/klibc/arch/arm/MCONFIG
> @@ -12,7 +12,7 @@ CPU_TUNE := strongarm
>  
>  KLIBCOPTFLAGS = -Os -march=$(CPU_ARCH) -mtune=$(CPU_TUNE)
>  KLIBCBITSIZE  = 32
> -KLIBCREQFLAGS = -fno-exceptions
> +KLIBCREQFLAGS += -fno-exceptions

This should be fixed for KLIBCOPTFLAGS also. Unrelated to this issue.

	Sam
