Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbTFQBtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 21:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTFQBtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 21:49:15 -0400
Received: from palrel11.hp.com ([156.153.255.246]:7857 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264505AbTFQBtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 21:49:13 -0400
Date: Mon, 16 Jun 2003 19:03:07 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       irda-users@lists.sourceforge.net
Subject: IrDA patches for 2.4.22
Message-ID: <20030617020307.GA30944@bougret.hpl.hp.com>
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

	Hi Marcelo,

	Here is the batch of IrDA patches for 2.4.22. I would
appreciate if you could add them to 2.4.22-preX.

	Most of those patches have been on my web page and in 2.5.X
since 2.4.20 time (an eternity), the last few are more recent but
trivial, so it should be as smooth as usual.
	The first patch make PPP over IrCOMM works properly when using
chat, so pretty important in some corners. The second helps with
interoperability, for example for people with (buggy) Ericsson
phones. Then, a bunch of other minor fixes.
	As far as development of IrDA in 2.4.X, this is the end of the
road. I still plan to provide for 2.4.X essential bug fixes and maybe
driver improvements when needed. 2.5.X is where IrDA development is
happening and is too different from 2.4.X for easy backporting (I
don't want to backport the big structural changes of 2.5.X).
	Have fun...

	Jean

-------------------------------------------------------------

[FEATURE] : Add a new feature to the IrDA stack
[CORRECT] : Fix to have the correct/expected behaviour
[CRITICA] : Fix potential kernel crash

ir241_ircomm_uninit_fix-6.diff :
------------------------------
	o [FEATURE] Fix spelling UNITIALISED => UNINITIALISED
	o [CORRECT] Accept data from TTY before link initialisation
		This seems necessary to avoid chat (via pppd) dropping chars
	o [CRITICA] Remember allocated skb size to avoid to over-write it
	o [FEATURE] Remove  LM-IAS object once connected
	o [CORRECT] Avoid declaring link ready when it's not true

ir241_qos_param-2.diff :
----------------------
	o [FEATURE] Fix some comments
	o [FEATURE] printk warning when we detect buggy QoS from peer
	o [CORRECT] Workaround NULL QoS bitfields
	o [CORRECT] Workaround oversized QoS bitfields
	o [FEATURE] Add sysctl "max_tx_window" to limit IrLAP Tx Window

ir241_lmp_timer_race-2.diff :
---------------------------
	o [CORRECT] Start timer before sending event to fix race condition
	o [FEATURE] Improve the IrLMP event debugging messages.

ir241_export_crc-3.diff :
-----------------------
	o [FEATURE] Export CRC16 helper so that drivers can use it

ir241_secondary_rr.diff :
-----------------------
	o [CORRECT] fix the secondary function to send RR and frames without
		the poll bit when it detect packet losses

ir241_usb_cleanup-4.diff :
------------------------
	o [FEATURE] Update various comments to current state
	o [CORRECT] Handle properly failure of URB with new speed
	o [CORRECT] Don't test for (self != NULL) after using it (doh !)
	o [FEATURE] Other minor cleanups
	o [CORRECT] Add ID for new USB device (thanks to Sami Kyostila)
	o [CORRECT] Fix for big endian platforms (thanks to Jacek Jakubowski)

ir241_iriap_skb_leak.diff :
-------------------------
		<Patch from Jan Kiszka>
	o [CORRECT] Fix obvious skb leak in IrIAP state machines

ir241_caddr_mask.diff :
---------------------
		<Patch from Jan Kiszka>
	o [CORRECT] ignore the C/R bit in the LAP connection address.

ir241_static_init.diff :
----------------------
	o [CORRECT] fix some obvious static init bugs.



