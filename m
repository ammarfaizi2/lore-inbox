Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264929AbSJ3Uy7>; Wed, 30 Oct 2002 15:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264930AbSJ3Uy6>; Wed, 30 Oct 2002 15:54:58 -0500
Received: from hamal.ipal.net ([209.102.192.71]:24490 "EHLO hamal.ipal.net")
	by vger.kernel.org with ESMTP id <S264929AbSJ3Uy6>;
	Wed, 30 Oct 2002 15:54:58 -0500
Date: Wed, 30 Oct 2002 15:01:22 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.20-pre11 mounts initrd read/only
Message-ID: <20021030150122.A25561@hamal.ipal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just finished helping someone (who was trying to build a bootable CD
using my BICK package) debug why they were getting a failure with
2.4.20-pre11, but things worked OK with 2.4.18.  After several cycles
of "try this" and finally getting his kernel output captured via a
serial port, I found the problem.  The initial ram disk mounted at /
was being mounted read/only in 2.4.20-pre11 whereas it was mounted
read/write in 2.4.18 (I haven't tested 2.4.19 yet because previously
upgrading the kernel on a rescue CD wasn't a priority).

The work around is to either specify "rw" in the boot parameters or to
do a remount to remove the read/only bit during initialization.  The
next version of BICK will have this dealt with.

I suspect this was just a change being made to default to read/only for
hard disk mounted root filesystems.  I can see maybe a few suprises it
might cause, but mostly no problems.  But it could be more problematic,
or at least confusing, for initial ram disk situations.  Maybe it should
test for whether / is initrd and turn off MS_RDONLY if so.

ref:  http://freshmeat.net/projects/bick/

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://ka9wgn.ham.org/    |
-----------------------------------------------------------------
