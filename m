Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268640AbTGIWVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268643AbTGIWVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:21:08 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:11274 "EHLO
	light-brigade.mit.edu") by vger.kernel.org with ESMTP
	id S268640AbTGIWVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:21:03 -0400
Date: Wed, 9 Jul 2003 18:35:41 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Jamie Lokier <jamie@shareable.org>
Cc: Gerald Britton <gbritton@alum.mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, emperor@EmperorLinux.com,
       LKML <linux-kernel@vger.kernel.org>,
       EmperorLinux Research <research@EmperorLinux.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Linux and IBM : "unauthorized" mini-PCI : Cisco mpi350 _way_ sub-optimal
Message-ID: <20030709183541.C10882@light-brigade.mit.edu>
References: <1054658974.2382.4279.camel@tori> <20030610233519.GA2054@think> <200307071412.00625.durey@EmperorLinux.com> <1057672948.4358.20.camel@dhcp22.swansea.linux.org.uk> <20030708112016.A10882@light-brigade.mit.edu> <1057678950.4358.53.camel@dhcp22.swansea.linux.org.uk> <20030708132417.B10882@light-brigade.mit.edu> <20030708184421.A13083@flint.arm.linux.org.uk> <20030708205809.GA18307@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030708205809.GA18307@mail.jlokier.co.uk>; from jamie@shareable.org on Tue, Jul 08, 2003 at 09:58:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 09:58:09PM +0100, Jamie Lokier wrote:
> You may be able to identify devices which are very unlikely to be
> touched by the SMI handler, and just allow those to be moved.
> E.g. video cards, USB, IDE, "system", ISA bridge etc. may all be
> touched by the SMI (for power management), but the sound, modem and
> network are much less unlikely.

Often the problem bridges contain such devices, and are surrounded by
them as well, so moving them isn't really all that safe.

Here's another datapoint I found today:
(numbers represent resources).

-+-[host 05]
 +-[ide 08]
 +-[usb 04]
 +-[vga 03]
 +-[audio 02]
 +-[pci bridge 02-06]
   +-[ethernet 07]
   +-[device in slot 01]

The bridge is setup completely wrong, and appears to be entirely transparent
regardless of the resource ranges programmed into it.  X was complaining about
the vga device having an invalid I/O resource (since it was a resource which
is supposedly behind the bridge).  And the devices behind the bridge were
working just fine even with resource allocations outside the range of the
bridge.  Using setpci to edit the bridge configuration made X stop being
concerned about the resources.

				-- Gerald

