Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSFDWCF>; Tue, 4 Jun 2002 18:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSFDWCE>; Tue, 4 Jun 2002 18:02:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:37850 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S316844AbSFDWCC>;
	Tue, 4 Jun 2002 18:02:02 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15613.14457.3095.983212@argo.ozlabs.ibm.com>
Date: Wed, 5 Jun 2002 08:00:25 +1000 (EST)
To: Patrick Mochel <mochel@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
In-Reply-To: <Pine.LNX.4.33.0206040749530.654-100000@geena.pdx.osdl.net>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel writes:

> The problem: bus_types are registered with the system, which intializes 
> all the internal fields, making them ready for use. The PCI bus is being 
> probed before the PCI bus type has been registered. 

We hit this on PPC too.

> Can pcibios_init() be demoted to a device_initcall? This would delay 
> probing until all the subsystems could be setup...

No, because we have device drivers that are initialized with a
device_initcall and which reasonably expect the PCI subsystem to be
set up before they are called.

I can see two solutions: either rename "unused_initcall" to "sys_init"
or something similar and use it for sys_bus_init, or else make an
alias for fs_initcall called "bus_init" or something and use that for
pcibios_init.

Paul.
