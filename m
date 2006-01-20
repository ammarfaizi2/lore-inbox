Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWATKT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWATKT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWATKT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:19:27 -0500
Received: from general.keba.co.at ([193.154.24.243]:11165 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750786AbWATKT0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:19:26 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: My vote against eepro* removal
Date: Fri, 20 Jan 2006 11:19:20 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323325@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vote against eepro* removal
Thread-Index: AcYdp8DxqCun3HYgSmiAwfGXsfGs7AAAV6TA
From: "kus Kusche Klaus" <kus@keba.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Cc: "John Ronciak" <john.ronciak@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Lee Revell" <rlrevell@joe-job.com>, <linux-kernel@vger.kernel.org>,
       <john.ronciak@intel.com>, <ganesh.venkatesan@intel.com>,
       <jesse.brandeburg@intel.com>, <netdev@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov
> Each MDIO read can take upto 2 msecs (!) and at least 20 
> usecs in e100,
> and this runs in timer handler.
> Concider attaching (only compile tested) patch which moves 
> e100 watchdog
> into workqueue.

Hmmm, I don't think moving it around is worth the trouble
(nevertheless, I will test later if I find time).

For a full preemption kernel, both timer code and workqueue code
are executed in a thread of their own. If I know that there is a
500 us piece of code in either of them, I have to adjust the prio
of the corresponding thread (and all others) accordingly anyway.

For a non-full preemption kernel, your patch moves the 500 us 
piece of code from kernel to thread context, so it really 
improves things. But is 500 us something to worry about in a
non-full preemption kernel?

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
 
