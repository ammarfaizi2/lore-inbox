Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUAHQrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 11:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUAHQrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 11:47:41 -0500
Received: from [198.70.193.2] ([198.70.193.2]:4753 "EHLO AVEXCH01.qlogic.org")
	by vger.kernel.org with ESMTP id S265149AbUAHQrh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 11:47:37 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Date: Thu, 8 Jan 2004 08:47:51 -0800
Message-ID: <B179AE41C1147041AA1121F44614F0B060EDD4@AVEXCH02.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b7).
Thread-Index: AcPOMdQ2imlePgONSjWEt4WyIIj7bQHz3d6Q
From: "Andrew Vasquez" <andrew.vasquez@qlogic.com>
To: "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux-SCSI" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 08 Jan 2004 16:47:51.0808 (UTC) FILETIME=[27D7E000:01C3D607]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 29, 2003 9:33 AM, James Bottomley wrote:
> On Fri, 2003-12-05 at 19:15, Andrew Vasquez wrote:
> > False start.  I've uploaded 8.00.00b8 to the SF site.  This driver
> > instructs the mid-layer to perform its initial scan with
> > scsi_scan_host().  During testing, I disable the scan.  Sorry for
> > the confusion.
> 
> OK, I've begun the BK process again.
> 
> This driver is now in BK at
> 
> bk://linux-scsi.bkbits.net/scsi-qla2xxx-2.6
> 
> I didn't see any comments about Christoph's patches, so is it OK if I
> apply them? 
>

Yes, I've been entrenched in several side projects.  I have a beta 9
ready for release which includes Christoph's patches as well as a
couple of other changes as a result of his comments (qla_fo.cfg,
exioct.h dependencies).  At this time though, I need to wait to
release until I receive another firmware drop.
 
> I plan to let it mature in it's own tree for a short while with the
> object being to get it into the right shape for a 2.6 inclusion
> candidate. 
> 
> The two items we still need to do something about are:
> 
> - Multi Pathing.  This really doesn't belong in the kernel
>

Yes, given the structure and form of recent patches, that certainly
does seem to be the case - which from QLogic's standpoint (now) seems
to be the proper path.  Just for clarification, given the structure of
the driver now (failover completely separated), inclusion of the
qla2xxx driver would exclude the following failover files:

	qla_fo.c qla_foln.c qla_cfg.c qla_cfgln.c

correct?

> - The odd ioctl set to the qla device...I'd much rather see something
> more standard that all FC drivers can use.
> 

Are you proposing to standardize a transport by which a user-space
application communicates with a driver (beyond IOCTLs), or, are you
suggesting there be some commonality in functional interfaces (i.e.
SNIA) for all FC drivers?

Look, IOCTLs were mainly used and built upon due the platform agnostic
nature of the interface.  All QLogic drivers (Linux, Solaris, Windows,
and Netware), use the platform's IOCTL interface with the QLogic
specific EXIOCT interfaces to pass information to/from user and driver
space.  Several user-space APIs were then created which use the EXIOCT
interface, SNIA (or HBAAPI), and several internal APIs, which are
ultimately used by all QLogic applications.

--
Andrew Vasquez
