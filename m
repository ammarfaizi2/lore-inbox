Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292318AbSCEWdE>; Tue, 5 Mar 2002 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292294AbSCEWcy>; Tue, 5 Mar 2002 17:32:54 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:27596 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S292293AbSCEWcm>;
	Tue, 5 Mar 2002 17:32:42 -0500
Date: Tue, 5 Mar 2002 14:32:38 -0800
To: Linus Torvalds <torvalds@transmeta.com>, irda-users@lists.sourceforge.net,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: IrDA patches on the way...
Message-ID: <20020305143238.A1254@bougret.hpl.hp.com>
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

	Hi Linus,

	It's now a tradition : here a few patches for you to merge in
the 2.5.6 kernel. A few cleanup that have been waiting for a while,
and a few critical fixes that recently showed up.
	I've asked Jeff if he wanted to be my "Patch Penguin (TM)" for
Linux-IrDA patches, but he was not very enthousiastic about IrDA (I
don't understand why ;-) I'll make seperate patches for Marcello.
	Patches have been tested in 2.5.6-pre2 (SMP). All non critical
patches have been on the IrDA list for more than one month (in
particular all the changes to LAP Tx queue).
        Have fun...

        Jean


[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir256_bus_to_virt.diff :
----------------------
	o [CRITICA] Fix ISA FIR drivers for new DMA API
	<PCI FIR drivers are still broken and need fixing>

ir256_sock_connect_cli.diff :
---------------------------
	o [CRITICA] Fix socket connect to remove dangerous cli()
	<Tested on SMP>

ir256_irnet_disc_ind.diff :
-------------------------
	o [CORRECT] Fix IrNET disconnection to not reconnect but
	  instead to hangup pppd

ir256_lap_icmd_fix-4.diff :
-------------------------
	o [CORRECT] Fix Tx queue handling (remove race, keep packets in order)
	o [CORRECT] Synchronise window_size & line_capacity and make sure
	  we never forget to increase them (would stall Tx queue)
	o [FEATURE] Group common code out of if-then-else
	o [FEATURE] Don't harcode LAP header size, use proper constant
	o [FEATURE] Inline irlap_next_state() to decrease bloat

ir256_usb_cow_urballoc.diff :
---------------------------
	o [FEATURE] Don't use skb_cow() unless we really need to
	o [CORRECT] Reorder URB init to avoid races
	o [CORRECT] USB dealy adds processing time, not removes it
        <Following patch from Greg KH <greg@kroah.com> himself !!!>
	o [CRITICA] Use dynamically allocated URBs (instead of statically)
