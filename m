Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130519AbQKGALb>; Mon, 6 Nov 2000 19:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130419AbQKGALV>; Mon, 6 Nov 2000 19:11:21 -0500
Received: from 181-ZARA-X27.libre.retevision.es ([62.82.240.181]:32273 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S129802AbQKGALM>;
	Mon, 6 Nov 2000 19:11:12 -0500
Message-ID: <3A070FD4.7F650A87@zaralinux.com>
Date: Mon, 06 Nov 2000 21:08:52 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Paul Gortmaker <p_gortmaker@yahoo.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux SMP Mailing List <linux-smp@vger.kernel.org>
Subject: Re: ping -f kills ne2k (was:[patch] NE2000)
In-Reply-To: <E13pz9c-0006Jh-00@the-village.bc.nu> <39FD5433.587FF7C6@zaralinux.com> <39FFE612.2688A5AD@yahoo.com> <3A02F9AA.AFB2DB1B@zaralinux.com> <3A065867.6902473D@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Gortmaker wrote:
> 
> >
> > Well, I have tried it with 2.4.0-test10, both SMP and non-SMP, and the
> > result is a little confusing.
> >
> > Under SMP a ping -s 50000 -f other_host takes down the network access
> > with no messages (ne2k-pci), and no possibility of being restored
> > without a reboot.
> >
> > Under UP the same command works ok, but after a while the dots stop for
> > 30sec, then ping prints an 'E' and the dots continue. strace revealed
> > this:
> 
> Another suggestion - if you have your heart set on using ping
> as your network stress tool, you may want to try using multiple
> instances of MTU sized pings versus  a single "ping -s 50000".
> In this way you aren't involving any IP frag code and its associated
> bean counting - giving us one less factor to consider.
> 
> Oh, and since you get a silent failure, maybe you would be interested
> in testing this patch I was (originally) saving for 2.5.x. -- It adds
> watchdog transmit timeout functionality to 8390.c (which is used by
> the ne2k-pci driver).  Last time I updated it was a couple of months
> ago, but nothing has changed since then.
> 
> Paul.
> 

Tested with ping -f -s 1400 (1400 in order not to reach 1500)
It took about half an hour and more than one million packets, but I
finally took the net down, with 12 concurrent pings.

To eliminate factors I have deleted all the NAT rules wich gave messages
about dropped packets, and unloaded all the iptables modules.

I have to make the test without the test check in sock_wait_for_wmem:
        if ((current->state & (TASK_INTERRUPTIBLE|TASK_UNINTERRUPTIBLE))
== 0)
                BUG();

Because as I said in a previous msg it gave me BUG()s very early in the
tests, and I still had network access.

If someone has a better sugestion as a nic stress tool I can try it, but
now I only have two ways of reaching this limits, ping -f of big
packets, and sometimes (only 4 or 5) during a copy of a large file over
NFS, but it's not a easy way to cause this.

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
