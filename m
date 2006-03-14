Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752199AbWCNXcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbWCNXcD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWCNXb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:31:56 -0500
Received: from fmr17.intel.com ([134.134.136.16]:13724 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932480AbWCNXbz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:31:55 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] provide hrtimer exports for module use [Was:Exportsfor hrtimer APIs]
Date: Tue, 14 Mar 2006 15:31:45 -0800
Message-ID: <CBDB88BFD06F7F408399DBCF8776B3DC06A92D7E@scsmsx403.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] provide hrtimer exports for module use [Was:Exportsfor hrtimer APIs]
Thread-Index: AcZHuZcZ3e+32dt5TnGLgKe54Z70tgAA9qSA
From: "Stone, Joshua I" <joshua.i.stone@intel.com>
To: <tglx@linutronix.de>
Cc: "Andrew Morton" <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Mar 2006 23:31:45.0604 (UTC) FILETIME=[7520B040:01C647BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> I have no clue where the block of code written by the user is executed
> and why it needs exports. When a user writes code he can use the
> existing userpsace interfaces, so why does the module need that
> exports ?

Sorry - by user I mean a SystemTap user, who must be a priviledged user
to run SystemTap and load a kernel module in the first place.  When a
script is executed, the following happens:

1. The script with the user's probes is parsed by SystemTap.
2. SystemTap generates C code for a kernel module that implements the
probes.
3. The module is compiled and loaded into the kernel.
4. On loading, the probes register with the appropriate kernel APIs.
For function probes, this means using the kprobes interface.  For
asynchronous timer probes, the module must call timer APIs - e.g.
hrtimers.
5. As the events occur, the probe bodies are executed.
6. Finally the module terminates, unregisters all probes, and is
unloaded from the kernel.

In order to call hrtimer_init and such in step 4, those functions need
to be exported.


Josh
