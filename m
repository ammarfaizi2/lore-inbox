Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287784AbSAIQMg>; Wed, 9 Jan 2002 11:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSAIQMW>; Wed, 9 Jan 2002 11:12:22 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:50655 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S287784AbSAIQL4>; Wed, 9 Jan 2002 11:11:56 -0500
Message-Id: <5.1.0.14.2.20020109152921.026ad0a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 09 Jan 2002 16:14:01 +0000
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Difficulties in interoperating with Windows
Cc: lkml@andyjeffries.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200201091506.JAA16825@tomcat.admin.navo.hpc.mil>
In-Reply-To: <20020109093752.31ae1e79.lkml@andyjeffries.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 15:06 09/01/02, Jesse Pollard wrote:
> > IANAL, but I wondered why there is such difficulty with making Linux work
> > completely with Windows systems?  I guess part of it may be that Windows
> > is closed source but as reverse engineering for interoperability is legal
> > in the UK (regardless of what the End User License states), is the problem
> > that it is difficult to read the Assembly easily?
>
>That is not reverse engineering - (at least not MY understanding) - you are
>re-translating a copyrighted work.

Actually disassembly is the first and very important step in reverse 
engineering (tha is in my understanding and that is how the law sees it as 
far as I understand EU law, note IANAL... so don't take my word for it).

>If the translation back into the binary form creates the same binary then 
>you have an exact translation. You also have a lawsuit pending. Otherwise 
>you could just disassemble the entire windows OS, claim it as your 
>"re-engineered source", and sell/publish it.

You couldn't do that, no.

>This is not legal in most locations.
>
>Reverse engineering is taking the published specifications, creating 
>software that should function in an equivalent manner.

That is not true. True reverse engineering is disassembling the binary, 
determining the specifications laid down in the binary, then writing a 
program to implement those specifications (again IANAL and your legislation 
may well vary)

You are spoilt if you have the specifications already available... With 
NTFS I have spent months going through the ntfs driver disassembly in 
IDAPro (www.datarescue.com), the best disassembler there is AFAIK, 
determining how things work.

>Testing it is difficult since you have to be careful not to import 
>patented/copyrighted algorithms. You have to compair the inputs/outputs 
>for the software with the inputs/outputs of the original.

Er, you have to have the same algorithms or at least you need to achieve 
the same input and output which often requires the exact same algorithm 
otherwise you cannot achieve the same input/output...

To give a concrete example from ntfs, when collating attribute names (and 
file names for the matter) in order to determine where to place them in an 
inode, if you do not apply all collation criteria found in the windows 
driver, you will inevitably do the collation wrong at least in some corner 
cases and you have a broken filesystem on your hands when you are writing.

>The end result is usable. Linux itself can be considered a reversed 
>engineered UNIX.

I would disagree. You have all the specifications defined in all the 
standards and you are just implementing them. That has nothing to do with 
reverse engineering. That is just implementing a specification/design, that 
is normal everyday programming. Parts of Linux are reverse engineered, sure 
thing, but not the whole OS.

>At least a sufficient amount of the specifications are available.
>
>The problem with most M$ software is that the published specifications are 
>not complete, access to the inputs are not always available (it is ALSO 
>covered by the proprietary/trade secrets/other restrictions). Sometimes 
>the output is not available (at least in some countries - DMCA again).
>
>This is also the problem with some device interfaces. If the company claims
>"trade secret" or "propriatary information" then the published 
>pecifications will not be usable when reverse engineering device drivers.

You can use whatever information you like as long as you are not disallowed 
to do so by your local legislation. The EU is very liberal with regards to 
reverse engineering and the US is I gather a forbidding country.

>This problem has been attacked in the past as "it SHOULD work like this, 
>if I can find a register that looks like what I expect, then it MIGHT 
>work"... Some IDE controllers were originally developed this way - at 
>least one video board was done this way. (I think even a PCI bridge was 
>deciphered this way)
>
> > Is there not a project on Linux to convert assembly back to C?   Would
> > this be exceptionally hard?
>
>Not hard - just illegal when using it to disassemble proprietary software.
>Debuggers do this very frequently, to the point that I would say "all the
>time" except for debuggers of interpreted languages.

It is not only exceptionally hard, it completely impossible to do 
automatically. Assembler code cannot be translated to meaningful C code 
without human intervention. Of course if you have full symbolic 
information, it can be done, but no commercial software includes symbolic 
information if the company has any sense. If you were to write an asm -> C 
converter the only thing it could ever do is to name all functions and 
variables func1, func2, ... and var1, var2, etc without full type 
information, at least not C types, no names and no meanings. (That is what 
IDAPro does in fact but it keeps the code in assembler and doesn't convert 
it to C.)

The real hard core part of reverse engineering is to understand what the 
heck the functions do, why they do it, what it means and to deduce the 
specifications from that. (With ntfs we do have partial debugging symbols, 
for all functions ntfs exports to other parts of windows, and we have some 
of the function names, but by no means all.)

Comparing input/output is also very valuable in the course of reverse 
engineering but by no means sufficient because you will (almost) never find 
out all corner/special cases that way. Depending on what you are reverse 
engineering it may be sufficient but it is extremely unlikely to give you 
the full specifications.

> > Just wondered why Linux has struggled for a while to interoperate with
> > Windows completely...

Because they don't give us specifications, because they don't give us the 
source code either, and because in many countries people are not allowed to 
reverse engineer the binaries either. And even that is illegal in some 
countries. Which doesn't leave you anything much to work from...

Luckily in the EU we can do just about anything with respect to reverse 
engineering as long as the purpose is interoperability which covers ntfs 
nicely. The myth of the US being a very free country is only a myth after 
all. The EU is much freer. (-;

Best regards,

         Anton

DISCLAIMER: Parts of this email are to be taken with a pinch of salt... 
Especially any parts describing laws shouldn't be relied on as IANAL...


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

