Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271108AbRIYVwh>; Tue, 25 Sep 2001 17:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271278AbRIYVwR>; Tue, 25 Sep 2001 17:52:17 -0400
Received: from mtiwmhc25.worldnet.att.net ([204.127.131.50]:1257 "EHLO
	mtiwmhc25.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S271108AbRIYVwP>; Tue, 25 Sep 2001 17:52:15 -0400
Date: Tue, 25 Sep 2001 17:52:32 -0400
From: khromy <khromy@lnuxlab.ath.cx>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bad, bad, bad VM behaviour in 2.4.10
Message-ID: <20010925175232.A2612@lnuxlab.ath.cx>
In-Reply-To: <3BB0F483.69929A79@ditec.um.es> <Pine.LNX.4.21.0109251702240.2193-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0109251702240.2193-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Sep 25, 2001 at 05:03:35PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2001 at 05:03:35PM -0300, Marcelo Tosatti wrote:
> 
> Juan, 
> 
> It is a known problem which we are looking into.
> 
> I need some information which may help confirm a guess of mine:
> 
> Do you have swap available ?
> 
> If so, there was available anonymous memory to be swapped out ?
> 

I too had this but it only happend when I did a '/bin/ls' in /usr/doc/grub.. It
would start taking up all my memory and swap until it would kill 'ls'.. I could
reproduce it more than once until it killed X.  After that it hasn't
happend again.

I have 187MB of ram and 191MB of swap.

I got the following output by running vmstat 1 and then doing the /bin/ls in
/usr/doc/grub.

vmstat 1
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  0  0  34924 158256    452  13352   5  43    20    46  813   436   2   4  93
 0  0  0  34924 158212    452  13368   0   0    12     0  830   329   1   5  94
 0  0  0  34924 158212    452  13368   0   0     0     0  903   422   0   6  94
 0  0  0  34924 158212    452  13368   0   0     0     0  870   512   6   5  89
 0  0  0  34920 158208    452  13368   4   0     4     0  842   389   2   2  96
 1  0  0  34920 138928    456  13368  24   0    25     0  813   353  18  13  70
 1  0  0  34920  61936    456  13368   0   0     0     0  960   437  40  60   0
 1  0  1  36008   1728    284   5520   0 444    56   458  907   459  49  47   4
 2  0  1  42036   1912    260   5156  68 5692   219  5717 1159   436   4   8  89
 2  0  1  48604   2668    268   5144 452 6144   574  6149  992   440   5  10  85
 0  2  1  55200   2872    268   5200 376 7008   576  7012  984   510   7  15  78
 4  0  1  60244   1664    264   5356 236 4768   480  4768 1096   544   4  13  83
 0  2  1  65724   2496    272   5260 260 5984   337  5993 1037   488   8  12  80
 0  1  0  74408   3580    260   5224  16 8188    62  8200  987   485   7  15  78
 1  0  1  81052   2036    260   5224  16 7172    67  7173 1003   441   6  15  79
 1  0  1  90780   2900    260   5224   0 9376    54  9389 1095   441   6  12  82
 0  1  1 100508   3064    256   5224   0 9312    41  9309  997   451   4  17  79
 1  0  1 109212   2112    260   5232   0 8700    52  8713 1011   436  12  11  77
 1  0  1 117404   1732    260   5224   0 8708    38  8708 1006   437   3  23  75
 1  1  1 126104   1788    256   5232  16 8700    67  8710 1274   448   5  17  78
 1  0  1 136344   3068    260   5224   0 9656    46  9657 1390   473   6  20  75
   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  2  0 144024   3580    264   5232   0 8444    47  8452 1043   449   7  10  83
 0  1  0 154264   3580    260   5224   0 10240    48 10250 1031   450   6  19  75
 1  0  1 163480   1780    264   5232   0 9456    50  9456 1011   454   7  18  75
 0  2  1 174224   2028    264   5240 128 10004   187 10009 1025   467   5  19  76
 1  2  1 179256   2668    264   5328 312 5376   904  5381  980   493   8  12  80
 0  2  1 185804   2572    272   5328 304 6152   415  6156  957   469   5  11  84
 0  2  1 188852   2036    272   5336  60 3372    92  3372  992   407   1  12  87
 0  1  1 193972   2112    264   5332   0 4868    33  4877  988   363   4  11  85
 1  0  1 196016   2600    292   5332  64 2200   103  2200 1031   431   2   8  90
 0  6  0  35300 177700    296   3696 3824 6788 19989  6809 9342  1920   1  29  70
 1  4  0  34852 174540    316   5664 956   0  2690     0  969   209   2   6  92
 1  1  0  34276 171868    336   7392 712   0  2459     0  996   221   1   5  94
 0  1  0  32704 168616    376   8424 1920   0  3370     0  990   315   0   5  95
 0  5  0  29784 165524    412   9100 2200   0  2902     0  967   297   4   6  90
 0  4  0  25012 162484    432  10596 1620   0  3141     0  942   249   5   8  87
 0  5  0  24636 159452    456  12108 1244   0  2767     0  927   172   0   5  95
 0  7  2  21472 156856    480  13288 2120   0  3316     0  951   238   1   6  93

output from dmesg:

lloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process ls
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process ls
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process xmms
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process sawfish
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process gpm
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process klogd
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process xchat
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process gaim
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
__alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012903e
VM: killing process ls

-- 
L1:	khromy		;khromy at lnuxlab.ath.cx
