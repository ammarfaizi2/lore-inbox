Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266498AbUALVul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUALVul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:50:41 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:4941 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266498AbUALVuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:50:39 -0500
Message-ID: <400316A9.30002@samwel.tk>
Date: Mon, 12 Jan 2004 22:50:33 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>,
       Kai Krueger <kai.a.krueger@web.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <200401121707.i0CH7iQ11796@mailgate5.cinetic.de>	 <4002F627.8000508@samwel.tk> <1073940669.30991.7.camel@LNX.iNES.RO>
In-Reply-To: <1073940669.30991.7.camel@LNX.iNES.RO>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dumitru Ciobarcianu wrote:
>>>I'm currently trying kernel 2.6.1-mm1 with laptop-mode on a reiserfs partition.
>>>If I kill all daemons running on the system and do nothing with it, I can achieve the 10 minutes spin down time I had expected from laptop-mode. However as soon as I start up X with KDE I get regular spin ups every 30 seconds. Looking at the output of "echo 1 > /proc/sys/vm/block_dump", I see an entry every 30 seconds of "kdeinit(15145): WRITE block 65680 on hda1" followed by a whole load of "reiserfs/0(12): dirtied page" and "reisers/0(12): WRITE block XXXXX on hda1".
>>>
>>>Due to the regular 30 second interval writes of kdeinit: kded to block 65680, laptop-mode is not particularly usable on this system.
>>>Is this a problem with reiserfs or with kde and is there any fix available?
>>
>>Can you take a look at the message that Dumitru Ciobarcianu just sent to 
>>the list (about syslog), and check if it's that?
> 
> Won't help him if kdeinit is doing fsync() on every friggind write.
> syslog has an option to disable that, that's all.

I would be surprised if "kdeinit: kded" would do that. In fact, I run 
KDE, and it doesn't spin up the disk because of that, even though I have 
about 15 kdeinit instances running, including one for kded. Of course, I 
might be mistaken.

Kai, can you check the following: is the WRITE of kdeinit preceded by 
one or more "kdeinit: kded([some pid]): dirtied page" lines? And if they 
are, are they coming directly before the WRITE, or 5 seconds before it, 
or 30 seconds before it? This distance might give a clue about the 
cause. If it's directly before it (within a second), it's likely that 
kded calls fsync. If it's about 5 or 30 seconds before it, it might have 
to do with some kind of writeback or expiry interval.

-- Bart
