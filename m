Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751721AbWB0TF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbWB0TF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbWB0TF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:05:59 -0500
Received: from mxout5.netvision.net.il ([194.90.9.29]:65134 "EHLO
	mxout5.netvision.net.il") by vger.kernel.org with ESMTP
	id S1751719AbWB0TF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:05:58 -0500
Date: Mon, 27 Feb 2006 21:05:52 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re: problems with scsi_transport_fc and qla2xxx
In-reply-to: <1413265398.20060227150526@netvision.net.il>
To: linux-kernel@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <978150825.20060227210552@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <1413265398.20060227150526@netvision.net.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Most of the problem seems to be a QLogic driver problem.
HBAs are connected to target via FC switch.

1. If I have several LUNs on each HBA, with QLogic only 1 directory
per adapter (for LUN 0) is created in /sys/class/fc_remote_ports,
while with Emulex a directory for every LUN is created.

2. The situation I described occurs with QLogic only if the cable
connecting between HBA and switch is pulled out/in. If I
connect/disconnect the cable between switch and target, disks come
back.

3. With Emulex in both cases disks come back.

However, both with Emulex and QLogic stale directories in
/sys/classfc_remote_ports are left.
For example, with Emulex if I had in the beginning
rport-6:0-0  rport-6:0-1  rport-6:0-2  rport-7:0-0  rport-7:0-1  rport-7:0-2
then disconnected adapter 7, got
rport-6:0-0  rport-6:0-1  rport-6:0-2  rport-7:0-0  rport-7:0-2
(7-0-0 and 7-0-2 didn't disappear while 7-0-1 did)
connected 7 back
rport-6:0-0  rport-6:0-1  rport-6:0-2  rport-7:0-2  rport-7:0-4
rport-7:0-5 rport-7:0-6
(7-0-0 disappeared, but 7-0-2 is still here).

Thanks,

Maxim.

MK> Hi!
MK> I'm checking 2.6.16-rc5 with 2 QLogic 2312 adapters using qla2xxx
MK> driver from 2.6.16-rc5.
MK> As with earlier kernels, I think > 2.6.12 (since scsi_transport_fc
MK> gained functionality) I have the following problem.
MK> 2 scsi hosts available, 4 and 5 (for QLogic).
MK> I disconnect the cable from one of QLogic cards. After timeout I have
MK> the message
MK> rport-4:0-0: blocked FC remote port time out: removing target and saving binding
MK> and appropriate SCSI devices that came from adapter 4 disappear from
MK> /proc/scsi/scsi.
MK> So far, so good.
MK> I reconnect the cable, the directory
MK> /sys/class/fc_remote_ports/rport-4:0-1 appears along with the old
MK> ones rport-4:0-0 and rport-5:0-0, so currently I have 3.
MK> However, no automatic rescan appears on adapter 4.
MK> What's worse, if I try echo "0 1 0" > /sys/class/scsi_host/host4/scan
MK> the process is stuck.
MK> Please advise.

MK> Thanks,

MK> Maxim.


