Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbWGFAi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbWGFAi0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWGFAi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:38:26 -0400
Received: from fmr17.intel.com ([134.134.136.16]:30893 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S965096AbWGFAiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:38:25 -0400
Date: Wed, 5 Jul 2006 17:36:39 -0700
From: Valerie Henson <val_henson@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>
Subject: Blatant layering violations (was Re: ext4 features)
Message-ID: <20060706003638.GL5231@goober>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060703205523.GA17122@irc.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 10:55:23PM +0200, Tomasz Torcz wrote:
> 
>   ZFS was already called ,,blatant layering violation''. ;)

I kind of like the phrase "blatant layering violation" - catchy, isn't
it?  The main reason people think of ZFS as a blatant layering
violation is because it has the letters "FS" in the name, but it does
a lot more than a file system.  ZFS actually includes three distinct
layers with well-defined interfaces, none of which directly maps to
most people's conception of a "file system."

The really painfully short summary of the layers is:

SPA - Storage Pool Allocator, disks go into the bottom, virtually
addressed, explicitly freed/allocated blocks come out of the top

DMU - Data Management Unit, virtually addressed blocks go in the
bottom, plain objects come out the top (an object is like a file with
no dangly bits like permissions, etc.)

ZPL - ZFS POSIX Layer, plain objects go in the bottom, VFS ops come
out the top

For a really nice, much more detailed ZFS source tour, see:

http://www.opensolaris.org/os/community/zfs/source/

-VAL
