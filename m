Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbULJQCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbULJQCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261741AbULJQCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:02:00 -0500
Received: from webapps.arcom.com ([194.200.159.168]:48907 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S261745AbULJPlo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:41:44 -0500
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Ian Campbell <icampbell@arcom.com>
To: Kylene Hall <kjhall@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <1102692480.20230.3.camel@jo.austin.ibm.com>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <1102676169.31305.85.camel@icampbell-debian>
	 <1102692480.20230.3.camel@jo.austin.ibm.com>
Content-Type: text/plain
Organization: Arcom Control Systems
Date: Fri, 10 Dec 2004 15:41:38 +0000
Message-Id: <1102693298.31305.98.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2004 15:43:53.0421 (UTC) FILETIME=[0D323FD0:01C4DECF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 09:28 -0600, Kylene Hall wrote:
> Good point.  Splitting this out (esp. because there will be more in the
> future) is a good idea.  What is the usual way to do this?  For example,
> what function in the chip specific file would call
> register_tpm_hardware, how do I make sure that gets called etc.

I guess you could have multiple modules, one providing the generic code
and the dev interface etc (tpm.ko) and then one per hardware chip
(tmp-nsc.ko, tpm-atmel.ko, tpm-atmel-i2c.ko). 

The hardware modules can then call tpm_register_hardware() in their
module_init function. 

Perhaps it would make sense to put the PCI bus stuff and things like
that in the hardware module as well, since e.g. an i2c chip would not
fit into that model

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200

