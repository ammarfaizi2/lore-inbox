Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbUAFLDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 06:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbUAFLDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 06:03:11 -0500
Received: from main.gmane.org ([80.91.224.249]:11241 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261868AbUAFLDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 06:03:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: RAID1 resync speed in 2.6.0
Date: Tue, 06 Jan 2004 12:03:07 +0100
Message-ID: <yw1xhdz9xrtg.fsf@ford.guide>
References: <yw1xptdy15hu.fsf@ford.guide>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:598gpIUXdmbVxOIKQSUCZtm45Qs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> I just set up a largish (~100 GB) RAID1 array under Linux 2.6.0.  Now,
> /proc/mdstat is happily telling me that the resync will be completed
> in 3700 minutes.  This seems terribly slow to me.  At first, it
> wouldn't work at all, complaining about "bio too big", so I changed
> RESYNC_BLOCK_SIZE to 32k.

I found it.  It's a raid1 on top of raid0.  Apparently the raid1
resync considered the I/O from the raid0 devices to the physical disks
as normal I/O and reduced the speed.  I increased the min rate in
/proc/... and now it's resyncing at 40 MB/s.  Much better.

-- 
Måns Rullgård
mru@kth.se

