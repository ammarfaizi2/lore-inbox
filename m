Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbTBIOCB>; Sun, 9 Feb 2003 09:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTBIOCB>; Sun, 9 Feb 2003 09:02:01 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:2824 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S267261AbTBIOCA>;
	Sun, 9 Feb 2003 09:02:00 -0500
Date: Sun, 9 Feb 2003 14:11:42 +0000
From: John Levon <levon@movementarian.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030209141142.GA24374@compsoc.man.ac.uk>
References: <200302091407.PAA14076@kim.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302091407.PAA14076@kim.it.uu.se>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18hsBL-000Fip-00*w7SgJKt.C2c*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 03:07:27PM +0100, Mikael Pettersson wrote:

> I don't like the idea of registering apic_driver when !cpu_has_apic,
> but it might be needed for the local-APIC NMI watchdog.

Really ?

> >+#define NMI_LOCAL_APIC_SUSPENDED_BY_OPROFILE	4
> 
> This is ugly like h*ll. Surely oprofile could just do:
> 
> static unsigned int prev_nmi_watchdog;
> ..
> prev_nmi_watchdog = nmi_watchdog;

as long as it's exported to modules. I'd probably prefer
to just have :

	disable_nmi_watchdog();
	...
	enable_nmi_watchdog();

and have those do the right thing depending on a (nmi.c local)
nmi_watchdog.

regards,
john
