Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTJaNts (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 08:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263312AbTJaNts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 08:49:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18134 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263088AbTJaNtq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 08:49:46 -0500
Date: Fri, 31 Oct 2003 13:49:45 +0000
From: Matthew Wilcox <willy@debian.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Make fs operations const
Message-ID: <20031031134945.GT25237@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The 54k patch at http://ftp.linux.org.uk/pub/linux/willy/patches/fs-const.diff
makes many file_operations, dentry_operations, address_space_operations,
inode_operations, super_operations and dquot_operations const.

This was inspired by intermezzo doing something naughty which the
compiler didn't know to warn about.  By making these pointers point to
const structs, the compiler knows we shouldn't be doing that and will
issue a warning.

As a bonus for the embedded people, this enables us to move more of the
kernel into ROMmable sections.  I've only done this for ext2 and a few
well-known *_operations in this patch, but it could be done to many
more filesystems.  It only saves a few hundred bytes per filesystem,
but it all adds up.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
