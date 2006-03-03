Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWCCTmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWCCTmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 14:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWCCTmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 14:42:54 -0500
Received: from mail.dvmed.net ([216.237.124.58]:63888 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751326AbWCCTmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 14:42:54 -0500
Message-ID: <44089C34.2030604@garzik.org>
Date: Fri, 03 Mar 2006 14:42:44 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Steve Byan <smb@egenera.com>, Mark Lord <lkml@rtr.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Douglas Gilbert <dougg@torque.net>, Mark Rustad <mrustad@mac.com>,
       linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sg regression in 2.6.16-rc5
References: <E94491DE-8378-41DC-9C01-E8C1C91B6B4E@mac.com> <4404AA2A.5010703@torque.net> <20060301083824.GA9871@merlin.emma.line.org> <Pine.LNX.4.64.0603011027400.22647@g5.osdl.org> <4405E8AA.1090803@rtr.ca> <Pine.LNX.4.64.0603011036110.22647@g5.osdl.org> <CF493E39-B369-46D8-85EE-013F2484F1C6@egenera.com> <Pine.LNX.4.64.0603031035140.22647@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603031035140.22647@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> For example, I think the IDE driver defaults to a maximum transfer of 256 
> sectors, and the same number of max scatter-gather entries. Some 
> controllers will actually lower that, due to silly hw problems.

Yep.  Just to be specific:

256 max sectors IDE driver, 200 max sectors libata (due to driver not 
hardware).

256 max s/g entries hardware limit, but due to a IOMMU merging worst 
case libata (IDE driver too?) winds up with a 128 entry practical limit.

Newer SATA controllers eliminate the s/g entry limit and DMA boundary 
limits, but its still 256 max-sectors for ATAPI (64k for LBA48 ATA).

	Jeff


