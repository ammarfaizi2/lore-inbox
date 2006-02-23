Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWBWVgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWBWVgQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbWBWVgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:36:15 -0500
Received: from fmr20.intel.com ([134.134.136.19]:60804 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751354AbWBWVgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:36:14 -0500
Subject: Re: [patch 0/3] New dock patches
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, greg@kroah.com,
       len.brown@intel.com, muneda.takahiro@jp.fujitsu.com
In-Reply-To: <20060223210525.GA1735@elf.ucw.cz>
References: <1140636081.32574.18.camel@whizzy>
	 <20060223210525.GA1735@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 23 Feb 2006 13:41:21 -0800
Message-Id: <1140730882.11750.33.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 23 Feb 2006 21:36:02.0621 (UTC) FILETIME=[24F04ED0:01C638C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-23 at 22:05 +0100, Pavel Machek wrote:
> Hi!
> 
> > Hello, this is a new set of docking station patches which replaces
> > the old docking station patches.  It applies to 2.6.16-rc4-mm1.  It
> > is new and improved over the old version, in that it can now handle
> > laptops which define docking stations outside of the scope of PCI.
> > 
> > Thanks to everyone who provided feedback on the original patches, and
> > especially to Pavel who is the only brave soul to test these patches
> > out so far :).  As always, I would appreciate feedback on these 
> > patches.
> 
> I tested the new version from today... it works okay. It produces some
> weird messages:
> 
> acpiphp: Slot [4294967295] registered
> ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
> [c1d081e8] [20060210]
> PCI: Found IBM Dock II Cardbus Bridge applying quirk
> PCI: Found IBM Dock II Cardbus Bridge applying quirk
> PCI: Transparent bridge - 0000:02:03.0
> PCI: Bus #0c (-#0f) is hidden behind transparent bridge #02 (-#0b)
> Please report the result to linux-kernel to fix this permanently
> PCI: Bus #10 (-#13) is hidden behind transparent bridge #02 (-#0b)
> Please report the result to linux-kernel to fix this permanently
> ACPI Exception (acpi_bus-0072): AE_NOT_FOUND, No context for object
> [c1d02368] [20060210]
> 
> Could the code be fixed not to start numbering slots from -1?
> 
> 								Pavel

Yeah, the problem is that laptops don't implement _SUN, which is used
for the slot numbering by the existing acpiphp code.  So the slot number
will read -1 if _SUN is missing.  I'm not sure if 0 is a valid slot
number, and I wasn't sure if that would make sense either.  I think that
I'm going to have to provide a separate user space interface to the dock
anyway, since we now know that it's possible to have a dock station that
has no pci slots at all.
