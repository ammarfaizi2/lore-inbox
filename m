Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288827AbSAQOfB>; Thu, 17 Jan 2002 09:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288835AbSAQOev>; Thu, 17 Jan 2002 09:34:51 -0500
Received: from [195.66.192.167] ([195.66.192.167]:41480 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S288827AbSAQOeq>; Thu, 17 Jan 2002 09:34:46 -0500
Message-Id: <200201171432.g0HEW4E17589@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNC] Linld 0.94 available
Date: Thu, 17 Jan 2002 16:31:46 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[resending]

On 16 January 2002 20:13, H. Peter Anvin wrote:
> >>>>There is a much easier way to do it: intercept int 15 e801 and return
> >>>> the values in cx/dx in ax/bx.  Reading the CMOS is quite broken; it
> >>>> fails if the BIOS has reserved memory for its own uses.
> >>>
> >>>Well, it does not really matter whether we intercept fn E801 or fn 88.
> >>>The question is: where to read mem size if int 15 returns 0?
> >>>Mem scan?
> >>
> >>I told you... INT 15 AX=E801 returns memory size twice, in AX/BX and
> >>CX/DX.  DOS kills the first one, not the second one.

Ok, I brought old Turbo Debugger from home...

It is not true on this box I type this message right now. 128 MB RAM.
Under DOS:
INT 15 AX=E801 returns carry set and AH=86 (have no BIOS manual here to look 
up this error code), other registers unchanged.
INT 15 AH=88 returns AX=0.
INT 15 AX=E820 - not tested, but obviously not working (or else kernels would 
boot fine without linld/loadlin kludge or kernel patch)

So we have "triple-0" failure extracting mem size info from INT 15.


> There is a much easier way to do it: intercept int 15 e801 and return the
> values in cx/dx in ax/bx.  Reading the CMOS is quite broken; it fails if
> the BIOS has reserved memory for its own uses.

Where do you propose to get memory size in this case?


> > Agreed. I hope we will never receive a bug report about BIOS stupid
> > enough to report "triple-0" :-)
>
> Such a BIOS wouldn't boot DOS (HIMEM.SYS actually), nor Windows, so the
> likelihood of that is zero.  BIOS receive very little testing, that much
> is obvious (and I've actually had BIOS vendors tell me "we don't care"
> when they get a very detailed bug report with exact steps on how to
> reproduce), but booting DOS and Windows *does* get tested.

You're right, DOS/Win won't boot.

Just imagine old lovely 486 box never tested by manufacturer to work well 
with 64 MB of RAM. Joe Random Hacker plays Meg-o-Rama, but BIOS does not 
understand how that can be: int 15 fn 88 does not fit in 16-bit reg?!
DOS does not boot, Joe says: well, Linux rulez, it will boot! but no...

OTOH, CMOS reading hack most probably would not work either... memscan time?
--
vda
