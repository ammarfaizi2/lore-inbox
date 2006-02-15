Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945975AbWBOPaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945975AbWBOPaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945983AbWBOPaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:30:10 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:31644 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1945975AbWBOPaJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:30:09 -0500
Message-ID: <43F348C2.2070305@cfl.rr.com>
Date: Wed, 15 Feb 2006 10:29:06 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Seewer Philippe <philippe.seewer@bfh.ch>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch> <43F0B484.3060603@cfl.rr.com>  <43F0D7AD.8050909@bfh.ch> <43F0DF32.8060709@cfl.rr.com>  <43F206E7.70601@bfh.ch> <43F21F21.1010509@cfl.rr.com>  <43F2E8BA.90001@bfh.ch>  <58cb370e0602150051w2f276banb7662394bef2c369@mail.gmail.com> <1140016519.14831.18.camel@localhost.localdomain>
In-Reply-To: <1140016519.14831.18.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2006 15:31:41.0674 (UTC) FILETIME=[EB7E84A0:01C63244]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14269.000
X-TM-AS-Result: No--7.600000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The tools need to know the C/H/S drive addressing data for old drives
> because it is used to determine partition tables. That doesn't have to
> be GETGEO but it does need to exist somewhere.
Currently GETGEO very often does not report the same values of the bios 
doesn't it?  For some disks it's completely made up, and for others it 
is the value returned by the drive itself, which often differs from the 
bios values.  If this is the case, and it is the bios values that must 
be stored in the MBR, then it makes little sense to have GETGEO seeing 
as how it often provides incorrect information. 

Wouldn't it be better then, to clean up GETGEO everywhere so that unless 
it has correct values from the bios, it should just fail?  And leave it 
up to fdisk and friends to inform the user of that failure, choose 
default values, and allow the user to override those defaults should 
they need to?

The only time they would even have to worry about it is if they are 
installing linux on a blank disk, and then want to install windows to 
dual boot with it.  In that case they might have to correct the CHS 
values in the MBR to match the values the bios provides.


