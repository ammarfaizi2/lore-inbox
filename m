Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTHYUzo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 16:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbTHYUyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 16:54:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62419 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262328AbTHYUyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 16:54:07 -0400
Date: Mon, 25 Aug 2003 21:54:04 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix ide unregister vs. driver model
Message-ID: <20030825205403.GL454@parcelfarce.linux.theplanet.co.uk>
References: <1061730317.31688.10.camel@gaston> <200308250023.39596.bzolnier@elka.pw.edu.pl> <1061793253.779.27.camel@gaston> <200308251317.37333.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308251317.37333.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 10:50:27PM +0200, Bartlomiej Zolnierkiewicz wrote:
 
> Nope, I don't think struct device can be used by sysfs after execution
> of device_unregister() (I've checked driver model and sysfs code).

Yes, it can.  Have the sucker held by open file on sysfs.  Keep it open
past the device_unregister().  Now close it and watch the struct device
being modified.
