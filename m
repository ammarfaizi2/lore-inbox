Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbTBEXD0>; Wed, 5 Feb 2003 18:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbTBEXD0>; Wed, 5 Feb 2003 18:03:26 -0500
Received: from p508EF5E1.dip.t-dialin.net ([80.142.245.225]:14209 "EHLO
	oscar.local.net") by vger.kernel.org with ESMTP id <S265126AbTBEXDZ>;
	Wed, 5 Feb 2003 18:03:25 -0500
Date: Thu, 6 Feb 2003 00:12:59 +0100
From: Patrick Mau <mau@oscar.ping.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: pdflush in D state
Message-ID: <20030205231259.GA5339@oscar.ping.de>
Reply-To: Patrick Mau <mau@oscar.ping.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have a strange observation regarding the pdflush kernel threads.
My system has 512MB RAM. The behavior is independand of the filesystem
type in use. I have tested ext2, ext3 and reiserfs.

The scenario goes like this:

- Create a new filesystem on a spare partition.
  All other partitions on this disk are NTFS and
  not mounted.
  
- Copy the whole XFree source there.

- "sync ; sync ; sync" and wait a few minutes
  (I really tried waiting more than 5 minutes)
  
- now there are 400MB used by the page cache

- start the build with "make World"

XFree creates its Makefiles using "imake".
After that it tries to remove many non-existant files to clean
the source tree.

This goes extremly fast, but after a few seconds pdflush
gets stuck in D state and tries to write back dirty pages.
The machine is completly unresponsive and "top" reports
75 percent IO wait time. The actual build has not even started.

I have no idea what pdflush is trying to do ...
The files are already written and there is no other disk
activity involved. I even tried single-user mode.

The kernel is BK current 2.5.59, the machine is a P4@2.4 GHz.

Has somebody else observed this ?

cheers,
Patrick
