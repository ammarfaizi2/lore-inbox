Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315588AbSEIBp5>; Wed, 8 May 2002 21:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315589AbSEIBp4>; Wed, 8 May 2002 21:45:56 -0400
Received: from zok.SGI.COM ([204.94.215.101]:60590 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S315588AbSEIBpz>;
	Wed, 8 May 2002 21:45:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Daniel Jacobowitz <dan@debian.org>
Cc: Alexander.Riesen@synopsys.com, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: Your message of "Wed, 08 May 2002 20:55:46 -0400."
             <20020509005546.GA14348@nevyn.them.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 11:44:38 +1000
Message-ID: <14619.1020908678@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002 20:55:46 -0400, 
Daniel Jacobowitz <dan@debian.org> wrote:
>On Thu, May 09, 2002 at 10:10:19AM +1000, Keith Owens wrote:
>> On Wed, 8 May 2002 19:25:57 +0200, 
>> Alex Riesen <Alexander.Riesen@synopsys.com> wrote:
>> >i've found the reason: the make's stdin was redirected in /dev/null
>> >(my make is aliased to a program prettifying output).
>> 
>> Use standard make.
>
>Wouldn't you call it a bug anyway if running
>'make -f Makefile-2.5 oldconfig < /dev/null' went on to build a kernel? 
>That's pretty surprising behavior.
>
>(Not saying that that does happen, but it's how I read Alex's message)

It would be a bug, that is not what is causing the problem.
make oldconfig < /dev/null breaks on both kbuild 2.4 and 2.5, oldconfig
requires input.  If you want no prompts with oldconfig taking defaults
for new values then

  yes '' | make oldconfig (kbuild 2.4)
  make defconfig (kbuild 2.5)

I cannot reproduce Alex's problems using standard make or gmake.  It is
almost certainly a problem with his version of make or the wrapper
around it, it is introducing spurious targets.  If the problem occurs
using standard GNU make then I will look at it.

