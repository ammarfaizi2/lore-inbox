Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbUCKJgR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 04:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbUCKJgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 04:36:16 -0500
Received: from dirac.phys.uwm.edu ([129.89.57.19]:59276 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S261153AbUCKJgJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 04:36:09 -0500
Date: Thu, 11 Mar 2004 03:36:06 -0600 (CST)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Henrik Persson <nix@syndicalist.net>
cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       Bruce Allen <ballen@gravity.phys.uwm.edu>, linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
In-Reply-To: <1078930851.766.7.camel@vega>
Message-ID: <Pine.GSO.4.21.0403110327190.11871-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2004-03-10 at 13:36, Mario 'BitKoenig' Holbe wrote:
> > On Wed, Mar 10, 2004 at 05:50:12AM -0600, Bruce Allen wrote:
> > > Does the disk's SMART error log (smartctl -l error) show any entries
> > > related to this problem?  If so, please print them with the latest version
> > 
> > No, none at all. This was the first I was looking at, because
> > I just thought it was some disk problem.
> 
> Same here. Just one of the discs that has stopped during the last
> month has any entries in the log at all. Those errors are attached.

FWIW, these four errors:

Error 4 occurred at disk power-on lifetime: 6619 hours
  When the command that caused the error occurred, the device was in an
unknown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  84 51 00 00 00 00 e0  Error: ICRC, ABRT

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 ff 01 00 00 00 e0 08     546.992  READ DMA
  ef 03 45 20 77 a5 e0 08     546.992  SET FEATURES [Set transfer mode]
  c6 ff 10 20 77 a5 e0 08     546.992  SET MULTIPLE MODE
  10 ff 50 20 77 a5 e0 08     546.992  RECALIBRATE [OBS-4]
  91 03 3f 20 77 a5 ef 08     546.992  INITIALIZE DEVICE PARAMETERS  [OBS-6]

are all 'conventional' DMA errors, in which there was a CRC error in the
hardware interface between the disk and the controller.  Either the cable
connections to this disk were briefly problematic or their was electrical
noise on the lines.  Probably not anything to worry about.

> The funny thing is that the machine stops responding after the
> dma_timer_expiry.. Why doesn't just the kernel (or the controller for
> that matter) disable DMA and then the problem would be solved, if the
> problem is related to DMA, right? Sure, the speed (or lack of it) would
> be painful but I wouldn't need to sit 60km from home and wondering why
> my box just stopped responding. ;/

FWIW, there have been reports of problems (system lockup) with
smartmontools on systems with Promise 20262 and 20265 controllers. See:
http://cvs.sourceforge.net/viewcvs.py/smartmontools/sm5/WARNINGS?sortby=date&view=markup
So I guess I will need to add the 20268 controller to this list, although
as Mario says, smartmontools may play only an indirect role, in exposing
an existing problem.

Cheers,
	Bruce

