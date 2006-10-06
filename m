Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWJFMxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWJFMxo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 08:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWJFMxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 08:53:44 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:2666 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S1751362AbWJFMxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 08:53:43 -0400
Date: Fri, 6 Oct 2006 14:53:36 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Suzuki Kp <suzuki@in.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly  - take 2
Message-ID: <20061006125336.GA27183@harddisk-recovery.nl>
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com> <20061004170827.GE18800@harddisk-recovery.nl> <4523F16D.5060808@in.ibm.com> <20061005104018.GC7343@harddisk-recovery.nl> <45256BE2.5040702@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45256BE2.5040702@in.ibm.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 01:32:34PM -0700, Suzuki Kp wrote:
> Btw, do you think it is a good idea to let the other partition checkers 
> run, even if one of them has failed ?

Yes, just let them run. Partition information doesn't need to be on the
very first sector of the drive. If the first sector is bad and the
partition table for your funky XYZ partition table format lives on the
tenth sector, then a checker that checks the first sector would fail
and prevent your checker from running.

OTOH: having ten partition checkers check the same bad first sector
doesn't really speed up the partion check process (for that reason we
disable partition checking for drives we get for recovery). A way to
solve that would be to keep a list of bad sectors: if the first checker
finds a bad sector, it notes it down in the list so the next checker
wouldn't have to try to read that particular sector. Maybe that's too
much work to do in kernel and we'd better move the partition checking
to userland.

> Right now, the check_partition runs the partition checkers in a 
> sequential manner, until it finds a success or an error.

I think it's best not to change the current behaviour and let all
partition checkers run, even if one of them failed due to device
errors. I wouldn't mind if the behaviour changed like you propose,
though.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
