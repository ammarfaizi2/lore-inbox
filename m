Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUI0Dnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUI0Dnu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 23:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUI0Dnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 23:43:50 -0400
Received: from fmr05.intel.com ([134.134.136.6]:31387 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265773AbUI0Dna convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 23:43:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: suspend/resume support for driver requires an external firmware
Date: Mon, 27 Sep 2004 11:43:12 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5792@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: suspend/resume support for driver requires an external firmware
Thread-Index: AcSicrNk8qlP+PYtQXexEaxDauquDgBzLrtQ
From: "Zhu, Yi" <yi.zhu@intel.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Patrick Mochel" <mochel@digitalimplant.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 27 Sep 2004 03:43:12.0503 (UTC) FILETIME=[1D084870:01C4A444]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcel Holtmann wrote:
> it consumes extra runtime memory, but why not build a simple
> firmware cache behind the request_firmware() interface. 

I think this could be another choice, but I'd rather call it as a
firmware 
suspend hook. Because when the system is running, the cache 
should be purged to save memory. swsusp (or other implementations)
is required to call the firmware hook before device_suspend. The 
firmware hook is responsible to load all the necessary firmwares into
memory before suspend so that they can be read from memory in the
next request_firmware(). And we also need a firmware resume hook to
free the memory.

But how about drivers read firmware themselves? They don't rely on
firmware_class.

> In this case it can be transparent for the driver and we won't
> have an extra workaround for suspend/resume stuff for every
> driver.

I don't think it is a workaround, drivers are supposed to know best
how to "save their states". Firmware is one example for now.

> How many firmwares do a normal system really have to
> hold in memory for suspend/resume actions?

I don't know either. ;-)

Thanks,
-yi
