Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262424AbSJIWiJ>; Wed, 9 Oct 2002 18:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262426AbSJIWiI>; Wed, 9 Oct 2002 18:38:08 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:43168
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S262424AbSJIWiF>; Wed, 9 Oct 2002 18:38:05 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200210092243.g99MhZ701270@www.hockin.org>
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 9 Oct 2002 15:43:35 -0700 (PDT)
Cc: thockin@hockin.org (Tim Hockin),
       schwidefsky@de.ibm.com (Martin Schwidefsky),
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210091508050.24776-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 09, 2002 03:10:08 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Because Sparc64/s390x/? still need to tell highuid.h to do macro magic for
> > NEW_TO_OLD_UID() and friends in some places and not others.  A CONFIG_XXX
> > applies all the time to all files.
> 
> If __UID16 works, then renaming it to CONFIG_UID16_ONLY _must_ also work. 
> 
> I don't understand your argument about other architectures. I'm claiming 
> that __UID16 is a config option, and that it must be renamed to _show_ 
> that it is a config option.

Renaming it, if that is all you want, is fine by everyone, I'm sure.  I was
trying to make the point that it is NOT a config option, because for some
architectures, you only want it defined for SOME FILES.

architectures that define CONFIG_UID16 get high2lowuid() all the time
	- no changes needed on any of them

architectures that do not define CONFIG_UID16 and don't want it ever get
straight uids, no high2lowuid() cruft
	- no changes needed on any of them

architectures that can use uid16.c code, but do not want high2lowuid()
everywhere need to change
	- define CONFIG_UID16_SYSCALLS  (build uid16.o)
	- explicitly call out where it wants high2lowuid()
		- this was called __UID16, but can be called
		CONFIG_UID16_HERE or REALLY_DO_HIGHUID_CRAP or FRED for all
		I care.

I just want to make sure that you're telling me to name something CONFIG_FOO
when, in fact, it is defined by various bits of code that want to change the
behavior of a particular header.

In that case we can just have them define CONFIG_UID16 and not add an OR in
there at all.  I just thought you'd find a .c file defining CONFIG_FOO to be
grosser, yet.  But on further argument, I guess it's not.

I'll consider it a done deal, unless you want to stop me :)  Martin, do you
want to just change the __UID16 defines to CONFIG_UID16 and nix the || in
highuid.h and resubmit?

I have the same patch in my local tree.

Tim
