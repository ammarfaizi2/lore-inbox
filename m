Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWCAVII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWCAVII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWCAVIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:08:07 -0500
Received: from pat.qlogic.com ([198.70.193.2]:23617 "EHLO avexch02.qlogic.com")
	by vger.kernel.org with ESMTP id S1751907AbWCAVIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:08:06 -0500
Date: Wed, 1 Mar 2006 13:08:02 -0800
From: Andrew Vasquez <andrew.vasquez@qlogic.com>
To: Stefan Kaltenbrunner <mm-mailinglist@madness.at>
Cc: Andrew Morton <akpm@osdl.org>, Maxim Kozover <maximkoz@netvision.net.il>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: problems with scsi_transport_fc and qla2xxx
Message-ID: <20060301210802.GA7288@spe2>
References: <1413265398.20060227150526@netvision.net.il> <978150825.20060227210552@netvision.net.il> <20060228221422.282332ef.akpm@osdl.org> <4406034B.9030105@madness.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4406034B.9030105@madness.at>
Organization: QLogic Corporation
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 01 Mar 2006 21:08:03.0682 (UTC) FILETIME=[3AB10C20:01C63D74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Mar 2006, Stefan Kaltenbrunner wrote:

> Andrew Morton wrote:
> > Maxim Kozover <maximkoz@netvision.net.il> wrote:
> > 
> >>Hi!
> > 
> > 
> > (cc's added)
> > 
> > 
> >>Most of the problem seems to be a QLogic driver problem.
> >>HBAs are connected to target via FC switch.
> >>
> >>1. If I have several LUNs on each HBA, with QLogic only 1 directory
> >>per adapter (for LUN 0) is created in /sys/class/fc_remote_ports,
> >>while with Emulex a directory for every LUN is created.
> >>
> >>2. The situation I described occurs with QLogic only if the cable
> >>connecting between HBA and switch is pulled out/in. If I
> >>connect/disconnect the cable between switch and target, disks come
> >>back.
> 
> I can confirm that very problem (pulling the cable between HBA and
> switch results in only LUN 0 or nothing coming back afterward) on
> 2.6.15.4 here too.

Please try recent 2.6.16-rcX kernels as there have been a number of
patches submitted since 2.6.15 which (attempt to) address most of
these holes -- I'm still trying to get additional details on Maxim's.

387f96b4d9391bf3ce6928fb9cd90c9c7df37291 [PATCH] qla2xxx: Close window on race between rport removal and fcport transition.
77427f514f88143bfef41ba8c1e624bc45f42297 [SCSI] qla2xxx: Drop legacy 'bypass lun scan for tape device' code.
052c40c83b4ca37be226112049b60097cb9961e1 [SCSI] qla2xxx: Correct issue where the rport's upcall was not being made after relogin.
d97994dc1fddcbb8212b745d9c9c9ce96262155c [SCSI] qla2xxx: Correct synchronization issues during rport addition/deletion.
79f89a4296ff22f09baf538d4ff2a6d0c3097a73 [SCSI] qla2xxx: Disable port-type RSCN handling via driver state-machine.


Regards,
Andrew Vasquez
