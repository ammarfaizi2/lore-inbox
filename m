Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285588AbRLGVz6>; Fri, 7 Dec 2001 16:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285584AbRLGVzo>; Fri, 7 Dec 2001 16:55:44 -0500
Received: from codepoet.org ([166.70.14.212]:5895 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S285577AbRLGVzg>;
	Fri, 7 Dec 2001 16:55:36 -0500
Date: Fri, 7 Dec 2001 14:55:35 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: On re-working the major/minor system
Message-ID: <20011207145535.A18152@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C10A057.BD8E1252@evision-ventures.com> <E16CJnv-0005c0-00@the-village.bc.nu> <20011207135100.A17683@codepoet.org> <9urbtm$69e$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9urbtm$69e$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: 2.4.13-ac8-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 07, 2001 at 01:21:58PM -0800, H. Peter Anvin wrote:
> Followup to:  <20011207135100.A17683@codepoet.org>
> By author:    Erik Andersen <andersen@codepoet.org>
> In newsgroup: linux.dev.kernel
> > 
> > Right.  Tons of apps have illicit insider knowledge of kernel
> > major/minor representation and NEED IT to do their job.  Try
> > running 'ls -l' on a device node.  Wow, it prints out major and
> > minor number.  You can pack up a tarball containing all of /dev
> > so tar has to has insider major/minor knowledge too -- as does
> > the structure of every existant tarball!  Check out, for example,
> > Section 10.1.1 (page 210) of the IEEE Std. 1003.1b-1993 (POSIX)
> > and you will see every tarball in existance stores 8 chars for
> > the major, and 8 chars for the minor....
> > 
> 
> Actually, it's not "tons of apps", it's in the C library itself.

The C library, and the POSIX standard, etc, etc.

> These things are defined in <sys/sysmacros.h> and anyone who uses
> anything else should be taken out and shot.

Ok, so we go through, change sys/sysmacros.h, tar.h, cpio.h, and
any other offending header file.  And guess what?  Not only has
nothing changed (since those are macros, not functions), but you
just broke every older .deb and .rpm in existance on your updated
system.

In sys/sysmacros.h it defines major() and minor() as macros, so
just dropping in an updated C library binary isn't going to do
squat until all of userspace gets recompiled.  And tar.h and
cpio.h define long standing (well over 10 years now) binary
structures.  We can't just go changing this stuff, since now when
a dev_t is some magic cookie, if I go to install something from
my old Debian 1.2 CD or my old RedHat 4.0 CD, my system will puke
trying to install using cookies that in fact are old 8/8 split
device nodes and not cookies at all.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
