Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVFEQpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVFEQpb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 12:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVFEQpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 12:45:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41130 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261587AbVFEQpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 12:45:25 -0400
Date: Sun, 5 Jun 2005 12:45:18 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Gaspar Bakos <gbakos@cfa.harvard.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd causing giant load
In-Reply-To: <Pine.SOL.4.58.0506041232030.14011@titan.cfa.harvard.edu>
Message-ID: <Pine.LNX.4.61.0506051243500.9689@chimarrao.boston.redhat.com>
References: <Pine.SOL.4.58.0506041232030.14011@titan.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jun 2005, Gaspar Bakos wrote:

> 10715 hatuser   15   0 35432 2792 2020 R 28.3  0.1   1:45.06 sshd
> 10724 hatuser   16   0 17504  11m  664 R  8.3  0.3   0:33.56 rsync
>   175 root      15   0     0    0    0 S 19.7  0.0 136:25.58 kswapd0
>   172 root      15   0     0    0    0 S  0.3  0.0   1:23.59 pdflush
>   174 root      15   0     0    0    0 S  0.3  0.0  99:18.93 kswapd1
> 
> Before I start extensive experimenting, maybe someone knows right away
> what causes high loads due to "kswapd* and pdflush".

Looks like your system is NUMA, meaning that the system
memory is divided in half, and the threshold at which a
memory dirtying process is throttled might be higher than
the amount of memory available in the zone.

Can you reproduce this problem if you boot with "numa=off"
or if you "echo 20 > /proc/sys/vm/dirty_ratio" ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
