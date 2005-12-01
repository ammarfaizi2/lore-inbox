Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVLAL02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVLAL02 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 06:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVLAL02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 06:26:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:27360 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932145AbVLAL01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 06:26:27 -0500
Date: Thu, 1 Dec 2005 11:26:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Chris McDermott <lcm@us.ibm.com>, Luvella McFadden <luvella@us.ibm.com>,
       AJ Johnson <blujuice@us.ibm.com>, Kevin Stansell <kstansel@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] aic79xx should be able to ignore HostRAID enabled adapters
Message-ID: <20051201112624.GC3958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@us.ibm.com>,
	Chris McDermott <lcm@us.ibm.com>,
	Luvella McFadden <luvella@us.ibm.com>,
	AJ Johnson <blujuice@us.ibm.com>,
	Kevin Stansell <kstansel@us.ibm.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <438E90DD.3010007@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438E90DD.3010007@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 09:57:49PM -0800, Darrick J. Wong wrote:
> Hi there,
> 
> I have an IBM x346 with some Adaptec 7902 SCSI controllers; one has HostRAID
> enabled in a RAID array, and the other does not.  Upon bootup, the aic79xx
> driver will grab both controllers even though I'd prefer that Adaptec's a320raid
> driver grab the HostRAID controller.  (When attached to the RAID array, the
> aic79xx driver presents each drive in the array as a separate SCSI device.)  If
> HostRAID is turned on, the PCI class code is 0x0104 (RAID) and if it's turned
> off, the class code is 0x0100 (SCSI).
> 
> Unfortunately, there currently is no provision in the aic79xx driver to ignore
> RAID controllers--if the PCI device/vendor IDs match, the driver takes the
> controller.  The attached patch modifies the PCI probe function to ignore RAID
> controllers and a module parameter "attach_HostRAID" to toggle this behavior.
> If one passes "attach_HostRAID=1" to insmod, the driver will take RAID
> controllers; "attach_HostRAID=0", it won't.  The default is to set it to zero.
> 
> The patch should apply cleanly against 2.6.14 and I've verified that it works
> correctly on a x346 and a x226, both of which have a 7902b.  I'd appreciate a
> few more eyes to look over it, and if there aren't any objections I'd like to
> submit this for inclusion in mainline.

NACK.  We're not going to support attaching broken propritary drivers.
Sepcially as these "HostRAID" cards are plain SCSI HBAs.  If you care about
botting from the bios softraid port the adaptec raid format support to dmraid.
