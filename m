Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269664AbUJGOPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269664AbUJGOPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbUJGOPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:15:24 -0400
Received: from constellation.doubledimension.com ([63.90.75.35]:29859 "EHLO
	constellation.doubledimension.com") by vger.kernel.org with ESMTP
	id S269664AbUJGOPS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:15:18 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: PCI Burst and Overall System Speed (XEON)
Date: Thu, 7 Oct 2004 07:12:05 -0700
Message-ID: <E6456D527ABC5B4DBD1119A9FB461E350193E2@constellation.doubledimension.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PCI Burst and Overall System Speed (XEON)
Thread-Index: AcSseBIL1griEgUCRG2gUcaaDQYx6Q==
From: "Brian McGrew" <Brian@doubledimension.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question about the PCI Bursting and overall processing speed on a dual Xeon box; but first I have to give a slight bit of background, (all of it relevant to the question) I'll try and keep it short.

We take a Dell PE1600 box that's Dual Xeons and drop in two proprietary frame grabbers and attach a large format (2K x 2K) camera to each frame grabber.  The system fly's along and acquires images at the rate of about 15 frames per second per camera.  We use our dot plate for testing, it's a 16" x 12" glass plate with 1/8", 1/4" and 1/2" dots on it, primarily used for calibration.

It we load up a dot plate and use one camera, we can inspect it in about 66 seconds.  Turn on both cameras and that time is almost cut in half, to about 37 seconds (to be expected) but either way, one or two cameras, we pause our inspection several times because our frame buffers fill up to 100% and we have to wait while we work off the images (we won't start another scan until there enough available frames in the frame buffer).

If we turn on PCI Bursting for reading, we can shave another eight to ten seconds off of each inspection, not bad but here's where the question comes in and keep in mind I discovered this by accident!

If I switch to a different desktop and come back, the inspection times goes down by a couple seconds.  If I do something else on the system, like run the calculator, run up solitaire or xeyes, the inspection time goes down.  So just for the hell of it, I went to a different terminal on a different desktop and did the proverbial 'while true do; echo "wtf"; done and let it run while the machine was inspecting.  The inspection time was cut in half.  With two cameras, on a dot plate with PCI Burst turned on, I was right around 14 to 16 seconds.  During the inspection, we don't even pause.  The system is working off the load so fast that our frame buffers never get above 10% loaded.

I have been able to reproduce these same results on multiple machines running inspections on real circuit boards instead of just dot plates.  So what I'm really wondering is, I think that I've shown that with PCI Bursting turned on, and something else going on in the background that forces both processors to be at 100% utilization, the data moving across the bus is much faster and consistent.

Does anyone know what I'm talking about and can someone who knows a bit more about hardware/kernel/pci than I explain a bit?  I'm not a hardware guy and I just dove into the PCI stuff very recently.

TIA,

-brian

Brian D. McGrew        { brian@doubledimension.com || brian@visionpro.com }
---
> YOU!  Off my planet!
