Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWFBFLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWFBFLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 01:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFBFLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 01:11:12 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:26033 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750763AbWFBFLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 01:11:12 -0400
Date: Fri, 2 Jun 2006 07:11:00 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: Janos Haar <djani22@netcenter.hu>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: XFS related hang (was Re: How to send a break? - dump from frozen
 64bit linux)
In-Reply-To: <20060602080406.C530100@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0606020702390.25989@yvahk01.tjqt.qr>
References: <9a8748490605280917l73f5751cmf40674fc22726c43@mail.gmail.com>
 <01d801c6827c$fba04ca0$1800a8c0@dcccs> <01a801c683d2$e7a79c10$1800a8c0@dcccs>
 <200605301903.k4UJ3xQU008919@turing-police.cc.vt.edu>
 <1149038431.21827.20.camel@localhost.localdomain>
 <20060531143849.C478554@wobbly.melbourne.sgi.com> <00f501c68488$4d10c080$1800a8c0@dcccs>
 <Pine.LNX.4.61.0605312353530.30170@yvahk01.tjqt.qr> <00d901c6854d$1fc49230$1800a8c0@dcccs>
 <Pine.LNX.4.61.0606011143410.3533@yvahk01.tjqt.qr>
 <20060602080406.C530100@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Too bad XFS does not reinit quota on these commands:
>> 
>> qutoaoff /mp
>> quotaon /mp
>
>Hmm, remount would be saner if we wanted to take that approach...
>
quotacheck would be sanest :) But the struct super_block->remount is 
probably the best idea in kernel space.

>> Yes, it would lock the filesystem for a moment, but that's better than 
>> trying to unmount it under someone having inodes open!
>
>But its not just a moment, a quotacheck needs to scan every inode
>in the filesystem (on disk) to correctly account for all space/inode
>usage.

Yeah right, XFS was designed for large systems rather than for just 
my 262188 files. (The latter of which completes in an "adequate" time of 
a few secs.)

>Its not something to be encouraging people to do frequently,
>
Certainly not, but XFS has the advange of bulkstat for quota scanning.
`quotacheck` on vfsv0 quota databases always takes longer IMO.

>and it would also be very difficult to correctly implement (while the
>filesystem is actively being modified I mean).
>
Noted.


Jan Engelhardt
-- 
