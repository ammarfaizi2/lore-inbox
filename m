Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbUB2O5j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 09:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUB2O5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 09:57:39 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:64668 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262058AbUB2O5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 09:57:37 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 0/9] New set of input patches
Date: Sun, 29 Feb 2004 09:57:31 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402290957.31374.dtor_core@ameritech.net>
X-Amavis-Alert: BAD HEADER Improper use of control character (char 0D hex) in message header 'User-Agent'
  User-Agent: KMail/1.6\r\n                       ^
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend, list seems to have eaten first copy.


Hi Vojtech,

Here is the new set of input patches that I have. You have seen some of
them, buit this time they are rediffed against 2.6.4-rc1 and in nice order.

01-atkbd-whitespace-fixes.patch
	simple whitespace fixes

02-atkbd-bad-merge.patch
	clean up bad merge in atkbd module (get rid of MODULE_PARMs,
        atkbd_softrepeat was declared twice)

03-synaptics-relaxed-proto.patch
	some hardware (PowerBook) require relaxed Synaptics protocol checks,
        but relaxed checks hurt hardware implementing proper protocol when
        device looses sync. With the patch synaptics driver analyzes first
        full data packet and either staus in relaxed mode or switches into
        strict mode.

04-psmouse-whitespace-fixes.patch
	simple whitespace fixes

05-psmouse-workaround-noack.patch
	some mice do not ACK "disable streaming mode" command causing psmouse
        driver abort initialization without any indication to the user. This
        is a regression compared to 2.4. Have kernel complain but continue
        with prbing hardware (after all we got valid responce from GET ID
	command).

06-module-param-array-named.patch
	introduce module_param_array_named() modeled after module_param_named
	that allows mapping array module option to

07-joystick-module-param.patch
	complete moving input drivers to the new way of handling module
	parameters using module_param()

08-obsolete-setup.patch
	introduce __obsolete_setup(). This is a drop-in replacement for
        __setup() for truly obsolete options. Kernel will complain when sees
        such an option.

09-input-obsolete-setup.patch
	document removed or renamed options in input drivers using
	__obsolete_setup() so users will have some clue why old options
        stopped having any effect.

-- 
Dmitry
