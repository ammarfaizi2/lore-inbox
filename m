Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbTCWPOQ>; Sun, 23 Mar 2003 10:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263081AbTCWPOQ>; Sun, 23 Mar 2003 10:14:16 -0500
Received: from franka.aracnet.com ([216.99.193.44]:34185 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263080AbTCWPOP>; Sun, 23 Mar 2003 10:14:15 -0500
Date: Sun, 23 Mar 2003 07:25:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 490] New: psmouse.c fails detecting Microsoft PS/2 wheel mice 
Message-ID: <379510000.1048433118@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=490

           Summary: psmouse.c fails detecting Microsoft PS/2 wheel mice
    Kernel Version: 2.5.65
            Status: NEW
          Severity: normal
             Owner: vojtech@suse.cz
         Submitter: idan@idanso.dyndns.org


Distribution: Debian unstable(sid)
Hardware Environment:  PIII I815e board, microsoft ps/2 whell mouse(IntelliMouse
1.1A)
Software Environment: GPM/XFree 4.2
Problem Description:

Mouse is not detected either built-in or as a module(No notice in dmesg or
whatsoever, XFree/GPM have no interaction with the mouse).

I did however managed to track where the problem comes from, appearently one of
the tests at psmouse_probe() fails for some reason:

/*
 * Then we reset and disable the mouse so that it doesn't generate events.
 */

      if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
              return -1;

Commenting it out solved the problem for me and the mouse is detected and
working flawlessly.


