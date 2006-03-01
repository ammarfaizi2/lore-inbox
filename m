Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751916AbWCAVP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916AbWCAVP7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 16:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWCAVP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 16:15:59 -0500
Received: from mxout5.netvision.net.il ([194.90.9.29]:63219 "EHLO
	mxout5.netvision.net.il") by vger.kernel.org with ESMTP
	id S1751251AbWCAVP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 16:15:58 -0500
Date: Wed, 01 Mar 2006 23:16:02 +0300
From: Maxim Kozover <maximkoz@netvision.net.il>
Subject: Re[4]: Fwd: Re: problems with scsi_transport_fc and qla2xxx
In-reply-to: <20060301192008.GF4321@spe2>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-to: Maxim Kozover <maximkoz@netvision.net.il>
Message-id: <1986427368.20060301231602@netvision.net.il>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Priority: 3 (Normal)
References: <735056370.20060228195436@netvision.net.il>
 <1984428707.20060228200029@netvision.net.il>
 <20060228181900.GC4541@andrew-vasquezs-powerbook-g4-15.local>
 <1261469398.20060301130903@netvision.net.il> <20060301192008.GF4321@spe2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!
You're right. I didn't look at roles in Emulex case.
When using Emulex everything is OK.
Tomorrow I'll connect QLogic again to continue problem investigation.
Thanks much for quick and professional replies.

I'll just describe Emulex situation to confirm.
Let's connect only 1 Emulex port (adapter 7) to a switch and leave
adapter 6 not connected. Then we have
# ls /sys/class/fc_remote_ports/
rport-7:0-0  rport-7:0-1  rport-7:0-2
# cat /sys/class/fc_remote_ports/*/roles
Fabric Port
Directory Server
FCP Target, FCP Initiator

When the cable is disconnected from adapter 7, immediately with
LinkDown event, the rport with the role of Directory server disappears
and only 2 are left:
# ls /sys/class/fc_remote_ports/
rport-7:0-0  rport-7:0-2
# cat /sys/class/fc_remote_ports/*/roles
Fabric Port
FCP Target, FCP Initiator

Then after a timeout, the role of rport-7:0-2 is changed to unknown
and relevant entries are removed from /proc/scsi/scsi. rport-7:0-0 is
still here.

rport-7:0-2: blocked FC remote port time out: removing target and saving binding
# ls /sys/class/fc_remote_ports/
rport-7:0-0  rport-7:0-2
# cat /sys/class/fc_remote_ports/*/roles
Fabric Port
unknown

After reconnecting the cable, rport-7:0:0 disappears and rport-7:0:4
and rport-7:0-5 appear along with newly recognized LUNs in /proc/scsi/scsi.
# ls /sys/class/fc_remote_ports/
rport-7:0-2  rport-7:0-4  rport-7:0-5
# cat /sys/class/fc_remote_ports/*/roles
FCP Target, FCP Initiator
Fabric Port
Directory Server

If I'm not mistaken, in QLogic case only 1 rport per adapter appeared
instead of 3. Tomorrow I'll connect QLogic and report again.

Thanks,

Maxim.

