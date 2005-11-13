Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVKMLTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVKMLTu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 06:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKMLTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 06:19:50 -0500
Received: from netzweb.gamper-media.ch ([157.161.128.137]:15634 "EHLO
	ns1.netzweb.ch") by vger.kernel.org with ESMTP id S932400AbVKMLTt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 06:19:49 -0500
From: "Miro Dietiker, MD Systems" <info@md-systems.ch>
To: "'Neil Brown'" <neilb@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: AW: Locking md device and system for several seconds
Date: Sun, 13 Nov 2005 12:19:20 +0100
Organization: MD Systems
Message-ID: <018a01c5e844$18127490$4001a8c0@MDSYSPORT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <17271.6216.944507.182685@cse.unsw.edu.au>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
X-yoursite-MailScanner-Information: Please contact the ISP for more information
X-yoursite-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-)

>Can you check which IO scheduler the drives are using, try different
>schedulers, and see if it makes a different.

there was [anticipatory] selected.

ORIGINAL:
tiger:~#  grep . /sys/block/*/queue/scheduler
/sys/block/fd0/queue/scheduler:noop [anticipatory] deadline cfq
/sys/block/hdd/queue/scheduler:noop [anticipatory] deadline cfq
/sys/block/sda/queue/scheduler:noop [anticipatory] deadline cfq
/sys/block/sdb/queue/scheduler:noop [anticipatory] deadline cfq

NEW:
tiger:~#  grep . /sys/block/*/queue/scheduler
/sys/block/fd0/queue/scheduler:noop anticipatory deadline [cfq]
/sys/block/hdd/queue/scheduler:noop anticipatory deadline [cfq]
/sys/block/sda/queue/scheduler:noop anticipatory deadline [cfq]
/sys/block/sdb/queue/scheduler:noop anticipatory deadline [cfq]

System seems to work, but I need some testing time to check that
behaviour. (Any suggestion of a testing tool to generate disk
traffic and reporting response-times and throughput?)

Which is the right way / position on bootup to set this field
permanent to this value and what exactly did I change with this
modification? (Performance issues?)
I'm using debian..

I also need to check this on the other (identical) machines.

Thanks! Miro Dietiker

-----Ursprüngliche Nachricht-----
Von: Neil Brown [mailto:neilb@suse.de] 
Gesendet: Sonntag, 13. November 2005 11:41
An: Miro Dietiker, MD Systems
Cc: linux-kernel@vger.kernel.org
Betreff: Re: Locking md device and system for several seconds

On Sunday November 13, info@md-systems.ch wrote:
> Hi!
> 
> I'm using kernel 2.6.14.2 with md (RAID1 static) as bootable.
> 
> While md synching (initial creation or after marked one as failed,
> removed and re-added) there are some locking problems with the
> complete system/kernel.

Can you check which IO scheduler the drives are using, try different
schedulers, and see if it makes a different.

     grep . /sys/block/*/queue/scheduler

will show you (the one in [brackets] is active). 
Then just echo a new value out to each file.

I've had one report that [anticipatory] causes this problem and [cfq]
removes it.  Could you confirm that?

Thanks,

NeilBrown

