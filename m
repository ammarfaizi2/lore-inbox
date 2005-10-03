Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVJCTd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVJCTd6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVJCTd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:33:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61165 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932586AbVJCTd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:33:56 -0400
Message-ID: <4341874A.7000703@cs.wisc.edu>
Date: Mon, 03 Oct 2005 14:32:26 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>, willy@w.ods.org,
       patmans@us.ibm.com, ltuikov@yahoo.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org> <433D8542.1010601@adaptec.com> <433DD0F8.4000501@pobox.com> <43413CE8.1090306@adaptec.com> <434154F0.9070105@pobox.com> <43415AFC.5080501@adaptec.com> <434160ED.7050803@pobox.com> <43418076.4020706@adaptec.com>
In-Reply-To: <43418076.4020706@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> On 10/03/05 12:48, Jeff Garzik wrote:
> 
>>No, transport class is its name.  Think about a standard object-oriented 
> 
> 
> Not according to Kconfig:
> 
> menu "SCSI Transport Attributes"
> 	depends on SCSI
> 
> config SCSI_SPI_ATTRS
> 	tristate "Parallel SCSI (SPI) Transport Attributes"
> 	depends on SCSI
> 	help
> 	  If you wish to export transport-specific information about
> 	  each attached SCSI device to sysfs, say Y.  Otherwise, say N.
> 
> config SCSI_FC_ATTRS
> 	tristate "FiberChannel Transport Attributes"
> 	depends on SCSI
> 	help
> 	  If you wish to export transport-specific information about
> 	  each attached FiberChannel device to sysfs, say Y.
> 	  Otherwise, say N.
> 

For FC there is code like the fc_rport stuff which exports a sysfs 
interface but also does a lot more like probing and queue blocking.

> config SCSI_ISCSI_ATTRS
> 	tristate "iSCSI Transport Attributes"
> 	depends on SCSI
> 	help
> 	  If you wish to export transport-specific information about
> 	  each attached iSCSI device to sysfs, say Y.
> 	  Otherwise, say N.

And the iSCSI class does do a lot more now too. This just has not been 
updated. It handles the userspace to kernel communication, session and 
connection sysfs interface setup, and there were some patches that added 
the ability to tell scsi-ml to stop queueing commands to a iscsi driver.

Structures like the fc_rport and iscsi_session are managed by the 
transport classes so scsi-ml never knows about them (except for that 
scanning bug). And it is possible to share them between HW and software 
or partial software solutions. I do agree for some iscsi sitautions 
having a layer over the eh or command exection where the transport 
really is more of a layer like your design would be nice (I am not 
refferring to the code duplication though becuase iSCSI would like some 
of yrou fixes :), but at the same time there are places where code can 
be shared between a interface that hides the lower level details and one 
that implements them in software. Maybe it is not this way for SAS though.

