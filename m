Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932737AbVINTmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbVINTmc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932714AbVINTmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:42:32 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:738 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932694AbVINTmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:42:31 -0400
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process
	(end devices)
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Douglas Gilbert <dougg@torque.net>,
       Luben Tuikov <luben_tuikov@adaptec.com>, ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050913224215.GB1308@us.ibm.com>
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com>
	 <1126368081.4813.46.camel@mulgrave> <4325997D.3050103@adaptec.com>
	 <20050912162739.GA11455@us.ibm.com> <4326964B.9010503@torque.net>
	 <20050913224215.GB1308@us.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 14:47:59 -0400
Message-Id: <1126723680.4588.9.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 15:42 -0700, Patrick Mansfield wrote:
> So adding a W_LUN at this point does not add any value ... maybe it looks
> nice in the spec and in someones firmware, but it does not add anything
> that I can see.

Well I agree with the analysis, but even given that, we have a linux
implementation problem: We have to get an inquiry response first before
we begin a report luns scan.  An array implementing a W_LUN is entitled
not respond on LUN 0 to INQUIRY with an error, which would mean we don't
see it.

Therefore, I think our strategy has to be when the current probe fails
because of no LUN 0 try a report luns scan on the W_LUN anyway as long
as the transport indicates it is capable of supporting it (i.e. as long
as it has max_luns set at 0xffff or higher).

James


