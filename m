Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964781AbWGMPZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWGMPZW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 11:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWGMPZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 11:25:22 -0400
Received: from mail0.lsil.com ([147.145.40.20]:18422 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S964781AbWGMPZW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 11:25:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: MegaRaid 8408E goes out to lunch with nr_requests > 8
Date: Thu, 13 Jul 2006 09:25:09 -0600
Message-ID: <0631C836DBF79F42B5A60C8C8D4E82295CE933@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: MegaRaid 8408E goes out to lunch with nr_requests > 8
Thread-Index: AcalwkMJ8F+w/UqiSayFly0cv1+FRAAzavIg
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "Dave Lloyd" <dlloyd@exegy.com>, <linux-kernel@vger.kernel.org>,
       "Berkley Shands" <bshands@exegy.com>
Cc: "Kolli, Neela" <Neela.Kolli@engenio.com>
X-OriginalArrivalTime: 13 Jul 2006 15:25:11.0695 (UTC) FILETIME=[882F71F0:01C6A690]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dave,

	I tried to duplicate the issue with 2.6.18rc1 but did not see
the issue. From the message it looks like the Firmware has stopped
processing cmds. Could you please let us know the Firmware version of
the controller ? 

Thanks,

Sumant

-----Original Message----- 
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Dave Lloyd
Sent: Wednesday, July 12, 2006 7:47 AM
To: linux-kernel@vger.kernel.org; Berkley Shands
Subject: MegaRaid 8408E goes out to lunch with nr_requests > 8

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
Jul 11 14:13:34 systemname kernel: sd 4:2:0:0: megasas: RESET -40213
cmd=2a
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
Jul 11 14:16:35 systemname kernel: sd 4:2:1:0: megasas: RESET -40216
cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: megasas: RESET -40213
cmd=2a
Jul 11 14:16:35 systemname kernel: megasas: cannot recover from previous
reset failures
Jul 11 14:16:35 systemname kernel: sd 4:2:0:0: megasas: RESET -40213
cmd=2a
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
