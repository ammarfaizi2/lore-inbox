Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266632AbUBQX46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 18:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266696AbUBQX46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 18:56:58 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:53403 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266632AbUBQX45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 18:56:57 -0500
Date: Tue, 17 Feb 2004 23:54:31 +0000
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@wild-wind.fr.eu.org>
Subject: EISA & sysfs.
Message-ID: <20040217235431.GF6242@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Marc Zyngier <maz@wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm somewhat puzzled about the case where we have a driver
that can work on EISA bus, as well as others, when modprobe'd on
a system that doesn't have an EISA bus.

It seems we do a probe really early on to see if we actually
have an eisa bus, but if a driver later calls eisa_driver_register()
we still do lots of hoop jumping through sysfs/kobjects
before deciding that we don't have the device.

Wouldn't it make sense to have eisa_driver_register() check that the
root EISA bus actually got registered, and if not, -ENODEV
immediately ?

		Dave

