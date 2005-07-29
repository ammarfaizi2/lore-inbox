Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVG2Ay3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVG2Ay3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVG2AxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:53:02 -0400
Received: from fmr24.intel.com ([143.183.121.16]:55009 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S262258AbVG2Awg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:52:36 -0400
Date: Thu, 28 Jul 2005 17:52:17 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Rajat Jain <rajat.noida.india@gmail.com>
Cc: Kristen Accardi <kristen.kml@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Message-ID: <20050728175217.A1821@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com> <b115cb5f0507241949da02aa7@mail.gmail.com> <512afbf905072711295f87ad24@mail.gmail.com> <b115cb5f05072803451836055c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <b115cb5f05072803451836055c@mail.gmail.com>; from rajat.noida.india@gmail.com on Thu, Jul 28, 2005 at 07:45:49PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2005 at 07:45:49PM +0900, Rajat Jain wrote:
> 
> Okay. I'm sorry but I'm not very clear with this. I'm just putting
> down here my understanding. So basically we have two mutually
> EXCLUSIVE hotplug drivers I can use for PCI Express:
> 
A hotplug slot can be controlled only by a single hotplug
technology - pcie shpc or acpiphp. However, different parts of
the I/O hierarchy can be controlled by different technologies.
For example, a host bridge I/O complex can be hotplugged using
acpiphp, but end devices under this IO complex may be hotpplugged
using pcie or shpc hotplug.

> 1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
> Native Hot-plug for PCI Express (which means that hot-plug will be
> handled by OS single handedly).
> 
> 2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
> allows only ITSELF to handle hot-plug events.
> 
No, acpi hotplug is not handled by BIOS only.
Both acpi and pcie hotplug need firmware support as well as hardware
support. Hardware in many (but not all) systems support both types of
hotplug and its up to the BIOS to decide which type to support. If the
platform supports pcie hotplug, you see an _OSC & _SUN methods in the
ACPI namespace and the pciehp driver controls hotplug slots. If the
system supports acpi hotplug, you see _ADR and _EJ0 methods in the ACPI
namespace and the acpiphp driver controls the corresponding hotplug slots.

Rajesh
