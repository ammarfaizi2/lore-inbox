Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313812AbSDIH56>; Tue, 9 Apr 2002 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313814AbSDIH55>; Tue, 9 Apr 2002 03:57:57 -0400
Received: from violet.setuza.cz ([194.149.118.97]:6153 "EHLO violet.setuza.cz")
	by vger.kernel.org with ESMTP id <S313812AbSDIH54>;
	Tue, 9 Apr 2002 03:57:56 -0400
Subject: Re: REPORT: NFS and ReiserFS very high latencies, with low-latency
	and preempt applied
From: Frank Schaefer <frank.schafer@setuza.cz>
To: linux-kernel@vger.kernel.org
In-Reply-To: <E16teiJ-0000BM-00@antoli.gallimedina.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 09 Apr 2002 09:57:57 +0200
Message-Id: <1018339077.620.8.camel@ADMIN>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-06 at 03:09, Ricardo Galli wrote:
> On 04/04/02 16:00, Alan Cox wrote:
> > Im curious how 2.4.19pre4-ac4 responds in that situation (even without low
> > latency added). If its the same then its pointing at the I/O subsystem
> > if not then it may be a good clue its a VM issue
> 
> Done, with the same kernel config (after make oldconfig).
> 
> Almost the same, the mouse froze three times, the second time about 
> 9 seconds (checked against the wallclock), the others more or less 5.
> 
> The freezes started 15 seconds after I started the copy, and 30 seconds later 
> the system stabilised and become responsible again, i.e. no more mouse freezes.
> 
> 
> gallir@antoli:~$ vmstat -n 3
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  0  0  0      0 297364  20388  89280   0   0   182   448  811  1085   9  10  81
>  1  0  0      0 297348  20404  89280   0   0     0     8  237   592   1   0  99
>  3  0  1      0 274416  20516 112052   0   0     0    57 6527  3988   6  27  68
>  2  0  1      0 243872  20544 142552   0   0     0     0 9088  6519  11  39  50
>  3  0  0      0 215504  20772 171928   0   0     0   131 8771  6364  10  39  52
>  2  0  1      0 186184  20792 201228   0   0     0     0 8724  6213   9  44  47
>  2  0  2      0 170312  20904 216956   0   0     0  1932 5027  3461   4  23  74
>  3  0  2      0 153712  20912 234212   0   0     0  1976 5799  4169   3  27  70
>  0  1  3      0 149316  20992 238532   0   0     0  2472 2057  1390  10   9  81
>  1  1  3      0 149316  20992 238532   0   0     0  2395  947   134   0   2  98
>  1  1  2      0 149632  20992 238532   0   0     0  1263  956   131   0   2  98
>  2  0  1      0 137616  20992 250324   0   0     0  3952 4378  6786  55  29  16
>  0  1  4      0 118756  21068 269108   0   0     0  4599 6329  4717  51  38  11
>  2  0  1      0 116752  21068 271108   0   0     0  2404 1497  1279  11   6  83
>  4  0  1      0 100400  21068 287792   0   0     0  5504 5646  4838  65  34   1
>  3  0  1      0  82180  21152 305928   0   0     0  6709 6050  4852  40  38  23
>  1  0  1      0  56688  21152 331416   0   0     0  7893 7966  5743  51  46   4
>  2  0  1      0  29672  21244 358312   0   0     0  9064 8091  6011  15  39  46
>  3  0  1      0   6388  21360 381380   0   0     0  8908 8047  6327   9  41  50
>  0  0  1      0   6388  21364 381524   0   0     0  9045 8175  5633  16  41  44
>  1  1  1      0   6388  21572 381296   0   0     8  8467 7396  4827  21  34  45
>  1  0  1      0   6584  21740 380348   0   0     8  8976 7924  5136  39  45  16
>  1  0  1      0   6388  21852 380600   0   0     0  6744 6091  4715   9  32  59
>  2  0  1      0   6392  22032 380608   0   0     0  9119 8118  5584   9  37  53
>  4  0  1      0   6488  22032 380576   0   0     0  7936 7377  6188   6  40  55
>  1  0  0      0   6396  22164 380532   0   0     0  9752 8512  5092   2  43  55
>  2  0  1      0   6388  22188 380440   0   0     0 10069 8990  6080   4  44  52
>  3  0  1      0   6388  22332 380248   0   0     0  9165 8026  5708  12  44  44
>  2  0  1      0   6388  22444 378584   0   0     0  8087 7038  6582  16  39  46
>  2  0  1      0   6388  22444 378604   0   0     0  9472 8452  5168   7  41  53
>  3  0  1      0   6392  22640 378272   0   0     0  8777 7810  6431  10  40  50
>  0  0  1      0   6388  22660 378276   0   0     0  7083 6408  4646   3  32  64
>  2  0  0      0   6392  22756 378272   0   0     0  4407 4115  4094   3  23  74
>  1  0  0      0   6392  22808 378180   0   0     0    76  437  2004   6   1  93
> 
> 
> -- 
Hi,

kwave,kmail??? Isn't this KDE stuff?
IMHO you should report this to KDE.org.

Frank

