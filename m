Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268335AbTBNKXF>; Fri, 14 Feb 2003 05:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268336AbTBNKXF>; Fri, 14 Feb 2003 05:23:05 -0500
Received: from kim.it.uu.se ([130.238.12.178]:53128 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S268335AbTBNKXE>;
	Fri, 14 Feb 2003 05:23:04 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15948.50644.705291.922086@kim.it.uu.se>
Date: Fri, 14 Feb 2003 11:32:52 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Pavel Machek <pavel@suse.cz>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
In-Reply-To: <Pine.GSO.3.96.1030214100458.666A-100000@delta.ds2.pg.gda.pl>
References: <15947.41003.250547.617866@kim.it.uu.se>
	<Pine.GSO.3.96.1030214100458.666A-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 > On Thu, 13 Feb 2003, Mikael Pettersson wrote:
 > 
 > > +static int __init init_local_apic_devicefs(void)
 > >  {
 > > -	if (apic_pm_state.active)
 > > -		pm_register(PM_SYS_DEV, 0, apic_pm_callback);
 > > +	if (!cpu_has_apic)
 > 
 >  This looks broken -- what if an external local APIC is present?

My goal was to not change any behaviour from our current code, and from
what I can tell, our current code does not support PM suspend and resume
for old external-local-APIC machines. (They're mostly 486 MPs, right?)

The suspend/resume procedures only work on P6/K7 and up. There's a
bug there in that we may try to run the suspend on a UP P5 with enabled
local APIC, which won't work. So far, no one seems to have noticed :->

(Admittedly, the P5 errata sheets say "BIOS should disable the P5 local
APIC on UP" so I don't think this case is very likely.)

/Mikael
