Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422765AbWHXWVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbWHXWVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 18:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422764AbWHXWVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 18:21:21 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:43951 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1422762AbWHXWVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 18:21:20 -0400
Subject: Re: [PATCH 1/2] Add SATA support to libsas
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
In-Reply-To: <44DC455A.2090705@garzik.org>
References: <44DBE943.4080303@us.ibm.com>  <44DC455A.2090705@garzik.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:18:15 -0500
Message-Id: <1156457895.1024.59.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-11 at 04:52 -0400, Jeff Garzik wrote:
> One piece that seems to be distinctly absent is controlling the SATA 
> phy, rather than faking it...

Could you elaborate a bit more?  You mean this faking of the SATA
Control Registers?  If so, this is a bit problematic ... SAS HBAs don't
seem to come with SATA Control Registers (and certainly not when the
device is remote over SAT).  We do, however, have reasonable control of
the phys via the transport class.  Probably the best solution is to
expand the ata transport class to abstract this phy control out into
knobs users can twiddle and then put this back down to libata/libsas via
callbacks they can each interpret.

James


