Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265536AbTFWWpj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 18:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265539AbTFWWpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 18:45:39 -0400
Received: from palrel13.hp.com ([156.153.255.238]:36003 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265536AbTFWWp1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 18:45:27 -0400
Date: Mon, 23 Jun 2003 15:59:33 -0700
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: IrDA patches for 2.4.22 (bis)
Message-ID: <20030623225933.GA12593@bougret.hpl.hp.com>
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

	It seems that the previous set of IrDA patches for 2.4.22 got
lost somewhere. As I really want them in 2.4.22-preX, I'm resubmitting
the whole set.

	Those patches :
	o have been tested by me on 2.4.22-pre1
	o have been in 2.5.X for over 6 months
	o have been on my web page for over 6 months
	o are needed by many Linux-IrDA users
	o fixes essential IrDA bugs and are limited in scope.

	Patches to follow in separate e-mail...
	Thanks in advance...

	Jean

--------------------------------------------------------------

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

