Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVDDGOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVDDGOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVDDGOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:14:07 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:41308 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261218AbVDDGOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:14:02 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/4] Input patches for 2.6.12
Date: Mon, 4 Apr 2005 01:10:12 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504040110.13315.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I have some patches that I would like to get in before 2.6.12 is out:

01-serio-resume-fix.patch
  - do not attempt to disconnect port in resume handler if reconect
    failed - let kseriod handle it. This fixes problem with swsusp
    resuming devices before writing the image. If reconnect fails
    at this point serio core will try to disconnect port and unregister
    associated input device invoking hotplug which will block since
    the system is half-frozen.

02-alps-reconnect-fix.patch
  - apparently ALPS needs a reset before it starts responding with
    proper IDs to the E6/E7 queries.

03-serport-oops-fix.patch
  - serport should not call serio_interrupt or serio_write_wakeup on
    unregistered port (happens if you move mouse aroung while shutting
    down the system), also dynamic serio allocation needed to be reworked
    to awoid memory leaks in case serport was never used.

04-serio-id-attribute-group.patch
  - move serio port's 'id' attributes into separate subdirectory using
    attribute group:
	..devices/serioX/id_type  -> ..devices/serioX/id/type
	..devices/serioX/id_proto -> ..devices/serioX/id/proto
    ID attributes were never part of a released kernel so if we were to
    do the change now would be the time. 

I have confirmation reports for patches 1-3. Please let me know what you
think.

Thanks!
 
-- 
Dmitry
