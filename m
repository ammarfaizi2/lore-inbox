Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWGLOq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWGLOq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 10:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWGLOq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 10:46:56 -0400
Received: from 68-191-203-42.static.stls.mo.charter.com ([68.191.203.42]:36421
	"EHLO service.eng.exegy.net") by vger.kernel.org with ESMTP
	id S1751381AbWGLOqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 10:46:55 -0400
Message-ID: <44B50B5C.2090802@exegy.com>
Date: Wed, 12 Jul 2006 09:46:52 -0500
From: Dave Lloyd <dlloyd@exegy.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Berkley Shands <bshands@exegy.com>
Subject: MegaRaid 8408E goes out to lunch with nr_requests > 8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Jul 2006 14:46:52.0444 (UTC) FILETIME=[034FD5C0:01C6A5C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happens both on 2.6.17 and 2.6.18rc1 using the megaraid, mptsas and
mptscsih drivers supplied with the kernel.

While writing data to raid0 devs on a LSI MegaRaid 8408E controller, the
devices will hang after somewhere between 4-7gb of data written.  If I
dial the nr_requests back from the default down to 8, the hang will not
occur.  The hang does occur at 16.  I haven't tested values between the
two, but I'm not too optimistic.  From what I can see, it looks like 8
should be a magic number to make the queue look congested more often
than not.

Here are the messages I get when the devices go out to lunch:
Jul 11 14:13:34 systemname kernel: sd 4:2:0:0: megasas: RESET -40213 cmd=2a
Jul 11 14:13:34 systemname kernel: megasas: [ 0]waiting for 256 commands
to complete
Jul 11 14:13:39 systemname kernel: megasas: [ 5]waiting for 256 commands
to complete
Jul 11 14:13:44 systemname kernel: megasas: [10]waiting for 256 commands
to complete
Jul 11 14:13:49 systemname kernel: megasas: [15]waiting for 256 commands
to complete

[...]

Jul 11 14:16:35 systemname kernel: megasas: [175]waiting for 256
commands to complete
Jul 11 14:16:35 systemname kernel: megasas: failed to do reset
Jul 11 14:16:35 systemname kernel: sd 4:2:1:0: megasas: RESET -40216 cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: megasas: RESET -40213 cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: megasas: RESET -40213 cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: scsi: Device offlined -
not ready after error recovery
Jul 11 14:16:36 systemname last message repeated 13 times

Interestingly, the machine will hang on shutdown and requires a hard
reset to reboot.  Bummer!

My next step is to try and reproduce and dig into this some in KDB.

Has anyone else seen this and/or does anyone have some suggestions for
further debugging info?

-- 
Dave Lloyd
Test Engineer, Exegy, Inc.
314.450.5342
dlloyd@exegy.com


-- 
Dave Lloyd
Test Engineer, Exegy, Inc.
314.450.5342
dlloyd@exegy.com
