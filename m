Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbVLUEVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVLUEVM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 23:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbVLUEVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 23:21:12 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:53731 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932274AbVLUEVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 23:21:11 -0500
Date: Wed, 21 Dec 2005 05:21:01 +0100
From: Voluspa <lista1@telia.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.15-rc6
Message-Id: <20051221052101.1acb6cc4.lista1@telia.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I know that C1 isn't much of a power save, but that's what my amd64
notebook provides, and it get used in 2.6.14:

loke@sleipner:~$ cat /proc/acpi/processor/CPU0/power
active state:            C1
max_cstate:              C8
bus master activity:     00000000
states:
   *C1:                  type[C1] promotion[--] demotion[--] latency[000] usage[01399981]

Not so in 2.6.15-rc2 to -rc6 (report http://marc.theaimsgroup.com/?l=linux-kernel&m=113498252000221&w=2 )
Culprit is the following commit that I humbly ask to be removed/rewritten:

root@sleipner:/home/git/linux-2.6# git bisect bad
2203d6ed448ff3b777ee6bb614a53e686b483e5b is first bad commit
diff-tree 2203d6ed448ff3b777ee6bb614a53e686b483e5b (from 2656c076e31a3ce3ab2a987a578e7122dc2af51d)
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Fri Nov 18 07:29:51 2005 -0800

    Fix ACPI processor power block initialization

    Properly clear the memory, and set "pr->flags.power" only if a C2 or
    deeper state is valid (to make the code match both the comment and
    previous behaviour).

    This fixes a boot-time lockup reported by Maneesh Soni when using
    "maxcpus=1".

    Acked-by: Maneesh Soni <maneesh@in.ibm.com>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 52be621b960ae192b36acf778c966d78ff5edbe2 04c183ce141dab8cdff049c1dae379104b637ed4 M      drivers

Mvh
Mats Johannesson
--
