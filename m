Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261800AbREPGe2>; Wed, 16 May 2001 02:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbREPGeS>; Wed, 16 May 2001 02:34:18 -0400
Received: from ameise.opto.de ([62.154.242.130]:2659 "HELO ameise.opto.de")
	by vger.kernel.org with SMTP id <S261800AbREPGeJ>;
	Wed, 16 May 2001 02:34:09 -0400
Date: Wed, 16 May 2001 08:34:00 +0200 (CEST)
From: Christoph Biardzki <cbi@cebis.net>
To: linux-kernel@vger.kernel.org
Subject: Storage - redundant path failover / failback - quo vadis linux?
Message-ID: <Pine.LNX.4.21.0105160815100.10476-100000@ameise.opto.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,


I was investigating redundant path failover with FibreChannel disk devices
during the last weeks. The idea is to use a second, redundant path to a
storage device when the first one fails. Ideally one could also implement
load balancing with these paths.

The problem is really important when using linux for mission-critical
applications which require large amounts of external storage.


There are two solutions for Linux at the moment:


- The "T3"-Patch for 2.2-Kernels which patches the sd-Driver und the
Qlogic-FC-HBA-Driver. When you pull an FC-Cable on a host equiped with two
HBAs the failover is almost immediate and an automatic failback (after
"repairing") is possible


- The "multipath"-Personality-patch for the md-Driver by Ingo Molnar
(intergrated in the redhat 2.4.2-Kernel) You set up an md-device on
two devices (which are actually the same physical device seen twice on the
dual paths) and when the primary one fails, the system will access the
other one. There seems to be no failback possibility, however, and the
failover takes around 30s.


My question is which way is the more probable solution for future linux
kernels?

The low-level-approach of the "T3"-patch requires changes to the
scsi-drivers and the hardware-drivers but provides optimal communication
between the driver and the hardware

The high-level-approach of the "multipath"-personality is
hardware-independant but works very slowly. On the other hand I see no
clear way how to check for availability of the (previously failed) primary
channel to automate a fail-back.

Neither driver imlement load-balancing at the moment.




Does anyone have an idea how these integration problems are solved in ther
OSs?


Best regards,




Christoph

