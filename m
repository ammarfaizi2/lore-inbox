Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbSJIRdA>; Wed, 9 Oct 2002 13:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261875AbSJIRdA>; Wed, 9 Oct 2002 13:33:00 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:10399
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S261862AbSJIRcc>; Wed, 9 Oct 2002 13:32:32 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200210091738.g99HcBY15929@www.hockin.org>
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Wed, 9 Oct 2002 10:38:11 -0700 (PDT)
Cc: schwidefsky@de.ibm.com (Martin Schwidefsky), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210091022050.7355-100000@home.transmeta.com> from "Linus Torvalds" at Oct 09, 2002 10:24:04 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Use common code for 16 bit user/groud id system calls on s390x.
> 
> Please make this use the real CONFIG_UID16_SYSCALLS instead of using a 
> magic __UID16 thing that is s390x-specific. Then you make everybody who 
> currently uses CONFIG_UID16 do both CONFIG_UID16 and 
> CONFIG_UID16_SYSCALLS.
> 
> We don't want magic config options like __UID16 that aren't exposed as 
> config options and make people go "Huh?!".


Linus, This is actually something I sent to Martin (and DaveM).  The __UID16
crap is because s390x and Sparc64 (and others?) do not want the highuid
stuff except in very specific places - namely compat code.  Just using
CONFIG_UID16_SYSCALLS has the same bad side-effect as CONFIG_UID16 - all or
nothing.  In short, we want to build uid16.o with highuid translations, and
a few other compat objects, but not everything.  Ugly.

I wasn't aware Martin had tried to push this one quite yet.  Have a
preferred solution?  I'd already passed this by DaveM and he said the fun
would be getting it past you :)

Tim
