Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268862AbRHBJi4>; Thu, 2 Aug 2001 05:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268864AbRHBJiq>; Thu, 2 Aug 2001 05:38:46 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:55048 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S268862AbRHBJik>; Thu, 2 Aug 2001 05:38:40 -0400
Message-ID: <3B691F87.2182A1BA@loewe-komp.de>
Date: Thu, 02 Aug 2001 11:38:15 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Kompetenzzentrum Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.4-64GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: BERECZ Szabolcs <szabi@inf.elte.hu>
Subject: Re: kswapd eats the cpu without swap
In-Reply-To: <Pine.A41.4.31.0108020049360.61934-100000@pandora.inf.elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BERECZ Szabolcs wrote:
> 
> some notes again.
> when kswapd was working, there was no hdd activity at all.
> every interrup was handled after kswapd finished the 'work'.
> after a reboot everything looks ok with the same modules, and
> approximately the same load.
> 
> oh, I almost forgot, the swapfile is on a reiserfs partition.
> 
In a former message you wrote:
"I have 160M of ram, and I don't use swap at all,"

Then you meant: no single page was swapped out?

I thought you was observing the same as me:

when the system runs low on memory (on a 64MB setop box like device
with _no_ swap partition/file), the harddisk gets very active and
the system does not respond for 1-5 seconds.
The VM (in mm/oom_kill.c) is killing the "memory hog" (simple program 
that calls malloc() in a loop and touching the mem). I think the
amount of "busyness" depends on the size of malloc chunks. If they
are bigger the process gets killed faster.

Until now, I don't understand what is happening. Several subsystems
in the kernel compete for memory: dentry cache, buffer cache, VM
that wants at least /proc/sys/vm/freepages free.
Is demand loading involved? Does the VM quashes text pages when
running low on memory? What about relocation then?

Or simpler: what keeps the harddisk so busy?
It is on 2.4.2 with a single ext2 "/" mounted with noatime,sync
but the question is meant more general.

Anybody?
