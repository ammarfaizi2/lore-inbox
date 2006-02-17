Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWBQOla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWBQOla (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 09:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWBQOla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 09:41:30 -0500
Received: from mr1.bfh.ch ([147.87.250.50]:34737 "EHLO mr1.bfh.ch")
	by vger.kernel.org with ESMTP id S1751461AbWBQOl3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 09:41:29 -0500
X-PMWin-Version: 2.5.0e, Antispam-Engine: 2.2.0.0, Antivirus-Engine: 2.32.10
Thread-Index: AcYz0DvTiFYBpvq2SpCnmX4QuCDEvA==
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
Importance: normal
Message-ID: <43F5E097.4080709@bfh.ch>
Date: Fri, 17 Feb 2006 15:41:27 +0100
From: "Seewer Philippe" <philippe.seewer@bfh.ch>
Organization: BFH
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050811)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Matthew Wilcox" <matthew@wil.cx>
Cc: <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] sym53c8xx_2: Add bios_param to sym_glue.c
References: <43F5D963.9080009@bfh.ch> <20060217143718.GS12822@parisc-linux.org>
In-Reply-To: <20060217143718.GS12822@parisc-linux.org>
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 14:41:27.0227 (UTC) FILETIME=[3B91E8B0:01C633D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matthew Wilcox wrote:
> On Fri, Feb 17, 2006 at 03:10:43PM +0100, Seewer Philippe wrote:
> 
>>This patch adds the scsi common function bios_param to the sym53c8xx
>>driver. For simplicity i just copied the code from the sym53c416 driver.
> 
> 
> If the driver doesn't define bios_param, the scsi core calls
> scsicam_bios_param, which seems to do everything this patch does,
> and more.
> 
> A quick survey suggests that most drivers should have their bios_param
> methods deleted.  Was there a particular problem you found with the
> default scsicam_bios_param implementation?
Yes. Using scsicam_bios_parm and other defaults result in a geometry of
64 heads and 32 sectors even for big disks, which is not what the pc bios
"gets" from the controller. That is more along the lines of 255/63.

Returning a geometry of x/255/63 seems to be the default for bigger disks
withing scsi drivers, so i just copied the code...

