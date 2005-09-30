Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbVI3VlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbVI3VlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 17:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbVI3VlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 17:41:22 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:28144 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030453AbVI3VlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 17:41:21 -0400
Date: Fri, 30 Sep 2005 14:40:55 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Andrew Patterson <andrew.patterson@hp.com>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Linus Torvalds <torvalds@osdl.org>, Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20050930214055.GY27375@ca-server1.us.oracle.com>
Mail-Followup-To: Andrew Patterson <andrew.patterson@hp.com>,
	Luben Tuikov <luben_tuikov@adaptec.com>,
	"Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
	Linus Torvalds <torvalds@osdl.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	SCSI Mailing List <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com> <1128105594.10079.109.camel@bluto.andrew> <433D9035.6000504@adaptec.com> <1128111290.10079.147.camel@bluto.andrew> <433DA0DF.9080308@adaptec.com> <1128114950.10079.170.camel@bluto.andrew>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128114950.10079.170.camel@bluto.andrew>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 03:15:50PM -0600, Andrew Patterson wrote:
> But again, this may be just a goal and not a hard and fast rule.  I can
> definitely see a use for binary attributes in sysfs. Configfs seems to
> be designed for this sort of thing.

	Configfs is designed for ascii or readable attributes.  It drops
the bin_attribute type that sysfs still supports.  So if you are looking
to fill a 64K binary attribute, configfs isn't the place you're going to
be going.

> > fd = open(smp_portal, ...);
> > write(fd, smp_req, smp_req_size);
> > read(fd, smp_resp, smp_resp_size);
> > close(fd);
> 
> Process A opens an attribute and writes to it.  Process B opens another
> attribute and writes to it, affecting the result that process A will see
> from its subsequent read. I suppose you could lock every attribute, but
> that would be very error-prone, and not allow much concurrency.

	Check out nfsctl.c and its transaction_file design.  process A
and process B get different buffers on filp->f_private, and cannot
influence each other's read/write operations.

Joel

-- 

Life's Little Instruction Book #347

	"Never waste the oppourtunity to tell someone you love them."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
