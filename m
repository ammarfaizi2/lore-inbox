Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268353AbTBNLQI>; Fri, 14 Feb 2003 06:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268356AbTBNLQI>; Fri, 14 Feb 2003 06:16:08 -0500
Received: from kim.it.uu.se ([130.238.12.178]:54152 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S268353AbTBNLQH>;
	Fri, 14 Feb 2003 06:16:07 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15948.53826.813484.291297@kim.it.uu.se>
Date: Fri, 14 Feb 2003 12:25:54 +0100
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Pavel Machek <pavel@suse.cz>, John Levon <levon@movementarian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
In-Reply-To: <Pine.GSO.3.96.1030214115026.666C-100000@delta.ds2.pg.gda.pl>
References: <15948.50644.705291.922086@kim.it.uu.se>
	<Pine.GSO.3.96.1030214115026.666C-100000@delta.ds2.pg.gda.pl>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 >  OK, but then the question is: are the following calls:
 > 
 > +	driver_register(&local_apic_driver);
 > +	return sys_device_register(&device_local_apic);
 > 
 > for suspend/resume exclusively?

Yes.

We could register the device also in other cases (!PM, SMP)
but the methods would then be nullified and we'd have a device
node with a name but no operations. I could do that, I just
think it's pointless.

Getting suspend to work on SMP is a separate project. This
patch is just about upgrading to the new infrastructure.

/Mikael
