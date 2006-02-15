Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWBOSod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWBOSod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 13:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWBOSod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 13:44:33 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:43701 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751169AbWBOSoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 13:44:32 -0500
Message-ID: <43F3764C.8080503@cfl.rr.com>
Date: Wed, 15 Feb 2006 13:43:24 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com> <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com> <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com> <43F2E8BA.90001@bfh.ch> <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140019615.14831.22.camel@localhost.localdomain> <43F354E9.2020900@cfl.rr.com> <1140024754.14831.31.camel@localhost.localdomain>
In-Reply-To: <1140024754.14831.31.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 18:46:02.0562 (UTC) FILETIME=[11ECD220:01C63260]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14269.000
X-TM-AS-Result: No--4.000000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2006-02-15 at 11:20 -0500, Phillip Susi wrote:
>> Why do you say the partitioning tool needs to know the disk reported 
>> C/H/S?  The value stored in the MBR must match the bios reported values, 
>> not the disk reported ones, so why does the partitioner care about what 
>> the disk reports?
> 
> You answered that in asking the question.  "The value stored in the MBR
> must match the ...". What if the MBR has not yet been written ?
> 

The value in the MBR must match the _bios_ value, not the value that the 
disk reports in its inquiry command ( which often will be different ). 
When creating a new MBR you need to get the geometry from the bios, not 
the drive itself.

> (Also btw its *should*...) most modern OS's will take a sane MBR
> geometry and trust it over BIOS defaults.
> 

If the value in the MBR differs from the geometry that the bios reports, 
then boot code using int 13 in chs mode will fail because it won't be 
using the geometry that the bios expects.


