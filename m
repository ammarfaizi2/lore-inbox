Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262101AbUK0FrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbUK0FrY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUK0Dus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 22:50:48 -0500
Received: from zeus.kernel.org ([204.152.189.113]:5572 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262535AbUKZTdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:33:43 -0500
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 -> ch..ch...changes....
References: <Pine.LNX.4.44.0411241744210.5172-100000@localhost.localdomain>
	<200411241957.14527.nick@linicks.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: because Hell was full.
Date: Fri, 26 Nov 2004 11:53:58 +0000
In-Reply-To: <200411241957.14527.nick@linicks.net> (Nick Warne's message of
 "24 Nov 2004 23:27:43 -0000")
Message-ID: <877jo8u8q1.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Nov 2004, Nick Warne mused:
> Normally memory slowly fills up, perhaps using swap for a bit under these 
> circumstances - but looking afterwards:

This is a feature, not a bug. Free memory is wasted memory (although
some has to be kept free for drivers that need GFP_ATOMIC allocations:
i.e. `memory *now* dammit *now*'.

> root@linuxamd:~# free
>              total       used       free     shared    buffers     cached
> Mem:       1292348     520012     772336          0      38596     327304
> -/+ buffers/cache:     154112    1138236
> Swap:      1959888          0    1959888

The only thing I can think of that causes this is something very
memory-hungry that's just been killed, releasing a pile of pages back to
the system.

> But whatever, I am impressed indeed - somethings changed for the good!!!

I see no signs of such a change on my 2.4.28 boxes:

(UltraSPARC II)
             total       used       free     shared    buffers     cached
Mem:        509360     498432      10928          0     133568      52656
-/+ buffers/cache:     312208     197152
Swap:      1557264     143992    1413272

(Athlon IV)
             total       used       free     shared    buffers     cached
Mem:        775072     762744      12328          0      88304     322740
-/+ buffers/cache:     351700     423372
Swap:      1048560      81020     967540

(i586)
             total       used       free     shared    buffers     cached
Mem:        126992     123640       3352          0      11792      42012
-/+ buffers/cache:      69836      57156
Swap:      1245168     155560    1089608

The only suspiciously high free figure is on a 2.4.28 UML instance
(2.4.28 + forward-ported 2.4.27-1 patches) on one of those machines:

             total       used       free     shared    buffers     cached
Mem:         94000      66512      27488          0       2940      31260
-/+ buffers/cache:      32312      61688
Swap:            0          0          0

and that is trivially obviously caused by the instance's lack of swap :)

-- 
`The sword we forged has turned upon us
 Only now, at the end of all things do we see
 The lamp-bearer dies; only the lamp burns on.'
