Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVAZLID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVAZLID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 06:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262276AbVAZLID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 06:08:03 -0500
Received: from egg.hpc2n.umu.se ([130.239.45.244]:25568 "EHLO egg.hpc2n.umu.se")
	by vger.kernel.org with ESMTP id S262280AbVAZLHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 06:07:52 -0500
Date: Wed, 26 Jan 2005 12:07:50 +0100
To: linux-kernel@vger.kernel.org
Subject: Bug in 2.4.26 in mm/filemap.c when using RLIMIT_RSS
Message-ID: <20050126110750.GE7349@hpc2n.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Ake.Sandgren@hpc2n.umu.se (Ake)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use of rlim[RLIMIT_RSS] in mm/filemap.c is wrong.
It is passed down to kernel as a number of bytes but is being used as a
number of pages.

There is also a misinformative comment in fs/proc/array.c
in proc_pid_stat where it says
mm ? mm->rss : 0, /* you might want to shift this left 3 */
the number 3 should probably be PAGE_SHIFT-10.

-- 
Ake Sandgren, HPC2N, Umea University, S-90187 Umea, Sweden
Internet: ake@hpc2n.umu.se	Phone: +46 90 7866134 Fax: +46 90 7866126
Mobile: +46 70 7716134 WWW: http://www.hpc2n.umu.se
