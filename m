Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161256AbWGNEab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161256AbWGNEab (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 00:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161258AbWGNEab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 00:30:31 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.143]:27964 "EHLO
	HQEMGATE02.nvidia.com") by vger.kernel.org with ESMTP
	id S1161256AbWGNEaa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 00:30:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Athlon64 + Nforce4 MCE panic
Date: Thu, 13 Jul 2006 21:30:28 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B014AD9B84@hqemmail02.nvidia.com>
In-Reply-To: <20060713090146.690d4759.rumi_ml@rtfm.hu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Athlon64 + Nforce4 MCE panic
Thread-Index: AcamSQ01feLyJu2bTz6m//MHZpNTqQAtOGTQ
From: "Allen Martin" <AMartin@nvidia.com>
To: "Rumi Szabolcs" <rumi_ml@rtfm.hu>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Jul 2006 04:30:23.0709 (UTC) FILETIME=[392248D0:01C6A6FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPU 0: Machine Check Exception: 0000000000000004
> Bank 4: b200000000070f0f
> Kernel panic - not syncing: CPU context corrupt
> 
> I tried to decode this:
> 
> # ./parsemce -e 0000000000000004 -b 4 -s b200000000070f0f -a 0
> Status: (4) Machine Check in progress.
> Restart IP invalid.
> parsebank(4): b200000000070f0f @ 0
>         External tag parity error
>         CPU state corrupt. Restart not possible
>         Error enabled in control register
>         Error not corrected.
>         Bus and interconnect error
>         Participation: Generic
>         Timeout:
>         Request: Generic error
>         Transaction type : Invalid
>         Memory/IO : Other

I'm not sure why parsemce says this is a parity error, it's a K8 virtual
northbridge watchdog timeout on an I/O transaction.   In other words a
CPU PIO transaction to some device timed out, the timeout is usually set
to 10s.  Prior to K8 these types of errors would usually be system
hardlocks.

I've debugged a few of these before and they usually end up being IDE
device issues.  The IDE controller is really thin (the ATA registers
actually reside in the device) so for example if the CPU goes to read
the ATA status register of some device and the device doesn't respond,
the PCI transaction won't be terminated and the watchdog will fire.

-Allen

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
