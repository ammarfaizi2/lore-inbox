Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268230AbUI2GsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268230AbUI2GsG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 02:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUI2GsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 02:48:06 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:34158 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268230AbUI2GsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 02:48:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/8] Set of input (psmouse) patches
Date: Wed, 29 Sep 2004 01:40:53 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409290140.53350.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

Here is new bunch of small psmouse patches. Nothing particularly interesting
except probably exporting rate, resolution, resetafter and smartscroll
parameters as sysfs attributes. Protocol exporting and switching is still
in progress though... 

01-alps-signature.patch
        - add a new signature to ALPS response table (Inspiron 8500)

02-rate-resolution-handlers.patch
        - add set_rate and set_resolution handlers to psmouse structure
	  to reduce dependencies between protocols, helps wihen exporting
          resolutin and rate via sysfs

03-synaptics-guest-protocol-switch.patch
        - not only set 4 byte guest protocol but also reset it back to 3
          if for some odd reason user reconnects guest requesting lower
          protocol.

04-psmouse-probe-fix.patch
	- patch from Marko Macek dealing with probing and his KVM (the thing
          doctors stream and gets confused by the extended probes)

05-psmouse-sysfs-attr.patch
        - export rate, resolution, resetafter and smartscroll as sysfs
          attributes.

06-psmouse-drop-ps2tpp.patch
        - get rid of PS2T++ protocol symbol as it it handled exactly the same
          as PS2++. This leaves space for THINKPS protocol and allows keeping
          old Synaptics and Alps protocol numbers that Synaptics X driver
          relied on.
 
07-separate-ps2pp-handling.patch
        - complete separation of PS2++ protocol deconding by moving everything
          into logips2pp.c - cleanup. 

08-psmouse-packet-size.patch
        - add pktsize to psmouse structure and check it instead on relying on
          protcol numbering. Also rearrange detect routines in preparation to
          dynamic protocol switching via sysfs.

Please let me know what you think and I will push it on bkbits.

Thanks!

-- 
Dmitry
