Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWATKva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWATKva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWATKva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:51:30 -0500
Received: from general.keba.co.at ([193.154.24.243]:16030 "EHLO
	helga.keba.co.at") by vger.kernel.org with ESMTP id S1750811AbWATKv3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:51:29 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: My vote against eepro* removal
Date: Fri, 20 Jan 2006 11:51:23 +0100
Message-ID: <AAD6DA242BC63C488511C611BD51F367323326@MAILIT.keba.co.at>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vote against eepro* removal
Thread-Index: AcYdp8DxqCun3HYgSmiAwfGXsfGs7AABq5ug
From: "kus Kusche Klaus" <kus@keba.com>
To: "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>
Cc: "John Ronciak" <john.ronciak@gmail.com>, "Adrian Bunk" <bunk@stusta.de>,
       "Lee Revell" <rlrevell@joe-job.com>, <linux-kernel@vger.kernel.org>,
       <john.ronciak@intel.com>, <ganesh.venkatesan@intel.com>,
       <jesse.brandeburg@intel.com>, <netdev@vger.kernel.org>,
       "Steven Rostedt" <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov [mailto:johnpol@2ka.mipt.ru] 
> Each MDIO read can take upto 2 msecs (!) and at least 20 
> usecs in e100,
> and this runs in timer handler.
> Concider attaching (only compile tested) patch which moves 
> e100 watchdog
> into workqueue.

Tested the patch. Works and has the expected effects:

Fully preemptible kernel: 
No change: 500 us delay at rtprio 1, no delay at higher rtprio.
(you just moved the 500 us piece of code from one rtprio 1 kernel 
thread to another rtprio 1 kernel thread).

Kernel with desktop preemption:
Originally: Threads at any rtprio suffered from 500 us delay.
With your patch: Only rtprio 1 threads suffer from 500 us delay,
no delay at higher rtprio.

-- 
Klaus Kusche                 (Software Development - Control Systems)
KEBA AG             Gewerbepark Urfahr, A-4041 Linz, Austria (Europe)
Tel: +43 / 732 / 7090-3120                 Fax: +43 / 732 / 7090-6301
E-Mail: kus@keba.com                                WWW: www.keba.com
 
