Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267453AbUHRSbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267453AbUHRSbp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267457AbUHRSah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:30:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:56228 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267453AbUHRS3u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:29:50 -0400
Subject: Re: voluntary-preempt-2.6.8.1-P1 seems to lose UDP messages.
From: Lee Revell <rlrevell@joe-job.com>
To: pierre-olivier.gaillard@fr.thalesgroup.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41233923.80202@fr.thalesgroup.com>
References: <41233923.80202@fr.thalesgroup.com>
Content-Type: text/plain
Message-Id: <1092853574.8432.29.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 18 Aug 2004 14:31:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-18 at 07:10, P.O. Gaillard wrote:
> Hello,
> 
> I have a real-time application that transmits 20 MBytes/s over UDP/Gigabit 
> Ethernet between 2 PCs. 

> But when I use the voluntary-preemt-2.6.8.1-P1 patch on the receiving PC, the 
> app starts complaining about lost messages.

It sounds like you need to set the network card irq to be non-threaded. 
What is the output of:

root@mindpipe:/home/rlrevell/kernel-source/linux-2.6.8.1-P3# find
/proc/irq/ -name threaded -print -a -exec cat {} \;
/proc/irq/15/ide1/threaded
1
/proc/irq/14/ide0/threaded
1
/proc/irq/12/uhci_hcd/threaded
1
/proc/irq/11/eth0/threaded
1
/proc/irq/11/uhci_hcd/threaded
1
/proc/irq/10/EMU10K1/threaded
0
/proc/irq/10/uhci_hcd/threaded
1
/proc/irq/8/rtc/threaded
0
/proc/irq/1/i8042/threaded
1

You probably want all of these to be 1 except ethX.

Lee 

