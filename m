Return-Path: <linux-kernel-owner+w=401wt.eu-S1755255AbXABEap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbXABEap (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 23:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXABEap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 23:30:45 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44270
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755255AbXABEao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 23:30:44 -0500
Date: Mon, 01 Jan 2007 20:30:43 -0800 (PST)
Message-Id: <20070101.203043.112622209.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: segher@kernel.crashing.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167710760.6165.32.camel@localhost.localdomain>
References: <445cb4c27a664491761ce4e219aa0960@kernel.crashing.org>
	<20070101.005714.35017753.davem@davemloft.net>
	<1167710760.6165.32.camel@localhost.localdomain>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jan 2007 15:05:59 +1100

> It has proved a good idea in general as I can easily get an exact
> device-tree dump from users by asking for a tarball of /proc/device-tree
> and in some case, the data in there -is- binary (For example, the EDID
> properties for monitors left by video drivers, or things like that).

Yes and with openpromfs I can get the EDID too :-)

root@sunset:/proc/openprom/pci@1f,700000/SUNW,XVR-100@3# cat edid 
00ffffff.ffffff00.4dd9d000.67175700.2d0d0103.0e321f78.eacea9a3.574c9926.19484cbd.ee80a940.81808140.01010101.01010101.0101734b.80a072b0.2a4080d0.1300ef35.1100001c.483f4030.62b03240.40c01300.ef351100.001e0000.00fd0037.411e5f14.000a2020.20202020.000000fc.0053444d.2d503233.32570a20.202000af
root@sunset:/proc/openprom/pci@1f,700000/SUNW,XVR-100@3# 

I think there is high value in an OFW filesystem representation
that gives you _EXACTLY_ what the OFW command line prompt does
when you try to traverse the device tree from there, and that
is what openpromfs tries to do.

If you want raw access, use a character device or a similar auxilliary
access to the data items.  Another idea is to provide a seperate file
operation (such as ioctl) on the OFW property files in order to fetch
things raw and in binary.

When I get some binary data out of a procfs or sysfs file I feel like
strangling somebody.  I'm grovelling around in a filesystem from the
command line so that I can get some information as a user.  If you
don't give me text I can't tell what the heck it is.

Simple system tools should not need to interpret binary data in
order to provide access to simple structured data like this, that's
just stupid.
