Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbTI3Gcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbTI3G2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:28:44 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:37204 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263148AbTI3G2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:28:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: 2.6: New set of input patches
Date: Tue, 30 Sep 2003 01:24:15 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309300052.49908.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have a bunch of input patches that work quite nicely on my laptop, 
would you please consider taking them?

1. SERIO: rename serio_{register|unregister}_slave_port to
          __serio_{register|unregister}_port to better follow
          locked/lockless naming convention.

2. SERIO: There is a possibility that serio might get deleted while there
     	  are outstanding events involving that serio waiting for kseriod
          to process them. Invalidate them so kseriod thread will just
          drop dead events. (Resend)

3. Input: Introduce an optional blacklist field in input_handler structure.
          When loading a new device or a new handler try to match device
          against handler's black list before doing match on required
          attributes.
          This allows to get rid of "surprises" in connect functions, IMO
          connect should only fail when it physically can not connect, not
          because it decides it does not like device.

4. Input: Synaptics code cleanup and credit update. The switch in 
          synaptics_process_packet() was quite ugly.

5. SERIO: serio_reconnect added. Similar to serio_rescan but gives driver
          a chance to re-initialize keeping the same input device. (Resend)

6. Input/Synaptics:
   - Support for pass-through port moved from Synaptics driver to psmouse
     itself, it is cleaner and should allow using it in other drivers if
     needed.
   - The driver makes use of new reconnect functionality in serio. It will
     try to keep the same input device after resume or when it resets itself.
   - If mouse is disconnected or other mouse plugged in while sleeping the
     driver should correctly recognize that and create a new serio/input
     device. (Resend, original patch split into 2 - #4 & #6) 

Dmitry
