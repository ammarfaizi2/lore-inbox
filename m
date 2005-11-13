Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVKMMAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVKMMAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 07:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVKMMAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 07:00:09 -0500
Received: from mailhost.u-strasbg.fr ([130.79.200.152]:57807 "EHLO
	mailhost.u-strasbg.fr") by vger.kernel.org with ESMTP
	id S932473AbVKMMAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 07:00:07 -0500
Message-ID: <43772A54.3090904@crc.u-strasbg.fr>
Date: Sun, 13 Nov 2005 12:58:12 +0100
From: Philippe Pegon <Philippe.Pegon@crc.u-strasbg.fr>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051016)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Miro Dietiker, MD Systems" <info@md-systems.ch>
CC: "'Neil Brown'" <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: AW: Locking md device and system for several seconds
References: <018a01c5e844$18127490$4001a8c0@MDSYSPORT>
In-Reply-To: <018a01c5e844$18127490$4001a8c0@MDSYSPORT>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (mailhost.u-strasbg.fr [IPv6:2001:660:2402::152]); Sun, 13 Nov 2005 12:59:52 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miro Dietiker, MD Systems wrote:
> :-)
> 
> 
>>Can you check which IO scheduler the drives are using, try different
>>schedulers, and see if it makes a different.
> 
> 
> there was [anticipatory] selected.
> 
> ORIGINAL:
> tiger:~#  grep . /sys/block/*/queue/scheduler
> /sys/block/fd0/queue/scheduler:noop [anticipatory] deadline cfq
> /sys/block/hdd/queue/scheduler:noop [anticipatory] deadline cfq
> /sys/block/sda/queue/scheduler:noop [anticipatory] deadline cfq
> /sys/block/sdb/queue/scheduler:noop [anticipatory] deadline cfq
> 
> NEW:
> tiger:~#  grep . /sys/block/*/queue/scheduler
> /sys/block/fd0/queue/scheduler:noop anticipatory deadline [cfq]
> /sys/block/hdd/queue/scheduler:noop anticipatory deadline [cfq]
> /sys/block/sda/queue/scheduler:noop anticipatory deadline [cfq]
> /sys/block/sdb/queue/scheduler:noop anticipatory deadline [cfq]
> 
> System seems to work, but I need some testing time to check that
> behaviour. (Any suggestion of a testing tool to generate disk
> traffic and reporting response-times and throughput?)
> 
> Which is the right way / position on bootup to set this field
> permanent to this value and what exactly did I change with this
> modification? (Performance issues?)
> I'm using debian..

you can use the kernel argument elevator=cfq in your lilo or grub boot 
config file.

you can read this article about cfq :

http://lwn.net/Articles/143474/

for information, it seems cfq is used in the default kernel in some 
distributions.

> 
> I also need to check this on the other (identical) machines.
> 
> Thanks! Miro Dietiker

--
Philippe Pegon
