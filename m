Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752447AbWAFQgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbWAFQgD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 11:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752459AbWAFQfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 11:35:48 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:58523 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932456AbWAFQfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 11:35:11 -0500
Subject: Re: [CFT 1/29] Add bus_type probe, remove, shutdown methods.
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-scsi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, schwidefsky@de.ibm.com,
       Greg K-H <greg@kroah.com>
In-Reply-To: <20060106114822.GA11071@flint.arm.linux.org.uk>
References: <20060105142951.13.01@flint.arm.linux.org.uk>
	 <20060106114822.GA11071@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Fri, 06 Jan 2006 10:34:49 -0600
Message-Id: <1136565289.3528.26.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 11:48 +0000, Russell King wrote:
> The scsi_driver business looks like being a pig to solve - so can
> SCSI folk please look at what's required to unuse these fields.

Well, not necessarily pig.  Perhaps piglet.  We definitely need the
separate probe, shutdown and remove methods for each of our ULDs.
However, if they moved into the bus, since scsi_driver is always of type
scsi_bus, we could add separate probe, shutdown and remove fields to
struct scsi_driver and have the new fields in scsi_bus call those.  I
have to ask, though; isn't that primarily what most other bus types are
going to be doing anyway?  So doesn't it make sense to leave the fields
in the generic driver?  Then the rule becomes that if the bus has the
field, we call it, and the bus routine *may* call the corresponding
generic driver field if it feels like it.  Otherwise if the bus has no
callbacks, just use the generic driver ones?

James


