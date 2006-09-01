Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWIAQNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWIAQNV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWIAQNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:13:21 -0400
Received: from mail0.lsil.com ([147.145.40.20]:5354 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932208AbWIAQNU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:13:20 -0400
x-mimeole: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/1] SCSI: improve endian handling in LSI fusion firmware mpt_downloadboot
Date: Fri, 1 Sep 2006 10:12:40 -0600
Message-ID: <664A4EBB07F29743873A87CF62C26D702E3017@NAMAIL4.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/1] SCSI: improve endian handling in LSI fusion firmware mpt_downloadboot
Thread-Index: AcbMWlbrvqJGsPCDSHqNzHbu8dcdOABhaUbw
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Erik Habbinga" <erikhabbinga@inphase-tech.com>
Cc: <james.bottomley@steeleye.com>, <trivial@kernel.org>,
       <linux-kernel@vger.kernel.org>,
       "Shirron, Stephen" <Stephen.Shirron@lsil.com>,
       "Hickerson, Roger" <Roger.Hickerson@lsil.com>
X-OriginalArrivalTime: 01 Sep 2006 16:12:40.0785 (UTC) FILETIME=[73079410:01C6CDE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 30, 2006 11:33 AM, Erik Habbinga wrote: 

> The mpt_downloadboot function in 
> drivers/message/fusion/mptbase.c doesn't work correctly on 
> big endian systems (powerpc in my case).
> I've added appropriate le32_to_cpu calls to correctly 
> translate little endian firmware file data into cpu endian 
> format before
> getting written to little endian PCI registers.  This patch 
> has been tested successfully on a powerpc target and an Intel target.
> 

Rejected.

This will break all our customers on big-endian machines.

Our firmware is packaged in proper byte order on dword boundarys,
and doesn't need swapping at all.   Basically mpt_downloadboot, 
is reading from pFwHeader, and writing back out to doorbell
in proper byte order that doorbell expecting.  This code is working
for many LSI customers running on big-endian systems, such as pppc64.

Could you send your firmware image, copied to Stephen Shirron,
so he can determine if your firmware is properly packaged in correct
byte order?

Eric Moore
LSI Logic
