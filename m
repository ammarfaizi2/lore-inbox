Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262332AbUJ0IQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262332AbUJ0IQa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 04:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUJ0IPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 04:15:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36995 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262328AbUJ0IPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 04:15:04 -0400
Date: Wed, 27 Oct 2004 04:14:43 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, <linux-acpi@intel.com>
Subject: Re: 2.6.10-rc1-mm1
In-Reply-To: <20041026233307.53f37a6c.akpm@osdl.org>
Message-ID: <Xine.LNX.4.44.0410270409370.8390-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Andrew Morton wrote:

> My guess would be that you died here:
> 
> 	list_add_tail(&driver->node, &acpi_bus_drivers);
> 
> in acpi_bus_register_driver().  Which means that some _other_ acpi driver
> structure on that list is scrogged.  Perhaps it was marked __init or
> something.
> 
> Can you debug it a bit?  Maybe print the addresses and names of the drivers
> as they get registered in acpi_bus_register_driver() and also print out
> acpi_bus_drivers.prev.  If we can get the name of the offending driver
> we'll be able to find the bug.

Interestingly, the debug printks are not showing up in
acpi_bus_register_driver() before the oops, and they should be if that's
where it's happening.  Compiling with debug info makes the oops go away.

Here's some debugging of the last few drivers to be registered before the 
oops is seen:

name=hpet node=c03ee9a0 acpi_bus_drivers.prev=c03ea6a0
name=i8042 node=c03eeda0 acpi_bus_drivers.prev=c03ee9a0
name=floppy node=c03f24c0 acpi_bus_drivers.prev=c03ee9a0


Note acpi_bus_drivers.prev for floppy was not set to c03eeda0, which you 
would normally expect?


- James
-- 
James Morris
<jmorris@redhat.com>


