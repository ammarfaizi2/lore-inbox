Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278604AbRJ1RgI>; Sun, 28 Oct 2001 12:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278597AbRJ1Rf6>; Sun, 28 Oct 2001 12:35:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47624 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278603AbRJ1Rfr>; Sun, 28 Oct 2001 12:35:47 -0500
Date: Sun, 28 Oct 2001 09:34:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Zlatko Calusic <zlatko.calusic@iskon.hr>
cc: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <87k7xfk6zd.fsf@atlas.iskon.hr>
Message-ID: <Pine.LNX.4.33.0110280931590.7323-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28 Oct 2001, Zlatko Calusic wrote:
>
> But, now I found something interesting, other two disk which are on
> the standard IDE controller work correctly (writing is at 17-22
> MB/sec). The disk which doesn't work well is on the HPT366 interface,
> so that may be our culprit. Now I got the idea to check patches
> retrogradely to see where it started behaving poorely.

Ok. That _is_ indeed a big clue.

Does the -ac patches have any hpt366-specific stuff? Although I suspect
you're right, and that it's just the driver (or controller itself) being
very very sensitive to some random alignment of stars, rather than any
real code itself.

>  0  2  0  13208   2924    516 450716   0   0     0 11808  179   113   0   6  93
>  0  1  0  13208   2656    524 450964   0   0     0  8432  174    86   1   6  93
>  0  1  0  13208   3676    532 449924   0   0     0  8432  174    91   1   4  95
>  0  1  0  13208   3400    540 450172   0   0     0  8432  231   343   1   4  94
>  0  2  0  13208   3520    548 450036   0   0     0  8440  180   179   2   5  93
>  0  1  0  20216   3544    728 456976  32   0    32  8432  175    94   0   4  95
>  0  2  0  20212   3280    728 457232   0   0     0  8440  174    88   0   5  95
>  0  2  0  20208   3032    728 457480   0   0     0  8364  174    84   1   4  95
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  2  0  20208   3412    732 457092   0   0     0  6964  175   111   0   4  96
>  0  2  0  20208   3272    728 457224   0   0     0  1216  207    89   0   1  99
>  0  2  0  20208   3164    728 457352   0   0     0  1300  256    77   1   2  97
>  0  2  1  20208   2928    732 457604   0   0     0  1444  283    77   1   0  99
>  0  2  1  20208   2764    732 457732   0   0     0  1316  278    73   1   1  98

So it actually slows down to just 1.5MB/s at times? That's just
disgusting. I wonder what the driver is doing..

		Linus

