Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288342AbSANAAG>; Sun, 13 Jan 2002 19:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288334AbSAMX75>; Sun, 13 Jan 2002 18:59:57 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:59375 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288338AbSAMX7t>; Sun, 13 Jan 2002 18:59:49 -0500
Date: Sun, 13 Jan 2002 18:59:47 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] cleanup file.h and INIT_TASK a bit
Message-ID: <20020113185947.A32700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patches does a couple of things: first off, it removes the sched.h 
include from file.h that was added recently, as we really don't need yet 
another include file chain mess.  To make this a bit more palatable, a 
few of the inlines are moved out of file.h and into fcntl.c, plus the 
files_struct is moved to file.h from sched.h.  Since this meant adding 
file.h to the various arch/*/kernel/init_task.c files, I took the time 
to move the INIT_* bits for initializing the init task out of sched.h 
and into init_task.h.  If this is okay, please apply the patch.  There 
are other cleanups to do if people are interested: the #define for init_task 
is currently duplicated in *all* asm-*/processor.h files to be exactly 
the same thing...  This is a way of testing the waters on include file 
cleanups.  Done properly, they shave ~10-15% off of the kernel compile 
time on my machine.

Oh, the file.h cleanup exposed a mess (bug): usb.c was duplicating code 
from daemonize().

		-ben
-- 
Fish.
