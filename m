Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280095AbRKEBpm>; Sun, 4 Nov 2001 20:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280101AbRKEBpc>; Sun, 4 Nov 2001 20:45:32 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:63986 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S280095AbRKEBpM>; Sun, 4 Nov 2001 20:45:12 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15333.61209.654717.854764@hoggar.fisica.ufpr.br>
Date: Sun, 4 Nov 2001 23:44:57 -0200
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-ac7: INSTANT DEATH with ServerWorks
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

2.4.13-ac7, and 2.4.12-ac10, lock hard without a trace with the
SuperMicro DE6 motherboard, which uses the ServerWorks chipset. The
problem seems to be triggered by intense IO simultaneously in both IDE
and SCSI. It's a total freeze, no answers to the net nor SysRq.

Details: The problem is easily reproducible with raid. I built several
two-disk raid0 arrays, all of them consisting of SCSI and one of them
IDE. The SCSI arrays use both the motherboard AIC chips and a
symbios/ethernet combo. Then I made a raid5 assembly of the several
raid0 arrays plus some extra SCSI partitions. The machine freezes as
soon as it starts to calculate the parity of the raid5.

I then joined all the SCSI disks in the raid5 array, but excluded the
IDE raid0, and it works fine after copying some 4GB. I copied about
1.6GB to the IDE raid0 array alone also without problems. However,
copying simultaneously to the SCSI raid5 and IDE raid0 locks the
machine after some 700MB transfered. All copies come from NFS using
the motherboard eepro100 chip.

So it seems the lock comes from using both IDE and SCSI at the same
time.

Suggestions?
