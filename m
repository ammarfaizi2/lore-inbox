Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265406AbRFVN3E>; Fri, 22 Jun 2001 09:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265407AbRFVN2o>; Fri, 22 Jun 2001 09:28:44 -0400
Received: from smtp.compuserve.de ([62.52.27.101]:30254 "HELO
	demdwu43.mediaways.net") by vger.kernel.org with SMTP
	id <S265406AbRFVN2f>; Fri, 22 Jun 2001 09:28:35 -0400
Date: Thu, 21 Jun 2001 17:22:03 +0200
From: Walter Hofmann <walter.hofmann@physik.stud.uni-erlangen.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac15
Message-ID: <20010621172203.A4910@frodo.uni-erlangen.de>
In-Reply-To: <20010619232328.A19241@frodo.uni-erlangen.de> <Pine.LNX.4.33.0106201654570.1376-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0106201654570.1376-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Jun 20, 2001 at 04:56:24PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Rik van Riel wrote:

> > FWIW, here is the vmstat output for the second (short) hang. Taken with
> > ac14, vmstat 1 was started (long) before the hang and interrupted about
> > five seconds after it. The machine has 128MB RAM and 256MB swap.
> 
> >    procs                      memory    swap          io     system         cpu
> >  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> >  1  0  0  77000   1464  18444  67324   8   0   152   224  386  1345  26  19  55
> >  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   1  98   1
> 
> Does the following patch help with this problem, or are
> you both experiencing something unrelated to this particular
> buglet ?

Hi Rik,

I tried 2.4.6-pre5 with your patch (quoted at the end).
Oberservations: I still see this hang, it seemed to last longer than
with ac14/ac15 (say, 30 seconds). 
There was no heavy swapping going on, eiter before or after the hang.
During the hang there was no disc activity.

Compared with 2.4.5ac I saw that 2.4.6-pre5 uses much less swap
(according to xosview). With the load I tried (many open browser
windows) the ac series used to use 80-100MB of swap; 2.4.6-pre5 only
used 40MB swap for roughly the same number of windows open.

I forgot to press SysRq-T to get a trace, I'm afraid. kdb didn't compile
with this kernel either (although patching worked).

I had vmstat running in another window and stopped it a couple of
seconds after the hang, here are the last line of its output:

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0  36424   3232    888  45036   0   0     4     0  255  3250  56  13  32
 1  0  0  36424   3096    888  45048   0   0    12     0  140  1010  37   6  58
 4  0  0  36424   2964    888  45060   0   0    12     0  228  1304  90   6   4
 3  0  0  36424   3052    900  44668   0   0    88     0  259  2522  88  12   0
 2  0  0  36424   3164    900  44524   0   0     4     0  144  3556  87  13   0
 3  0  0  36424   2812    900  44468   0   0     8     0  211  2007  87  11   3
 5  0  0  36424   2812    912  44108   0   0    20     0  196  1243  92   8   0
 4  0  0  36424   2812    920  43836   0   0   108     0  271  2928  88  12   0
 4  0  0  36424   2808    920  42728   0   0   228     0  284  2042  85  11   5
 2  0  0  36424   3112    924  42416  76 5004   288  5260  385   948  84  11   6
 4  0  0  36424   2816    940  42016   0   0   100     0  223  1252  94   3   3
 3  0  0  36424   2812    944  41472   0   0     0     0  229  1392  92   8   0
 3  0  0  36424   2812    948  41112   0   0    68     0  264  1107  95   3   2
 1  0  0  36424   2932    948  40756   0   0     0     0  262   879  92   8   0
 2  0  0  36424   2808    952  40740   0   0     0     0  191  2244  36  12  53
 4  0  0  36424   2808    952  40504  32   0    32     0  242   975  93   6   2
 2  0  0  36424   3252    956  40008   0   0    64     0  249  2505  85  15   0
 3  0  0  36424   2972    956  39996   0   0     8     0  127  1419  88  10   2
 3  0  0  36424   2988    956  39108   0   0    20     0  247  1632  83  17   0
 2  0  0  36424   3332    964  38496   0   0   176     0  218   955  91   9   0
 3  0  0  36424   3180    964  38724 120   0   232     0  112  3026  89  11   0
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 4  0  0  36424   3020    968  38800  64   0    64     0  158  2008  87  13   1
 3  0  0  36424   2808    936  38192   0   0   192   552  232   678  90   6   4
 2  0  0  36424   2988    936  37632   0   0     0     4  167   678  98   2   0
 2  0  0  36424   2868    940  37592   0   0     4   104  177  1137  93   7   0
 3  0  0  36396   2852    940  37592   0   0     0    20  185  1125  93   7   0
 4  0  0  36396   2848    984  37624   0   0    60    64  193  1245  92   8   0
 5  0  0  36396   2244   1000  37656   0   0    28   176  161  2377  69  31   0
 1  0  0  36396   2364   1004  37660   0   0     8   244  180  1836  75  25   0
 1  0  1  36396   2484   1004  37780 100   0   104   248  178  2369  61  38   1
 4  0  1  36384   2020   1012  38328 520   0   560   148  185  1696  58  19  22
 6  0  0  45940   1744   1012  47676 108 724   368   868 6886 186930   1  99   0
 2  0  1  45856   2528   1028  46480 272 5480   752  5524  264  2413  82  18   0
 5  0  0  46072   2732   1028  45740   0 6636     8  6636  297  1165  84  16   0
 4  0  0  46072   2532   1028  45776   0   0    20     4  245  3310  88  13   0
 3  0  0  46072   2392   1040  45336   0   0    24     0  119  1296  91   9   0
 2  0  0  46072   2832   1052  44872   0   0    48     4  113  1276  91   9   0
 3  0  0  46072   2392   1056  44544   0   0     0     0  104   943  97   3   0
 2  0  0  46068   2808   1056  44112 1104   0  1164     0  144   870  70  11  19
 1  0  0  46052   2812   1060  44044 216   0   252     0  118  3325  20   6  74
 0  1  0  45964   3000   1104  43216 676   0  1576     0  198  1365   2   8  90
 1  0  0  45964   2976   1212  42948   0   0   332     0  187  1319  10   8  83
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  45964   2928   1212  42948   0   0     0     0  113  1251   6   3  92
 1  0  0  45964   2924   1212  42948   0   0     0     0  112  1217   2   6  92


Walter




> --- linux/mm/swapfile.c.~1~	Thu May  3 16:34:46 2001
> +++ linux/mm/swapfile.c	Thu May  3 16:36:07 2001
> @@ -67,8 +67,14 @@
>  	}
>  	/* No luck, so now go finegrined as usual. -Andrea */
>  	for (offset = si->lowest_bit; offset <= si->highest_bit ; offset++) {
> -		if (si->swap_map[offset])
> +		if (si->swap_map[offset]) {
> +			/* Any full pages we find we should avoid
> +			 * looking at next time. */
> +			if (offset == si->lowest_bit)
> +				si->lowest_bit++;
>  			continue;
> +		}
> +
>  	got_page:
>  		if (offset == si->lowest_bit)
>  			si->lowest_bit++;
> @@ -79,6 +85,7 @@
>  		si->cluster_next = offset+1;
>  		return offset;
>  	}
> +	si->highest_bit = 0;
>  	return 0;
>  }
> 
