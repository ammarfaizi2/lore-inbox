Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129963AbQKJRIb>; Fri, 10 Nov 2000 12:08:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130491AbQKJRIW>; Fri, 10 Nov 2000 12:08:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:24071 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129963AbQKJRIQ>; Fri, 10 Nov 2000 12:08:16 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [BUG] /proc/<pid>/stat access stalls badly for swapping process,
 2.4.0-test10
Date: 10 Nov 2000 09:07:48 -0800
Organization: Transmeta Corporation
Message-ID: <8uha14$3gi$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.10.10011091005390.1909-100000@penguin.transmeta.com> <Pine.Linu.4.10.10011100732250.601-100000@mikeg.weiden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.Linu.4.10.10011100732250.601-100000@mikeg.weiden.de>,
Mike Galbraith  <mikeg@wen-online.de> wrote:
>> 
>> (This schenario, btw, is much harder to trigger on SMP than on UP. And
>> it's completely separate from the issue of simple disk bandwidth issues
>> which can obviously cause no end of stalls on anything that needs the
>> disk, and which can also happen on SMP).
>
>Unfortunately, it didn't help in the scenario I'm running.
>
>time make -j30 bzImage:
>
>real    14m19.987s  (within stock variance)
>user    6m24.480s
>sys     1m12.970s

Note that the above kin of "throughput performance" should not have been
affected, and was not what I was worried about. 

>procs                      memory    swap          io     system         cpu
> r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>31  2  1     12   1432   4440  12660   0  12    27   151  202   848  89  11   0
>34  4  1   1908   2584    536   5376 248 1904   602   763  785  4094  63  32  5
>13 19  1  64140  67728    604  33784 106500 84612 43625 21683 19080 52168  28  22  50

Looks like there was a big delay in vmstat there - that could easily be
due to simple disk throughput issues..

Does it feel any different under the original load that got the original
complaint? The patch may have just been buggy and ineffective, for all I
know. 

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
