Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbUCKHjP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUCKHjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:39:15 -0500
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:48254 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262221AbUCKHjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:39:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/3] Input patches
Date: Thu, 11 Mar 2004 02:26:23 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403110226.23897.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have some more input patches I'd like you to take look at:

psmouse_cleanup_fix:
	When disconnecting PS/2 mouse we marekd it as PSMOUSE_IGNORE too
	early, before protocol's disconnect handler had a chance to run.
	When mouse is in PSMOUSE_IGNORE state it ignores everything,
	including ACKs, which causes cleanup routine to fail.

synaptics-passthrough-fix:
	If touchpad does not support extended protocols (imps, exps) then
	after probing foor said protocols trackpoint on the pass-though
	port may stop working and full reset is needed to revive it
        (just reset-disable is not enough).

synaptics-restore-taps:
	If Synaptics' absolute mode is disabled (by proto= option) make
	sure that touchpad is in relative mode and gestures (taps) are
	enabled. We need specifically reset the mode byte as even full
	reset does not affect it (except for absolute bit).

The patches depend on other input patches submitted earlier. All patches are
available at:

	bk pull bk://dtor.bkbits.net/input
	http://www.geocities.com/dt_or/input/2_6_4

-- 
Dmitry
