Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269342AbRGaQFv>; Tue, 31 Jul 2001 12:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269331AbRGaQFl>; Tue, 31 Jul 2001 12:05:41 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:27396 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S269338AbRGaQF1>; Tue, 31 Jul 2001 12:05:27 -0400
To: linux-kernel@vger.kernel.org
Subject: [2.2.13] memory leak in NFS if a sever goes away?
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 31 Jul 2001 18:05:21 +0200
Message-ID: <tgsnfdkrsu.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

We've received a hard disk for post-mortem analysis because of a
strange hole of several months in the system logs, and it seems the
system's syslogd was killed by the VM subsystem during an OOM
situation.

The problems seem to begin at the following syslog event:

   kernel: nfs: server sun not responding, still trying

Periodically (every quarter of an hour), the following messages appear:

   kernel: nfs: task 111 can't get a request slot

(The task number is monotonically increasing.)

This goes on for about two days, after which the VM subsystem starts
killing processes (kdm first, then several times the X server, and
finally syslogd itself).

Are there some known issues with 2.2.13, for example, a memory leak in
the NFS code which is triggered in this specific situation?

(The kernel seems to have some SuSE-specific patches, for example, the
X server is sent the TERM signal, not the KILL signal on OOM.  Perhaps
I should ask the SuSE folks if there were any NFS peculiarities in
their 2.2.13 version. :-/)

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
