Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVALJto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVALJto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 04:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVALJto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 04:49:44 -0500
Received: from gort.metaparadigm.com ([203.117.131.12]:43494 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S261313AbVALJtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 04:49:41 -0500
Message-ID: <41E4F2DB.4010806@metaparadigm.com>
Date: Wed, 12 Jan 2005 17:50:19 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Zajkowski <jamesez@umich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sparse LUN scanning - 2.4.x
References: <41E46A59.2010205@metaparadigm.com> <cs210t$l8m$1@sea.gmane.org>
In-Reply-To: <cs210t$l8m$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Zajkowski wrote:

> On 2005-01-11 19:07:53 -0500, Michael Clark <michael@metaparadigm.com> 
> said:
>
>>> The problem is this: since LUN 0 does not show up -- specifically, 
>>> it can't read the vendor or model informaton -- the kernel SCSI scan 
>>> does not match with the table to tell the kernel to do sparse LUN 
>>> scanning... so the RAID does not appear.
>>
>
>> Add the Xserve with the BLIST_SPARSELUN flag into the 
>> blacklist/quirks table in drivers/scsi/scsi_scan.c
>
>
> It already is in the quirks list.
>
> The problem is that LUN 0 does not show up on this machine, so the 
> quirks table doesn't work.  Looking at /proc/scsi/scsi shows the 
> device but only sorta:
>

Okay. I believe there is a patch floating around for 2.4 that is used in 
some of the other distro's kernels that adds REPORT LUNS scanning as 
well as a flag to force LUN scanning (although not sure it works if LUN 
0 is not present).

A pragmatic solution may be to just add the echo scsi add-single-device 
x x x x > /proc/scsi/scsi into your early boot or configure one of your 
slices on LUN 0 (if the Xserve RAID allows that). 2.6 (and RHEL 4) 
support the REPORT LUNS so should work there although there are some 
messages on linux-scsi about the Xserve RAID's specific handling of LUN 
0. Probably good idea to post to linux-scsi.

~mc

