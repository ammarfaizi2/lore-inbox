Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbUAYXbn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 18:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUAYXa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 18:30:28 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:39036 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S265362AbUAYXaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 18:30:06 -0500
Message-ID: <4014516D.5070409@samwel.tk>
Date: Mon, 26 Jan 2004 00:29:49 +0100
From: Bart Samwel <bart@samwel.tk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: felix-kernel@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: Request: I/O request recording
References: <20040124181026.GA22100@codeblau.de>	<20040124153551.24e74f63.akpm@osdl.org>	<40144A36.5090709@samwel.tk> <20040125150914.1583d487.akpm@osdl.org>
In-Reply-To: <20040125150914.1583d487.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Bart Samwel <bart@samwel.tk> wrote:
> 
>>When I saw this thread I've fiddled for a bit with the block_dump
>> functionality that's in the laptop_mode patch. I wanted to see if it
>> could support a similar thing completely from user space (except for the
>> block_dump code, of course). I've written a small tool to generate a
>> complete file that lists tuples (sector, size, device) from the kernel
>> output in syslog; it parses all "READ block xxx" messages since the
>> last reboot. Putting this through sort -n -u delivers a nicely sorted
>> file, ready for optimized reading.
>>
>> Unfortunately I'm now stuck within the other part, which is reading the
>> pages back in memory at the next boot. It's not working, and I was 
>> hoping someone here could take a look and tell me what I'm doing wrong.
> 
> Linux caches disk data on a per-file basis.  So if you preload pagecache
> via the /dev/hda1 "file", that is of no benefit to the /etc/passwd file. 
> Each one has its own unique pagecache.  When reading pages for /etc/passwd
> we don't go looking for the same disk blocks in the cache of /dev/hda1.
> 
> Which is why the userspace cache preloading needs to know the pathnames of
> all the relevant files - it needs to open and read each one, applying
> knowledge of disk layout while doing it.

Hmmm, that explains why this didn't work. :( So if I wanted to do this 
completely from user space using only block_dump data I'd probably have 
to go through all files and find out if they had any blocks in common 
with my preload set -- presuming there is a way to find that out, which 
there probably isn't. That  makes this idea pretty much useless, I'm 
sorry to have bothered you with it.

-- Bart
