Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423958AbWKIApj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423958AbWKIApj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 19:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423960AbWKIApj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 19:45:39 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:25534 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423958AbWKIApi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 19:45:38 -0500
Subject: [PATCH 0/2] Add dev_sysdata and use it for ACPI
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Content-Type: text/plain
Date: Thu, 09 Nov 2006 11:45:21 +1100
Message-Id: <1163033121.28571.792.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed on linux PCI, these 2 patches:

 - Add a dev_sysdata structure to struct device whose content is arch
specific. It will allow architectures like powerpc, arm, i386, ... who
need different types of DMA ops for busses and other kind of auxilliary
data for devices in general (numa node id, firmware data, etc...) to put
them in there, without bloating all architectures. The patch adds an
empty definition for the structure to all architectures.

 - As an example (patch test built but not test booted), I removed ACPI
usage of device->firmware_data, removed the firmware_data field
completely from struct device (as it was, apparently, the only user),
and instead used an "acpi_handle" field in x86 and x86_64 dev_sysdata.

I'd like to adapt my pending 2.6.20 patch set to use that instead of my
current "device_ext" thingy I've been doing, but that would mean having
an ack from Greg to merge the first patch in 2.6.20. Thus I'd like
feedback asap. The second patch is less critial, though Len is free to
take it and do whatever he wants with it :-)

Cheers,
Ben.



