Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUBWPCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 10:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUBWPCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 10:02:12 -0500
Received: from [195.190.190.7] ([195.190.190.7]:44186 "EHLO mail.pixelized.ch")
	by vger.kernel.org with ESMTP id S261924AbUBWPCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 10:02:08 -0500
Message-ID: <403A15E5.6010705@debian.org>
Date: Mon, 23 Feb 2004 16:01:57 +0100
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: tigran@veritas.com
CC: Ryan Underwood <nemesis@icequake.net>,
       "Giacomo A. Catenazzi" <cate@debian.org>, 224355@bugs.debian.org,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: microcode, devfs: Wrong interface change in 2.4.25
References: <E1Auyi3-0000Up-00@dbz> <4039BE3E.5070302@debian.org> <20040223142838.GA26601@dbz.icequake.net>
In-Reply-To: <20040223142838.GA26601@dbz.icequake.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

 From the 2.4.25, devfs doesn't create anymore the microcode
device in /dev/cpu/microcode (as expected from in devices.txt
and LANANA) but in /dev/misc/microcode. The /dev/cpu/microcode
path is also hardcoded also in microcode_ctl and distributions
create only /dev/cpu/microcode.

So last microcode patch (in 2.4.25) is wrong.
You should add again the /dev/cpu/microcode support in devfs, so
that the normal and stable interface is maintained (in stable
kernel serie)

ciao
	giacomo



Ryan Underwood wrote:

> On Mon, Feb 23, 2004 at 09:47:58AM +0100, Giacomo A. Catenazzi wrote:
> 
>>>What I meant is that the name "/dev/misc/microcode" must be used instead
>>>of "/dev/cpu/microcode", because the microcode driver in 2.4.25 no
>>>longer registers with devfs.
>>
>>I don't undestand.
>>Do you say that devfs will register only /dev/misc/microcode ?
> 
> 
> No, the microcode driver only registers with misc.
> 
> 
>>So if devfs will register misc/microcode, it is probably
>>a kernel bug (interface should not change!) or a problem
>>with LANANA (in this case I should change misc microcode
>> in drivers, but after an update to 'makedev' package.
> 
> 
> Examine microcode.c driver diff between 2.4.23 and 2.4.25 in the init
> function.  The removed code is obvious.
> 
