Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422788AbWJFRnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbWJFRnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422787AbWJFRnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:43:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:35306 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422785AbWJFRnp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:43:45 -0400
Message-ID: <452695CE.8080901@in.ibm.com>
Date: Fri, 06 Oct 2006 10:43:42 -0700
From: Suzuki K P <suzuki@in.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060413 Red Hat/1.7.13-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Mouw <erik@harddisk-recovery.com>
CC: lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, andmike@us.ibm.com
Subject: Re: [RFC] PATCH to fix rescan_partitions to return errors properly
  - take 2
References: <452307B4.3050006@in.ibm.com> <20061004130932.GC18800@harddisk-recovery.com> <4523E66B.5090604@in.ibm.com> <20061004170827.GE18800@harddisk-recovery.nl> <4523F16D.5060808@in.ibm.com> <20061005104018.GC7343@harddisk-recovery.nl> <45256BE2.5040702@in.ibm.com> <20061006125336.GA27183@harddisk-recovery.nl>
In-Reply-To: <20061006125336.GA27183@harddisk-recovery.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Mouw wrote:
> On Thu, Oct 05, 2006 at 01:32:34PM -0700, Suzuki Kp wrote:
> 
>>Btw, do you think it is a good idea to let the other partition checkers 
>>run, even if one of them has failed ?
> 
> 
> Yes, just let them run. Partition information doesn't need to be on the
> very first sector of the drive. If the first sector is bad and the
> partition table for your funky XYZ partition table format lives on the
> tenth sector, then a checker that checks the first sector would fail
> and prevent your checker from running.
> 
> OTOH: having ten partition checkers check the same bad first sector
> doesn't really speed up the partion check process (for that reason we
> disable partition checking for drives we get for recovery). A way to
> solve that would be to keep a list of bad sectors: if the first checker
> finds a bad sector, it notes it down in the list so the next checker
> wouldn't have to try to read that particular sector. Maybe that's too
> much work to do in kernel and we'd better move the partition checking
> to userland.
> 
> 
>>Right now, the check_partition runs the partition checkers in a 
>>sequential manner, until it finds a success or an error.
> 
> 
> I think it's best not to change the current behaviour and let all
> partition checkers run, even if one of them failed due to device
> errors. I wouldn't mind if the behaviour changed like you propose,
> though.
> 
At present, the partition checkers doesn't run, if one of the preceeding 
checker has reported an error ! *But*, some of the checkers doesn't 
report the I/O error which they came across! So, this may let others 
run. Thats not we want, right. We would like them to return I/O errors, 
and and the check_partition should let other partition checkers continue.

Comments ?

Thanks,

Suzuki
> 
> Erik
> 

