Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUAML6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 06:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUAML6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 06:58:22 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:50727 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S264386AbUAML6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 06:58:21 -0500
Message-ID: <4003DD4D.1000305@samwel.tk>
Date: Tue, 13 Jan 2004 12:58:05 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Krueger <kai.a.krueger@web.de>, axboe@suse.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
References: <200401130110.i0D1ALQ08941@mailgate5.cinetic.de>
In-Reply-To: <200401130110.i0D1ALQ08941@mailgate5.cinetic.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Krueger wrote:
> I can not see any log entries for "kdeinit: [some pid]: dirtied page". There are only the "kdeinit: () WRITE block 65680 on hda1". By the way, it is always block 65680; also across reboots if that is any indication and I have seen other processes like artsd write to that block without dirtying pages before as well.
> Is there a way to find out what kdeinit writes to disk?

Ehm... I don't know how to go from a block to a filename on reiserfs. 
Jens, do you have an idea?

Anyway, the other possibility is to use other file activity monitoring 
tools. Some fam client maybe (couldn't find any so quickly); maybe 
Filemon (http://www.sysinternals.com/linux/utilities/filemon.shtml) will 
work, but I don't know if it works for Linux 2.6. You may also try "lsof 
| grep kded", and see if it's one of those files. For me, it gives:

# lsof |grep kded
kdeinit    1185 bsamwel  mem    REG       3,65  117196    5146489 
/usr/lib/kded.so
kdeinit    1185 bsamwel  mem    REG       3,65  111412    9470211 
/usr/lib/kde3/kded_mountwatcher.so
kdeinit    1185 bsamwel  mem    REG       3,65   62408    9470683 
/usr/lib/kde3/kded_kinetd.so

Alternatively, you can try to attach an strace for kdeinit: kded, and 
see what calls it makes, e.g. "strace -p <pid>" or something like that.

-- Bart
