Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265815AbUAEA0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 19:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265816AbUAEA0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 19:26:10 -0500
Received: from fmr05.intel.com ([134.134.136.6]:32221 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S265815AbUAEA0H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 19:26:07 -0500
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [2.6.0-mm2] e100 driver hangs after period of moderate receive load
Date: Sun, 4 Jan 2004 16:25:51 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0102CBDD97@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6.0-mm2] e100 driver hangs after period of moderate receive load
Thread-Index: AcPQUuv2RSkITeYjRJ6QT2gvunzrYgCz2rTQ
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Lennert Buytenhek" <buytenh@gnu.org>,
       "Thomas Molina" <tmolina@cablespeed.com>
Cc: "Jeff Garzik" <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jan 2004 00:25:52.0237 (UTC) FILETIME=[79CD91D0:01C3D322]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennert Buytenhek wrote:
> Make sure you have slab debugging enabled to see if you also 
> get the slab corruption messages, and then hit the machine 
> with anything above 50000 packets per second.  pktgen from a 
> different machine on the same subnet works nicely for that.  
> I doubt that downloading a Red Hat iso would give you a load 
> anywhere near that.
> 
> Oh, do you have an SMP box?  This was on a 2-way (4-way HT) 
> SMP box.  Not sure if that matters here.
> 
> I'm just about to try 2.6.0-mm2 without NAPI.

Ok, I've repro'd this (w/ and w/o NAPI, but w/o is much harder).  I
wasted a bunch of time having both page alloc debugging and slab
debugging on.  Seems one masks the other.  (Jeff warned me!)  In any
case, what I know so far is the problem happens when HW runs out of Rx
resources, and SW tries to resume the receiver after supplying new
resources.  Somehow HW is scribbling on resources already given back to
the OS.  It's something about the list management in this new e100.
eepro100 and legacy e100 work fine.  Investigation continuing...

-scott
