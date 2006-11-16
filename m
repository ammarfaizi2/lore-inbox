Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424168AbWKPP1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424168AbWKPP1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 10:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424170AbWKPP1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 10:27:14 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:42597 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1424168AbWKPP1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 10:27:13 -0500
Message-ID: <455C8384.1000907@cfl.rr.com>
Date: Thu, 16 Nov 2006 10:28:04 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Yakov Lerner <iler.ml@gmail.com>
CC: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: locking sectors of raw disk (raw read-write test of mounted disk)
References: <f36b08ee0611151206k50284ef9n43d7edf744ae2f19@mail.gmail.com>  <455B8979.6090101@cfl.rr.com> <f36b08ee0611160215i7dcbd27p76963cb12d0bc12f@mail.gmail.com>
In-Reply-To: <f36b08ee0611160215i7dcbd27p76963cb12d0bc12f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2006 15:28:06.0988 (UTC) FILETIME=[D0B788C0:01C70993]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14816.003
X-TM-AS-Result: No--8.703300-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yakov Lerner wrote:
> I don't want to tamper wuith data. I want to raw write back exacty
> same raw data that I read in. I only want to make sure that kernel
> doesn't write modified data between in between my read-write pair.

Ahh, in that case you might be able to do this using the device mapper. 
  You could keep the filesystem mounted on the device mapper with a 
mapping to the underlying disk device.  Then change that mapping on the 
fly to mark a section of the device as mapped to a ramdisk and copy ( 
while that section is suspended ) the original data there.  Then resume 
the section, tamper with the underlying disk, then suspend the ramdisk 
mapping, copy it back to the underlying disk, then change the mapping 
back to normal.  You might also use a snapshot dm target instead of a 
ramdisk.


