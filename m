Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293344AbSCUFGW>; Thu, 21 Mar 2002 00:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293326AbSCUFGH>; Thu, 21 Mar 2002 00:06:07 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38551 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293314AbSCUFFy>; Thu, 21 Mar 2002 00:05:54 -0500
Date: Thu, 21 Mar 2002 00:05:53 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Pete Zaitcev <zaitcev@redhat.com>
Subject: 2 questions about SCSI initialization
Message-ID: <20020321000553.A6704@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I've got two questions which I cannot answer just by reading
the code, so I need to refer to the institutional memory of
the hackerdom (Doug G. - I need your memory, too :)

The context is that I got a bug with oops by someone with 68 SCSI
disks, traceable to a scsi_build_commandblocks failure, with a
subsequent oops because the error patch calls scsi_unregister_device,
and scsi_unregister_device aborts with module reference check.

Now the questions:

#1: Why does scsi_build_commandblocks() allocate memory with
GFP_ATOMIC? It's not called from an interrupt or from a swap I/O
path as far as I can see.

#2: What does  if (GET_USE_COUNT(tpnt->module) != 0)  do in
scsi_unregister_device? The circomstances are truly bizzare:
a) the error code is NEVER used
b) it can be called either from module unload.
I would like to kill that check.

Thanks,
-- Pete
