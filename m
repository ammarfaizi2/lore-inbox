Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267389AbUIOUX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267389AbUIOUX4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUIOUV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:21:57 -0400
Received: from holomorphy.com ([207.189.100.168]:45982 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267378AbUIOUUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:20:52 -0400
Date: Wed, 15 Sep 2004 13:20:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roger Luethi <rl@hellgate.ch>
Cc: Albert Cahalan <albert@users.sf.net>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton OSDL <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Paul Jackson <pj@sgi.com>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040915202028.GV9106@holomorphy.com>
References: <20040914092748.GA11238@k3.hellgate.ch> <20040914153758.GO9106@holomorphy.com> <20040914160150.GB13978@k3.hellgate.ch> <20040914163712.GT9106@holomorphy.com> <20040914171525.GA14031@k3.hellgate.ch> <20040914174325.GX9106@holomorphy.com> <20040914184517.GA2655@k3.hellgate.ch> <20040914190747.GA9106@holomorphy.com> <20040915114430.GA28143@k3.hellgate.ch> <20040915200230.GA13621@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915200230.GA13621@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 10:02:30PM +0200, Roger Luethi wrote:
> Here's another thing we haven't been able to do with /proc: Finding out
> the relative cost of computing the elements we offer to user space.
> I ran a test program against 2.6.9-rc2-bk1 + nproc to get:
> Testing all process fields, best out of 10
> FieldID    CPU (s)  Wall (s) Label
> 0x03000002 0.140000 0.202728 NOP
> 0x21000100 0.150000 0.210021 Name
> 0x22000105 0.120000 0.204886 PID
> 0x22000109 0.130000 0.205319 UID
> 0x22000117 0.140000 0.215275 VmSize
> 0x22000118 0.130000 0.214240 VmLock
> 0x22000119 0.120000 0.214870 VmRSS
> 0x22000120 0.160000 1.020574 VmData
> 0x22000121 0.140000 1.021185 VmStack
> 0x22000122 0.170000 1.021619 VmExe
> 0x22000123 0.170000 1.020045 VmLib
> 0x23000421 0.140000 0.220748 wchan
> Ignore the absolute values (I requested each field individually for all
> processes on my workstation, 1000 times). The cost of walking all vmas
> for VmData & Co. is very visible.

Try this again after applying my updates, which make it equivalent to the
algorithms used internally by fs/proc/task_mmu.c.


-- wli
