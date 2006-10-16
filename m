Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWJPPLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWJPPLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 11:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWJPPLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 11:11:32 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:17161 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932128AbWJPPLb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 11:11:31 -0400
Date: Mon, 16 Oct 2006 11:11:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
cc: Duncan Sands <duncan.sands@math.u-psud.fr>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 3/3] Driver core: Per-subsystem multithreaded probing.
In-Reply-To: <20061016125613.16c9f667@gondolin.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.44L0.0610161108460.7601-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006, Cornelia Huck wrote:

> ->probe won't be called if the device is already being removed, but
> that still results in bus->remove being called without a prior ->probe
> (but not drv->probe since dev->driver is not set at that time).

One other thing I forgot to mention...  In device_attach(), if dev->driver 
is already set upon entry and the call to device_bind_driver() fails, 
dev->driver should be set to NULL before returning.  We don't want the 
device to appear to be bound when in fact it isn't.

Alan Stern

