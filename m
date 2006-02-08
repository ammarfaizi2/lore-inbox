Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161087AbWBHPQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWBHPQM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWBHPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 10:16:12 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:17620 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161070AbWBHPQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 10:16:11 -0500
Subject: Re: [PATCH] add execute_in_process_context() API
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p737j86l1es.fsf@verdi.suse.de>
References: <1139342419.6065.8.camel@mulgrave.il.steeleye.com.suse.lists.linux.kernel>
	 <p737j86l1es.fsf@verdi.suse.de>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 09:15:51 -0600
Message-Id: <1139411751.3003.1.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-08 at 09:06 +0100, Andi Kleen wrote:
> In general this seems like a lot of code for a simple problem.
> It might be simpler to just put the work structure into the parent
> object and do the workqueue unconditionally

We can't do this.  For the target release, there may be multiple calls
to the reap function ... if we embed in the structure we have no room
for more than one.

> > +	if (unlikely(!wqw)) {
> > +		printk(KERN_ERR "Failed to allocate memory\n");
> > +		WARN_ON(1);
> 
> WARN_ON for GFP_ATOMIC failure is bad. It is not really a bug.

Here, it means that the requested work wasn't executed.  In SCSI that
would mean an object is now in place permanently.  The problem is that
there's no real way to cope with failure in this case.

James


