Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTKART4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 12:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTKART4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 12:19:56 -0500
Received: from h234n2fls24o1061.bredband.comhem.se ([217.208.132.234]:60647
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S263179AbTKARTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 12:19:54 -0500
Date: Sat, 1 Nov 2003 18:22:16 +0100
From: Voluspa <lista2@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: READAHEAD
Message-Id: <20031101182216.3e642eda.lista2@comhem.se>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-11-01 9:15:28 Age Huisman wrote:
>Andrew Morton wrote:
>> Andrew Morton <akpm@osdl.org> wrote:
>>
>>>Please, just use time, cat, dd, etc.
>>>
>>> mount /dev/xxx /mnt/yyy
>>> dd if=/dev/zero of=/mnt/yyy/x bs=1M count=1024
>>> umount /dev/xxx
>>> mount /dev/xxx /mnt/yyy
>>> time cat /mnt/yyy/x > /dev/null
[...]
>Here are the new test results.
[...]
>I think you were right  :-)

I see an improvement with 512 instead of the default 256, but no further
speedups with 1024 or 2048 - no point in trying 4096:

readahead = 256 (on)
real    0m39.494s
user    0m0.346s
sys     0m5.436s
Timing buffered disk reads:  64 MB in  2.80 seconds = 22.84 MB/sec

readahead = 512 (on)
real    0m34.418s
user    0m0.302s
sys     0m5.304s
Timing buffered disk reads:  64 MB in  2.16 seconds = 29.63 MB/sec

And for the nostalgic people out there, here's what "hdparm /dev/hdX"
has in its readahead slot under 2.5.X:

2.5.5-pre1
readahead = 8 (on)

2.5.5-pre1-final (AKA 2.5.5) to 2.5.8-pre2
BLKRAGET failed: Input/output error

2.5.8-pre3 to 2.5.9 don't compile.

2.5.10
readahead = 0 (off)

2.5.11 failed to boot and damaged the filesystem.

2.5.12 and onwards
readahead = 256 (on)

Mvh
Mats Johannesson
