Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWBGX0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWBGX0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWBGX0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:26:51 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:49592 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030262AbWBGX0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:26:50 -0500
Subject: Re: [SCSI] fix wrong context bugs in SCSI
From: James Bottomley <James.Bottomley@SteelEye.com>
To: brking@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43E91998.2070204@us.ibm.com>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com>
	 <1139342922.6065.12.camel@mulgrave.il.steeleye.com>
	 <43E91998.2070204@us.ibm.com>
Content-Type: text/plain
Date: Tue, 07 Feb 2006 17:26:46 -0600
Message-Id: <1139354806.6065.14.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-07 at 16:05 -0600, Brian King wrote:
> I just tried this out on my ppc64 box. I recently noticed that
> the target reaping via workqueue change that went in not too long ago
> resulted in *really* slow user initiated wildcard scans for ipr
> adapters - in the neighborhood of 6 minutes... Your patch brings
> that back down to 8 seconds.

Yes, that's because the original fix used a workqueue for everything
(whether it needed it or not).  The new API checks the context first
before invoking a workqueue.  By and large, for SCSI, we actually have
user context most of the time, so the old fix was rather heavy handed.

James


