Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTIEVku (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 17:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbTIEVkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 17:40:49 -0400
Received: from palrel12.hp.com ([156.153.255.237]:4224 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262799AbTIEVkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 17:40:36 -0400
Date: Fri, 5 Sep 2003 14:40:30 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.6.X
Message-ID: <20030905214030.GA14233@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Jeff,

	Various IrDA patches. Some you have already seen, some
finishing stuff started, and a few nice critical bugs/race conditions
I spent the week tracking for a user.
        Patches tested on 2.6.0-test4, please push to Linus...

	Thanks...

	Jean

----------------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir2604_ircomm_owner-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Finish removing traces of old module refcount stuff

ir260_nsc_39x_fixes.diff :
~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Jan Frey>
	o [CORRECT] Make NSC 3839x probe and init *really* work
		The new 3839x code was totally broken.
		Won't affect code for regular 38108/38338 chips.

ir2604_irtty_cleanup-2.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [FEATURE] Finish removing traces of old irtty driver

ir2604_lap_close_race-5.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] Fix a race condition when closing the LAP
		prevent the stack to open new LSAPs while we are killing them.

ir2604_connect_watchdog-5.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CRITICA] In case of connect watchdog, drop reference to the LAP
	o [CORRECT] Prevent dumping LSAP after connect watchdog
	o [CRITICA] Prevent dumping TSAP if dumping LSAP did fail
	o [CORRECT] Only set connected bit on response if LSAP state is correct

ir2604_init_cleanup-6.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Guennadi Liakhovetski>
	o [FEATURE] Don't leak stuff in various failure paths
	o [FEATURE] Properly initialise self->max_header_size in IrIAP

ir2604_modules_aliases.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~~
		<Patch from Rusty Russell>
	o [FEATURE] Add module aliases to dongle drivers

