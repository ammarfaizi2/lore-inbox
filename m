Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWJEWhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWJEWhW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWJEWhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:37:22 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:29199 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932396AbWJEWhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:37:20 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ohci1394 regression in 2.6.19-rc1 (was Re: Merge window closed: v2.6.19-rc1)
Date: Thu, 5 Oct 2006 23:37:17 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <200610052132.11544.s0348365@sms.ed.ac.uk> <4525842F.3040109@s5r6.in-berlin.de>
In-Reply-To: <4525842F.3040109@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052337.17805.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 23:16, Stefan Richter wrote:
[snip]
> It does indeed look like the nodemgr kicked in prematurely. After some
> other messages from lower levels and from different contexts, there is
> also a sign of nodemgr_check_irm_capability() failing (it can only fail
> this early):
>
> [   40.298112] ieee1394: Current remote IRM is not 1394a-2000 compliant,
> resetting...
>
> OK. Enough with the boring details. Maybe the following patch doesn't
> work entirely as I intended:
> "ieee1394: nodemgr: switch to kthread api, replace reset semaphore"
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
>itdiff_plain;h=d2f119fe319528da8c76a1107459d6f478cbf28c
>
> I think if you revert the next patch first...
> "ieee1394: nodemgr: convert nodemgr_serialize semaphore to mutex"
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
>itdiff_plain;h=cab8d154e2ed43fe1495aa0e18103e747552891b
>
> ...you can then revert the 'switch to kthread' patch and see if the
> message "Running dma failed because Node ID is not valid" disappears.
> Would be nice if you could test that.

Of course. I tried reverting these two, and it has not helped.

-rw-r--r--  1 root root 562133 2006-10-05 23:29 kernel/drivers/ieee1394/ieee1394.ko

(KBUILD only regenerated this file, I hope that's correct.)

http://devzero.co.uk/~alistair/ieee1394/dmesg-2.6.19-rc1-reverts.gz

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
