Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbTFSQm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265834AbTFSQm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:42:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24506 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265755AbTFSQm0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:42:26 -0400
Message-ID: <3EF1EB2E.8010702@pobox.com>
Date: Thu, 19 Jun 2003 12:56:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Cress, Andrew R" <andrew.r.cress@intel.com>
CC: "'Matthias Andree'" <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: SCSI Write Cache Enable in 2.4.20?
References: <A5974D8E5F98D511BB910002A50A66470B54CBA3@hdsmsx103.hd.intel.com>
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B54CBA3@hdsmsx103.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cress, Andrew R wrote:
> IMO, it isn't "necessary", but it is very desirable, and should be the
> default, to disable write cache on SCSI disks for any system that is
> concerned about reliability.


This sounds like a bug, either in an application, or in Linux kernel's 
scsi disk implementation.

Data is only guaranteed to be written onto disk following an 
fsync(2)-like operation in the application.  And in turn, it is the 
Linux kernel's responsibility to ensure that such a flush is propagated 
all the down to the low-level driver, in my opinion.  Sophisticated 
hosts can have barriers, and "dumb" hosts can simply call the drive's 
flush-cache / sync-cache command.

	Jeff



