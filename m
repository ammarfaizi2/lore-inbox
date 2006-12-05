Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967484AbWLEFm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967484AbWLEFm4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 00:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967723AbWLEFm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 00:42:56 -0500
Received: from gate.crashing.org ([63.228.1.57]:57167 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967717AbWLEFmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 00:42:55 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
Content-Type: text/plain; charset=utf-8
Date: Tue, 05 Dec 2006 16:42:42 +1100
Message-Id: <1165297363.29784.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 00:22 -0500, Kristian Høgsberg wrote:
> Hi,
> 
> I'm announcing an alternative firewire stack that I've been working on
> the last few weeks.  I'm aiming to implement feature parity with the
> current firewire stack, but not necessarily interface compatibility.
> For now, I have the low-level OHCI driver done, the mid-level
> transaction logic done, and the SBP-2 (storage) driver is basically
> done.  What's missing is a streaming interface (in progress) to allow
> reception and transmission of isochronous data and a userspace
> interface for controlling devices (much like raw1394 or libusb for
> usb).  I'm working out of this git repository:

A very very very quick look at the code shows that:

 - It looks nice / clear
 - It's horribly broken in at least two area :

 DO NOT USE BITFIELDS FOR DATA ON THE WIRE !!!

 and

 Where do you handle endianness ? (no need to shout for
 that one).

(Or in general, do not use bitfields period ....)

bitfields format is not guaranteed, and is not endian consistent. 

Ben.


