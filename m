Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWAHUWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWAHUWN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161122AbWAHUWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 15:22:12 -0500
Received: from outgoing.smtp.agnat.pl ([193.239.44.83]:38410 "EHLO
	outgoing.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S932767AbWAHUWL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 15:22:11 -0500
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: 2.6.14.x and weird things with interrupts on smp machines
Date: Sun, 8 Jan 2006 21:22:02 +0100
User-Agent: KMail/1.9.1
References: <200601081931.31686.arekm@pld-linux.org> <200601081949.12566.arekm@pld-linux.org>
In-Reply-To: <200601081949.12566.arekm@pld-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601082122.03555.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 08 January 2006 19:49, Arkadiusz Miskiewicz wrote:
> On Sunday 08 January 2006 19:31, Arkadiusz Miskiewicz wrote:
> > I've recently noticed that something weird is happening on my SMP
> > machines. Both machines are 2 x Xeon CPU with HT enabled.
> > /proc/interrupts shows that only CPU#0 is used which is very weird (and
> > CPU#1 on one of the machines). I'm running userspace irqbalance, too. I'm
> > unable to alter affinity settings for irqs - these are always the same as
> > below.
> >
> > Has anyone noticed such problems?
>
> Seems that not only me:
>
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=172909
>
>
> Is this related?
> http://www.nabble.com/smp_affinity-weirdness-in-LK-2.6.14-t496221.html
>
> (since one of users here reports that the problem for him seems to be fixed
> in 2.6.15). If it is then I would love to see it in stable 2.6.14.x
> release.

That patch
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=fe655d3a06488c8a188461bca493e9f23fc8c448;hp=b0b623c3b22d57d6941b200321779d56c4e79e6b
seems to fix the problem:

# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  0:       5580       4005       4004       3100    IO-APIC-edge  timer
  4:        488         93          3        231    IO-APIC-edge  serial
  8:          1          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
169:       2698          0      11062      16885   IO-APIC-level  qla2300
177:      63677          0          0          0   IO-APIC-level  eth0
185:          6          0      17417          0   IO-APIC-level  eth1
NMI:      16778      16762      16758      16760
LOC:      16515      16561      16680      16704
ERR:          0
MIS:          0

Please put in in stable 2.6.14.x since it's quite important bugfix.

-- 
Arkadiusz Mi¶kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
