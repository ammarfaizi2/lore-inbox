Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267577AbTAQQL4>; Fri, 17 Jan 2003 11:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbTAQQLy>; Fri, 17 Jan 2003 11:11:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:23051 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267560AbTAQQLd>;
	Fri, 17 Jan 2003 11:11:33 -0500
Date: Fri, 17 Jan 2003 17:19:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mikael Pettersson <mikpe@csd.uu.se>, kai@tp1.ruhr-uni-bochum.de,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.5.59 vmlinux.lds.S change broke modules
Message-ID: <20030117161909.GA1040@mars.ravnborg.org>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <15911.64825.624251.707026@harpo.it.uu.se> <20030117135638.A376@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117135638.A376@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2003 at 01:56:38PM +0000, Russell King wrote:
> Well:
> 
>         __start___ksymtab = .;                                          \
>         __ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {         \
>                 *(__ksymtab)                                            \
>         }                                                               \
>         __stop___ksymtab = .;                                           \
> 
> breaks on some ARM binutils (from a couple of years ago.)  The most
> reliable way we've found in with ARM binutils is to place the symbols
> inside the section - this appears to work 100% every single time and
> I've never had any reports of failure (whereas I did with the symbols
> outside as above.)

quote from 'info ld'
--------------
the address of the output section will be set to the current value of
the location counter aligned to the alignment requirements of the
output section.  The alignment requirement of the output section is the
strictest alignment of any input section contained within the output
section.
--------------

In other words, the value of __start___ksymtab may differ placed inside
or outside {}, if . is not aligned according to the rules above.
Was it binutils that faulted, or may ARM has been hit by this?

Usually vmlinux.lds.S files has a lot of un-commented . = ALIGN(N);
spread all over, that may have saved us several times in the past.

	Sam
