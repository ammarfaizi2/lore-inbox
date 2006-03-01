Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932499AbWCAGPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWCAGPs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 01:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWCAGPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 01:15:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932440AbWCAGPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 01:15:47 -0500
Date: Tue, 28 Feb 2006 22:14:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Maxim Kozover <maximkoz@netvision.net.il>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andrew Vasquez <andrew.vasquez@qlogic.com>
Subject: Re: problems with scsi_transport_fc and qla2xxx
Message-Id: <20060228221422.282332ef.akpm@osdl.org>
In-Reply-To: <978150825.20060227210552@netvision.net.il>
References: <1413265398.20060227150526@netvision.net.il>
	<978150825.20060227210552@netvision.net.il>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maxim Kozover <maximkoz@netvision.net.il> wrote:
>
> Hi!

(cc's added)

> Most of the problem seems to be a QLogic driver problem.
> HBAs are connected to target via FC switch.
> 
> 1. If I have several LUNs on each HBA, with QLogic only 1 directory
> per adapter (for LUN 0) is created in /sys/class/fc_remote_ports,
> while with Emulex a directory for every LUN is created.
> 
> 2. The situation I described occurs with QLogic only if the cable
> connecting between HBA and switch is pulled out/in. If I
> connect/disconnect the cable between switch and target, disks come
> back.
> 
> 3. With Emulex in both cases disks come back.
> 
> However, both with Emulex and QLogic stale directories in
> /sys/classfc_remote_ports are left.
> For example, with Emulex if I had in the beginning
> rport-6:0-0  rport-6:0-1  rport-6:0-2  rport-7:0-0  rport-7:0-1  rport-7:0-2
> then disconnected adapter 7, got
> rport-6:0-0  rport-6:0-1  rport-6:0-2  rport-7:0-0  rport-7:0-2
> (7-0-0 and 7-0-2 didn't disappear while 7-0-1 did)
> connected 7 back
> rport-6:0-0  rport-6:0-1  rport-6:0-2  rport-7:0-2  rport-7:0-4
> rport-7:0-5 rport-7:0-6
> (7-0-0 disappeared, but 7-0-2 is still here).
> 
> Thanks,
> 
> Maxim.
> 
> MK> Hi!
> MK> I'm checking 2.6.16-rc5 with 2 QLogic 2312 adapters using qla2xxx
> MK> driver from 2.6.16-rc5.
> MK> As with earlier kernels, I think > 2.6.12 (since scsi_transport_fc
> MK> gained functionality) I have the following problem.
> MK> 2 scsi hosts available, 4 and 5 (for QLogic).
> MK> I disconnect the cable from one of QLogic cards. After timeout I have
> MK> the message
> MK> rport-4:0-0: blocked FC remote port time out: removing target and saving binding
> MK> and appropriate SCSI devices that came from adapter 4 disappear from
> MK> /proc/scsi/scsi.
> MK> So far, so good.
> MK> I reconnect the cable, the directory
> MK> /sys/class/fc_remote_ports/rport-4:0-1 appears along with the old
> MK> ones rport-4:0-0 and rport-5:0-0, so currently I have 3.
> MK> However, no automatic rescan appears on adapter 4.
> MK> What's worse, if I try echo "0 1 0" > /sys/class/scsi_host/host4/scan
> MK> the process is stuck.
> MK> Please advise.
> 
> MK> Thanks,
> 
> MK> Maxim.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
