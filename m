Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293015AbSCFBv2>; Tue, 5 Mar 2002 20:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293022AbSCFBvV>; Tue, 5 Mar 2002 20:51:21 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:24013 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S293015AbSCFBvE>;
	Tue, 5 Mar 2002 20:51:04 -0500
Date: Tue, 5 Mar 2002 17:51:03 -0800
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: More IrDA patches on the way (2.4.X)...
Message-ID: <20020305175103.D1577@bougret.hpl.hp.com>
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

	Hi Marcelo,

	It's now your turn to get IrDA patches. It's what I sent to
Linus, minus the 2.5.X specific bits.
        Patches have been tested in 2.4.19-pre2 (SMP). All non
critical patches have been on the IrDA list for more than one month
(in particular all the changes to LAP Tx queue).
        Have fun...

        Jean


[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir249_sock_connect_cli.diff :
---------------------------
	o [CRITICA] Fix socket connect to remove dangerous cli()
	<Tested on SMP>

ir249_irnet_disc_ind.diff :
-------------------------
	o [CORRECT] Fix IrNET disconnection to not reconnect but
	  instead to hangup pppd

ir248_lap_icmd_fix-4.diff :
-------------------------
	o [CORRECT] Fix Tx queue handling (remove race, keep packets in order)
	o [CORRECT] Synchronise window_size & line_capacity and make sure
	  we never forget to increase them (would stall Tx queue)
	o [FEATURE] Group common code out of if-then-else
	o [FEATURE] Don't harcode LAP header size, use proper constant
	o [FEATURE] Inline irlap_next_state() to decrease bloat

ir249_usb_cow-2.diff :
--------------------
	o [FEATURE] Don't use skb_cow() unless we really need to
	o [CORRECT] Reorder URB init to avoid races
	o [CORRECT] USB delay adds processing time, not removes it
