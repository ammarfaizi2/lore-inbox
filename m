Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281341AbRKHDMc>; Wed, 7 Nov 2001 22:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281342AbRKHDMV>; Wed, 7 Nov 2001 22:12:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:36843 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S281341AbRKHDMN>;
	Wed, 7 Nov 2001 22:12:13 -0500
Date: Wed, 7 Nov 2001 19:11:58 -0800
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linux-irda@pasta.cs.uit.no
Subject: IrDA patches on the way...
Message-ID: <20011107191158.A23773@bougret.hpl.hp.com>
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

	After an important user reported a crash of the IrDA stack, I
did an audit of the disconnect/close code for race conditions. I also
kept in mine to looks for potential skb leaks. Well, that was some
work, but my quest was quite successfull ;-)
	I also fixed a connection setup deadlock that was an old
friend eluding me. And I've been sent an endianess patch that is
necessary for operation on PPC.
	Patches have been on the IrDA mailing list for one week and
have suffered my torture test since, so they are ready to go ;-)

	Regards,

	Jean


[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir243_endian_fix.diff :
---------------------
	<Patch from Michel Denzer and Benjamin Herrenschmidt>
	o [CORRECT] Fix endianess in IrDA parameters management
	  Without this, the IrDA stack doesn't work on PPC :-(

ir243_usb_descr.diff :
--------------------
	<First part is from Martin Diehl>
	o [CORRECT] Use specific get class descriptor and not the standard one
	o [FEATURE] Reduce verbosity of the driver

ir243_lap_lmp_races-2.diff :
--------------------------
	o [CRITICA] Avoid race condition in LSAP closure
	o [CORRECT] Remove potential skb leaks
	o [CORRECT] Add MEDIA_BUSY_TIMER_EXPIRED event to avoid stack deadlock
	o [CORRECT] Do a proper disconnect on RECV_RD_RSP
	o [FEATURE] Cleanup handling of pending LAP connect & Ultra Tx
	o [FEATURE] Add small busy delay after discovery indication
	o [FEATURE] Remove discovery event postponing kludge
	o [FEATURE] cleanups, comments
	o [FEATURE] Reduce verbosity of the stack

ir243_ttp_sock_races-2.diff :
---------------------------
	o [CRITICA] Avoid race condition in TSAP closure
	o [CRITICA] Avoid race condition in socket closure
	o [CRITICA] Avoid various race conditions in IrNET
	o [CORRECT] Remove potential skb leaks
	o [CORRECT] Remove IrNET discovery log leak
	o [CORRECT] Don't export inline function (irda_lock)
	o [FEATURE] Use skb_orphan() instead of skb_clone() + kfree_skb()
	o [FEATURE] cleanups, comments
	o [FEATURE] Reduce verbosity of the stack

ir245_help_obex.diff :
--------------------
	o [FEATURE] Looks like somebody got confused about what IrOBEX is ;-)
