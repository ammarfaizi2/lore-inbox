Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281047AbRK3Uyn>; Fri, 30 Nov 2001 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281027AbRK3Uye>; Fri, 30 Nov 2001 15:54:34 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:7363 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S281047AbRK3UyQ>;
	Fri, 30 Nov 2001 15:54:16 -0500
Date: Fri, 30 Nov 2001 12:54:06 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: IrDA patches on the way...
Message-ID: <20011130125406.A3938@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Classical ritual : I'm going to send a bunch or IrDA patches
for inclusion in 2.4.17 and 2.5.1 kernel. Patch have been around on
IrDA mailing list and torture tested on 2.4.17-pre1, so are ready to
go in.
	Nothing really major this time. 2 fixes for cellular phones
(MIR and min_tx_turn_time), one crasher (self->tsap->lsap->lap) and a
bunch of cleanups.
	No major work on the IrDA stack is planned as yet for 2.5.X,
and most people seem happy with the stack as it is. I'll keep the
stack in <bugfix/minor cleanup/new driver> mode and try to keep 2.4.X
and 2.5.X identical to simplify maintainance until something big
happens (I've got some catch up to do on 802.11).
	Have fun...

	Jean

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir245_vlsi_mir.diff :
-------------------
        <Patch from Martin Diehl>
	o [CORRECT] When MIR is requested, enable MIR on the chip, not FIR

ir245_sysctl-2.diff :
-------------------
	o [CORRECT] Check min/max boundary on various sysctl
	o [FEATURE] Add min_tx_turn_time sysctl and make it default to 10
	  This fixes problem with some broken cellular phones
	o [FEATURE] Simplify retry_count tests
	o [FEATURE] Allow to set the "no activity" event timeout via sysctl
	o [FEATURE] "no activity" event generated each multiple of timeout
	  and not only the first time. This allow apps to know is connectivity
	  is restored (they don't receive anymore the event).

ir245_af_ias.diff :
-----------------
	o [CORRECT] Restrict write access to IAS database to ROOT. Users can
	  only write IAS object attached to their own socket. This avoid apps
	  polluting each other.
	o [FEATURE] Empty IAS classname will refer to object attached to
	  present socket.

ir245_clean_listen.diff :
-----------------------
	o [FEATURE] Put the code to set the socket back to listen mode in
	  common functions instead of cut'n'pasted all over the place.
	o [CRITICA] When setting a socket back to listen mode, set
	  self->tsap->lsap->lap = NULL; to avoid crashing is LAP is
	  removed before the socket.
	o [CORRECT] Fix disconnect event generation. Doh !

ir247_config-2.diff :
-------------------
	o [FEATURE] Remove CONFIG_IRDA_OPTIONS. A menu for only 3 items !
	o [FEATURE] Set various CONFIG_IRDA options default to YES
	o [FEATURE] Advertise more aggressively usage of those options
	  in Configure.help. Too many bug reports of people not using those.
	o [FEATURE] Remove obsolete Configure.help entries

