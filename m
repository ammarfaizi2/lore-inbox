Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287625AbSALW4k>; Sat, 12 Jan 2002 17:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287629AbSALW4a>; Sat, 12 Jan 2002 17:56:30 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:50024 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S287625AbSALW41>; Sat, 12 Jan 2002 17:56:27 -0500
Message-ID: <3C40BEBF.6EE60D2@kolumbus.fi>
Date: Sun, 13 Jan 2002 00:54:55 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: linux-kernel@vger.kernel.org, linux-audio-dev@music.columbia.edu
Subject: Re: [PATCH] Additions to full lowlatency patch
In-Reply-To: <3C40AF23.18C811A8@kolumbus.fi> <3C40B6F3.1531F931@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> As Arjan points out, the eepro100 change will cause deadlocks on SMP,
> and general badness on uniprocessor.  But I've done a heap of testing
> on a eepro100 machine and it hasn't been a problem.  I expect that
> wait_for_cmd_done() is only a problem during device startup and shutdown.
> And possibly in error recovery.

Yes, I was unsure about the eepro100 driver, but didn't revert the patch
because it worked in my UP tests.

I usually test the network drivers in 100 Mbps switched network and with 10
Mbps overloaded hub with huge amounts of collisions. The 3c90x driver has
been badly behaving in very congested networks. It looks like it can spend
worst case 1 second in timeout loop.

I have soft realtime application which needs to have simultaneous
soundcard/disk/network/GUI access and that's the motivation for the patch.

> I take the position that device driver startup and shutdown functions
> are a complete basket case, and they are on the "don't do that" list.
> Generally, this is OK.  Latency-critical applications should be
> careful to ensure that all required kernel modules are loaded beforehand,

I completely agree, the startup code is usually too timing critical. That's
why I left the initialization parts out of scope.


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

