Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbUK3SCC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbUK3SCC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUK3SAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:00:21 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18838 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262236AbUK3R4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 12:56:50 -0500
Date: Tue, 30 Nov 2004 18:56:46 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
In-Reply-To: <1101836984l.13015l.0l@werewolf.able.es>
Message-ID: <Pine.LNX.4.53.0411301854001.29170@yvahk01.tjqt.qr>
References: <1101763996l.13519l.0l@werewolf.able.es>
 <Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr> <1101765555l.13519l.1l@werewolf.able.es>
 <20041130071638.GC10450@suse.de> <1101834765l.8903l.4l@werewolf.able.es>
 <Pine.LNX.4.53.0411301835511.11795@yvahk01.tjqt.qr> <1101836984l.13015l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Err, as it tries to open a device and it does not exist.
>I tries sequentially
>hda, hdb, hdc.. up to 256 until it finds something to open.
>If it exists, but has not permissions, it keeps trying on the next.
>But if it is not present, cdrecord gives up.

Reasonable procedure. Albeit, leaky:
Imagine you use devfs... open()ing something like hd* would probably always
create a node. Although there is a max on possible, meaningful, nodes,
someone could use this to fill up /dev with
ridiculuous amounts of nodes, all of which are to my knowledge in kernel space.
"Well then, goodbye".

Luckily, even the very default config does not create arbitrarily nodes, and
cdrecord doesnot probe arbitr. devices.

So I guess, yes, cdrecord should probe harder. Preferably by looking into /sys
when using a 2.6 system.



Jan Engelhardt
-- 
ENOSPC
