Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289061AbSA0X7P>; Sun, 27 Jan 2002 18:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289065AbSA0X64>; Sun, 27 Jan 2002 18:58:56 -0500
Received: from paloma17.e0k.nbg-hannover.de ([62.181.130.17]:65501 "HELO
	paloma17.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S289062AbSA0X6z>; Sun, 27 Jan 2002 18:58:55 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Mon, 28 Jan 2002 00:58:47 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020127235855Z289062-13996+13121@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 27. January 2002 13:56, Martin Dalecki wrote:
> Linus Torvalds wrote:
>
> > In article <jeelkes8y5.fsf@sykes.suse.de>,
> > Andreas Schwab  <schwab@suse.de> wrote:
> >
> >>|> 
> >>|> Storing 30% less executable pages in memory?  Reading 30% less
> >>|> executable 
> >>|> pages off the disk?
> >>
> >>These are all startup costs that are lost in the noise the longer the
> >>program runs.
> >>
> >
> >That's a load of bull.
> >
> >Startup costs tend to _dominate_ most applications, except for
> >benchmarks, scientific loads and games/multimedia. 
> >
> Well the situation is in fact even more embarassing if you do true
> benchmarking on really long running (well that's relative of course)
> applications. I personaly did once in a time a benchmarking on the good old
> tex running trhough a few hundert pages long document. Well the -O2 version
> was actually about 15% *SLOWER* then the -Os version. That's becouse in real
> world applications, which don't do numerical calculations but most of the
> time they do "decision taking" the whole mulitpipline sceduling get's
> outwighted by the simple cache pressure thing by *far*.
>
> The whole GCC developement is badly misguided on this for *sure*. They
> develop for numerics where most programs are kind of doing a
> controlling/decision taking job.
> Well I know I should try this with the kernel one time...

I can second that.
Now that I'm running AMD Athlon's since August 1999 I found during 3D 
development/benchmarking (OpenGL/Mesa) that the following GCC flags are 
"best" for Athlon/Duron with gcc-2.95.3:

-O -mcpu=k6 -pipe -mpreferred-stack-boundary=2 -malign-functions=4 
-fschedule-insns2 -fexpensive-optimizations

I even compile the whole kernel with a little different flags setting. It is 
smaller and "faster" with them.

HOSTCFLAGS      = -Wall -Wstrict-prototypes -O -fomit-frame-pointer -mcpu=k6 
-pipe -mpreferred-stack-boundary=2 -malign-functions=4 -fschedule-insns2 
-fexpensive-optimizations

CFLAGS := $(CPPFLAGS) -Wall -Wstrict-prototypes -Wno-trigraphs -O \
          -fomit-frame-pointer -fno-strict-aliasing -fno-common

linux/arch/i386/Makefile:
ifdef CONFIG_MK7
CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null 
>/dev/null 2>&1; then echo "-march=athlon"; else echo "-mcpu=k6 -pipe 
-mpreferred-stack-boundary=2 -malign-functions=4 -fschedule-insns2 
-fexpensive-optimizations"; fi)
endif

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
