Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422737AbWJLQx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWJLQx2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWJLQx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:53:28 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:21403 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1422737AbWJLQx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:53:27 -0400
From: David Johnson <dj@david-web.co.uk>
Reply-To: Linux Kernel <linux-kernel@vger.kernel.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Hardware bug or kernel bug?
Date: Thu, 12 Oct 2006 17:53:22 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610121753.23220.dj@david-web.co.uk>
X-Originating-Pythagoras-IP: [82.69.29.67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having a major problem on a system that I've been unable to track down. 
When using scp to transfer a large file (a few gig) over the network 
(@100Mbit/s) the system will reboot after about 5-10 minutes of transfer. No 
errors, just a reboot. I have another identical system which exhibits the 
same behaviour.

The system is a Supermicro P4SCT+ with a hyperthreading P4. I've posted the 
dmesg here:
http://www.david-web.co.uk/download/dmesg

I initially tried a different NIC in case that was at fault, but the results 
were the same.

Changing the interrupt timer frequency in the kernel makes a difference:
100Hz - system reboots instantly when transfer is started
250Hz - reboots after a few seconds
1000Hz - reboots after 5-10 minutes

As the problem appears to be interrupt-related, I disabled the I/O APIC in the 
BIOS (after first having to disable hyperthreading) which resulted in the 
system lasting a bit longer before it reboots. I then tried disabling the 
Local APIC as well but this made no difference.

I've tested with Centos' 2.6.9 kernel and with a vanilla 2.6.17.13 kernel and 
the results are the same with both.

Does anyone have any idea whether this is likely to be a hardware problem or a 
kernel problem?
Any suggestions for more ways to debug this would be greatfully received.

Thanks,
David.
