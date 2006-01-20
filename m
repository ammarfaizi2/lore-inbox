Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWATBYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWATBYr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 20:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWATBYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 20:24:47 -0500
Received: from fmr17.intel.com ([134.134.136.16]:64653 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030454AbWATBYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 20:24:46 -0500
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4] Hot Dock/Undock support
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: dtor_core@ameritech.net, linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <20060118145116.GA2757@ucw.cz>
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
	 <20060118194554.GA1502@elf.ucw.cz> <1137618370.31839.12.camel@whizzy>
	 <20060118222348.GG1580@elf.ucw.cz> <1137629220.31839.56.camel@whizzy>
	 <d120d5000601190723k3339f92eufc3bc1d0832f6058@mail.gmail.com>
	 <20060118145116.GA2757@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 17:27:33 -0800
Message-Id: <1137720453.13079.22.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 20 Jan 2006 01:24:33.0565 (UTC) FILETIME=[44D714D0:01C61D60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 14:51 +0000, Pavel Machek wrote:
> Hi!
> 
> > > > Hope this helps.
> > > >                                               Pavel
> > >
> > >
> > > so the problem that I see is that this dsdt defines two separate dock
> > > devices, one outside the scope of pci, and one within it.  The one
> > > outside the scope of pci defines the _EJ0 and _DCK methods.  So, when
> > > acpiphp loads, it scans the pci slots for ejectable slots, finds none
> > > (because _EJ0 is defined in the dock device that is outside the scope of
> > > pci) and exits.  This dsdt is different from the others I've used in
> > > that most of them define all methods related to docking under the actual
> > > dock bridge (within the scope of pci).  perhaps some acpi people can
> > > shed some light on the best way to handle this - otherwise I'm sure I
> > > can hack something up that will be less than acceptable :).
> > >
> > 
> > ACPI has (had?) a braindamage - it drops devices that do not present
> > when initially scanning ACPI namespace. So if you boot undocked - too
> > bad. Driver won't ever see your docking station.
> 
> I think I booted docked....
> 

Yeah, that's not the problem here.  The problem is that I assumed that
all _DCK methods would be defined under the actual pci dock bridge
device.  It seems that was a bad assumption.  I am redoing this patch so
as to not assume that anymore.  I'll repost it as soon as I'm done with
a little bit of testing.

