Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270411AbUJUIeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270411AbUJUIeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 04:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270595AbUJUId7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 04:33:59 -0400
Received: from fmr05.intel.com ([134.134.136.6]:11240 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S270411AbUJUIdS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 04:33:18 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: gradual timeofday overhaul
Date: Thu, 21 Oct 2004 01:32:53 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F96CB@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gradual timeofday overhaul
Thread-Index: AcS2wTYVfOEhvEjFTvCHP5zy7UEl+AAU9ouA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <root@chaos.analogic.com>, "George Anzinger" <george@mvista.com>
Cc: "Brown, Len" <len.brown@intel.com>,
       "Tim Schmielau" <tim@physik3.uni-rostock.de>,
       "john stultz" <johnstul@us.ibm.com>,
       "lkml" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Oct 2004 08:32:54.0143 (UTC) FILETIME=[8F3610F0:01C4B748]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Richard B. Johnson
>
> You need that hardware interrupt for more than time-keeping.
> Without a hardware-interrupt, to force a new time-slice,
> 
>  	for(;;)
>             ;
> 
> ... would allow a user to grab the CPU forever ...

But you can also schedule, before switching to the new task, 
a local interrupt on the running processor to mark the end 
of the timeslice. When you enter the scheduler, you just need 
to remove that; devil is in the details, but it should be possible
to do in a way that doesn't take too much overhead.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
