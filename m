Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVGMX7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVGMX7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 19:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVGMX5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 19:57:15 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:25035 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261747AbVGMRXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:23:33 -0400
Subject: Synaptics probe problem on Acer Travelmate 3004WTMi
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: linux-input@atrey.karlin.mff.cuni.cz, vojtech@suse.cz,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: private
Date: Wed, 13 Jul 2005 19:23:28 +0200
Message-Id: <1121275408.3583.35.camel@playstation2.hb9jnx.ampr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-01.tornado.cablecom.ch 32701; Body=3
	Fuz1=3 Fuz2=3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I've got a problem with my Acer Travelmate 3004WTMi Laptop: vanilla 2.6
does not detect the synaptics touchpad.

The problem lies within psmouse_probe: after the PSMOUSE_CMD_GETID
command, param[0] contains 0xfa, and not one of the expected values. If
I just ignore this and continue, the synaptics pad is detected and
everything works ok.

Tom


static int psmouse_probe(struct psmouse *psmouse)
 642 {
 643         struct ps2dev *ps2dev = &psmouse->ps2dev;
 644         unsigned char param[2];
 645 
 646 /*
 647  * First, we check if it's a mouse. It should send 0x00 or 0x03
 648  * in case of an IntelliMouse in 4-byte mode or 0x04 for IM
Explorer.
 649  * Sunrex K8561 IR Keyboard/Mouse reports 0xff on second and
subsequent
 650  * ID queries, probably due to a firmware bug.
 651  */
 652 
 653         param[0] = 0xa5;
 654         if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETID))
 655                 return -1;
 656 
 657         if (param[0] != 0x00 && param[0] != 0x03 &&
 658             param[0] != 0x04 && param[0] != 0xff)
 659                 return -1;
 660 

