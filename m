Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSJZCKm>; Fri, 25 Oct 2002 22:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261800AbSJZCKm>; Fri, 25 Oct 2002 22:10:42 -0400
Received: from fmr01.intel.com ([192.55.52.18]:43229 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S261799AbSJZCKh>;
	Fri, 25 Oct 2002 22:10:37 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000ECE70F1@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel using Intel compiler (lmben
	ch data)
Date: Fri, 25 Oct 2002 19:16:49 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following are the lmbench results (P3 and P4P) we tried to get. The
kernels built by gcc 3.2 were not stable for P4P, so we used an older
version of gcc.

p70 -- the kernel built by just with the -O2 optimization (Intel compiler
7.0)
pgoipo -- P70 + PGO (profile-guided optimization) + IPO (interprocedural
optimization)
inline -- pgoipo + forced inline
gcc32 -- gcc 3.2
gcc30 -- gcc 3.02 

Jun Nakajima

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Friday, October 18, 2002 7:29 PM
To: Nakajima, Jun
Cc: Andi Kleen; David S. Miller; torvalds@transmeta.com;
linux-kernel@vger.kernel.org; Mallick, Asit K; Saxena, Sunil
Subject: Re: [PATCH] fixes for building kernel using Intel compiler



BTW do you have any benchmark / code size results to share with 
Intel compiler vs gcc 3.2 ? How much does it give ?

-Andi
-------------------------------------------------------------------------


UP P3 ====================================================================

cd results && make summary percent 2>/dev/null | more
make[1]: Entering directory `/home/hd7/yu/LMbench/results'

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
p70        Linux 2.4.18       i686-pc-linux-gnu  847
p70        Linux 2.4.18       i686-pc-linux-gnu  847
p70        Linux 2.4.18       i686-pc-linux-gnu  847
pgo        Linux 2.4.18       i686-pc-linux-gnu  847
pgo        Linux 2.4.18       i686-pc-linux-gnu  847
pgo        Linux 2.4.18       i686-pc-linux-gnu  847
pgoipo     Linux 2.4.18       i686-pc-linux-gnu  847
pgoipo     Linux 2.4.18       i686-pc-linux-gnu  847
pgoipo     Linux 2.4.18       i686-pc-linux-gnu  847
inline     Linux 2.4.18       i686-pc-linux-gnu  847
inline     Linux 2.4.18       i686-pc-linux-gnu  847
inline     Linux 2.4.18       i686-pc-linux-gnu  847
gcc32      Linux 2.4.18       i686-pc-linux-gnu  847
gcc32      Linux 2.4.18       i686-pc-linux-gnu  847
gcc32      Linux 2.4.18       i686-pc-linux-gnu  847

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec
sh  
                             call  I/O stat clos TCP   inst hndl proc proc
proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ----
----
p70        Linux 2.4.18  847 0.37 0.54 2.76 3.61  15.4 0.93 2.92 95.4 1144
5418
p70        Linux 2.4.18  847 0.37 0.54 2.80 3.61  15.9 0.93 2.92 96.3 1130
5414
p70        Linux 2.4.18  847 0.37 0.57 2.78 3.68  16.0 0.93 2.92 95.8 1152
5417
pgo        Linux 2.4.18  847 0.35 0.52 2.88 3.42  15.5 0.91 2.92 95.8 1122
5342
pgo        Linux 2.4.18  847 0.35 0.52 2.73 3.38  16.8 0.91 2.94 97.4 1107
5332
pgo        Linux 2.4.18  847 0.35 0.52 2.83 3.41  13.7 0.91 2.92 95.6 1133
5324
pgoipo     Linux 2.4.18  847 0.35 0.53 2.32 2.76  13.3 0.92 2.84 91.9 1131
5267
pgoipo     Linux 2.4.18  847 0.35 0.52 2.25 2.76  14.5 0.92 2.84 106. 1120
5259
pgoipo     Linux 2.4.18  847 0.35 0.51 2.34 2.81  13.2 0.92 2.84 95.8 1121
5270
inline     Linux 2.4.18  847 0.35 0.51 2.26 2.77  13.4 0.92 2.84 105. 1173
5294
inline     Linux 2.4.18  847 0.35 0.51 2.26 2.89  13.4 0.92 2.84 91.0 1099
5280
inline     Linux 2.4.18  847 0.35 0.51 2.32 2.92  13.3 0.92 2.84 90.6 1126
5329
gcc32      Linux 2.4.18  847 0.35 0.52 3.01 3.67  15.0 0.95 3.10 104. 1200
5532
gcc32      Linux 2.4.18  847 0.35 0.51 3.03 3.73  15.6 0.95 3.10 103. 1182
5521
gcc32      Linux 2.4.18  847 0.35 0.51 3.06 3.76  15.0 0.95 3.10 104. 1169
5520

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
p70        Linux 2.4.18 0.770 3.9900   13.3 4.5000  163.2    33.3   163.8
p70        Linux 2.4.18 0.700 3.9500   13.7 6.1400  163.4    31.4   163.4
p70        Linux 2.4.18 0.730 4.1900   13.0 7.9100  162.7    37.6   162.9
pgo        Linux 2.4.18 0.840 4.1100   22.0 8.9200  164.0    36.6   164.4
pgo        Linux 2.4.18 0.820 3.9900   13.0 5.6000  162.6    32.8   163.2
pgo        Linux 2.4.18 0.930 3.9900   13.1 4.8700  162.9    33.4   163.4
pgoipo     Linux 2.4.18 0.820 3.9100   13.0 6.1800  163.5    30.0   163.5
pgoipo     Linux 2.4.18 0.860 3.9600   13.1 5.2000  163.7    33.6   163.6
pgoipo     Linux 2.4.18 0.820 4.1000   13.5 5.4900  162.4    33.7   163.2
inline     Linux 2.4.18 0.900 4.0800   13.1 7.3500  162.8    30.7   162.9
inline     Linux 2.4.18 0.830 4.0600   13.3 7.7100  163.6    33.1   163.9
inline     Linux 2.4.18 0.810 3.9300   62.7 4.7700  162.2    31.4   163.3
gcc32      Linux 2.4.18 0.780 4.1100   14.9 8.2400  163.6    33.0   164.3
gcc32      Linux 2.4.18 0.870 4.1900   13.1 4.4300  162.6    30.8   163.0
gcc32      Linux 2.4.18 0.900 4.2000   15.3 6.4100  162.2    30.7   162.5

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
p70        Linux 2.4.18 0.770 4.111 7.30  13.1  32.8  18.9  44.7 69.1
p70        Linux 2.4.18 0.700 4.405 7.51  13.2  32.8  19.2  45.6 70.1
p70        Linux 2.4.18 0.730 4.392 7.37  13.5  32.8  19.3  44.7 70.8
pgo        Linux 2.4.18 0.840 4.187 7.32  11.5  28.6  14.0  36.8 54.4
pgo        Linux 2.4.18 0.820 4.354 7.23  11.6  28.4  14.3  36.9 54.8
pgo        Linux 2.4.18 0.930 4.386 7.50  11.7  28.6  14.5  37.1 54.9
pgoipo     Linux 2.4.18 0.820 4.072 6.83  10.8  27.6  14.0  36.7 53.6
pgoipo     Linux 2.4.18 0.860 4.309 7.05  10.9  27.6  14.2  36.3 53.1
pgoipo     Linux 2.4.18 0.820 4.168 7.09  11.0  27.7  14.2  37.2 53.3
inline     Linux 2.4.18 0.900 4.126 6.96  10.9  27.8  14.1  36.9 53.0
inline     Linux 2.4.18 0.830 4.348 6.96  10.8  27.6  14.1  36.7 53.5
inline     Linux 2.4.18 0.810 4.363 7.15  10.8  27.3  14.1  36.7 53.7
gcc32      Linux 2.4.18 0.780 4.224 7.33  15.7  35.3  21.6  47.5 72.9
gcc32      Linux 2.4.18 0.870 4.327 7.56  15.7  35.6  21.8  47.1 73.0
gcc32      Linux 2.4.18 0.900 4.377 7.55  15.6  35.5  21.9  48.0 72.8

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page

                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
p70        Linux 2.4.18   17.4 5.0970  101.8   11.6    417.0 0.729 2.00000
p70        Linux 2.4.18   17.5 5.2120  102.3   11.7    420.0 0.729 2.00000
p70        Linux 2.4.18   17.4 5.1150  101.3   11.7    430.0 0.731 2.00000
pgo        Linux 2.4.18   18.2 4.9460  102.5   10.9    409.0 0.712 2.00000
pgo        Linux 2.4.18   18.1 4.8450  101.6   10.8    422.0 0.700 2.00000
pgo        Linux 2.4.18   18.2 4.9180  101.9   10.9    432.0 0.701 2.00000
pgoipo     Linux 2.4.18   17.1 4.5070  100.2   10.4    376.0 0.709 2.00000
pgoipo     Linux 2.4.18   17.0 4.4400  100.2   10.3    388.0 0.708 2.00000
pgoipo     Linux 2.4.18   17.1 4.5340  100.1   10.5    393.0 0.730 2.00000
inline     Linux 2.4.18   17.1 4.4790  101.0   10.4    375.0 0.709 2.00000
inline     Linux 2.4.18   17.1 4.5270  100.9   10.4    387.0 0.709 2.00000
inline     Linux 2.4.18   17.2 4.5390   99.6   10.4    380.0 0.709 2.00000
gcc32      Linux 2.4.18   36.1 5.4180  123.8   12.1    379.0 0.709 2.00000
gcc32      Linux 2.4.18   36.2 5.3890  122.8   12.0    393.0 0.715 2.00000
gcc32      Linux 2.4.18   36.1 5.3990  121.0   12.0    398.0 0.709 2.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read
write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ----
-----
p70        Linux 2.4.18 847. 660. 205.  402.5  372.7  157.5  150.8 372.
196.1
p70        Linux 2.4.18 841. 409. 233.  410.2  372.8  153.8  147.5 372.
197.1
p70        Linux 2.4.18 848. 712. 235.  414.5  372.8  156.1  151.5 372.
202.0
pgo        Linux 2.4.18 863. 571. 280.  415.1  372.8  152.8  146.8 372.
193.2
pgo        Linux 2.4.18 860. 555. 285.  415.1  372.8  151.9  145.3 372.
195.0
pgo        Linux 2.4.18 847. 750. 168.  415.4  372.6  152.7  146.6 372.
195.7
pgoipo     Linux 2.4.18 869. 704. 237.  417.4  372.9  152.7  146.1 372.
193.1
pgoipo     Linux 2.4.18 868. 683. 308.  414.2  372.9  151.5  145.3 372.
194.9
pgoipo     Linux 2.4.18 866. 393. 220.  413.9  372.9  152.8  146.4 372.
195.8
inline     Linux 2.4.18 880. 550. 223.  406.1  372.6  152.9  146.7 372.
191.8
inline     Linux 2.4.18 803. 345. 212.  416.7  372.9  151.5  145.3 372.
195.0
inline     Linux 2.4.18 872. 704. 236.  413.6  372.9  152.7  146.2 372.
195.9
gcc32      Linux 2.4.18 872. 612. 190.  414.0  372.8  158.5  151.2 372.
194.9
gcc32      Linux 2.4.18 868. 384. 230.  416.8  372.5  155.2  150.1 372.
199.4
gcc32      Linux 2.4.18 856. 675. 196.  416.6  372.8  157.1  151.8 372.
202.8

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
p70        Linux 2.4.18   847 3.540 8.2610  131.8
p70        Linux 2.4.18   847 3.540 8.2630  131.8
p70        Linux 2.4.18   847 3.541 8.2610  131.8
pgo        Linux 2.4.18   847 3.541 8.2600  131.8
pgo        Linux 2.4.18   847 3.541 8.2600  131.8
pgo        Linux 2.4.18   847 3.541 8.2610  131.8
pgoipo     Linux 2.4.18   847 3.540 8.2710  131.8
pgoipo     Linux 2.4.18   847 3.540 8.2700  131.8
pgoipo     Linux 2.4.18   847 3.541 8.2610  131.8
inline     Linux 2.4.18   847 3.541 8.2610  131.8
inline     Linux 2.4.18   847 3.540 8.2610  131.8
inline     Linux 2.4.18   847 3.541 8.2700  131.8
gcc32      Linux 2.4.18   847 3.541   46.8  131.8
gcc32      Linux 2.4.18   847 3.541 8.2610  131.8
gcc32      Linux 2.4.18   847 3.540 8.2610  131.8
make[1]: Leaving directory `/home/hd7/yu/LMbench/results'

UP P4P
========================================================================

cd results && make summary percent 2>/dev/null | more
make[1]: Entering directory `/home/benjamin/LMbench/results'

                 L M B E N C H  2 . 0   S U M M A R Y
                 ------------------------------------


Basic system parameters
----------------------------------------------------
Host                 OS Description              Mhz
                                                    
--------- ------------- ----------------------- ----
p70        Linux 2.4.18       i686-pc-linux-gnu 1900
p70        Linux 2.4.18       i686-pc-linux-gnu 1900
p70        Linux 2.4.18       i686-pc-linux-gnu 1900
pgoipo     Linux 2.4.18       i686-pc-linux-gnu 1900
pgoipo     Linux 2.4.18       i686-pc-linux-gnu 1900
pgoipo     Linux 2.4.18       i686-pc-linux-gnu 1900
inline     Linux 2.4.18       i686-pc-linux-gnu 1900
inline     Linux 2.4.18       i686-pc-linux-gnu 1900
inline     Linux 2.4.18       i686-pc-linux-gnu 1900
gcc30      Linux 2.4.18       i686-pc-linux-gnu 1900
gcc30      Linux 2.4.18       i686-pc-linux-gnu 1900
gcc30      Linux 2.4.18       i686-pc-linux-gnu 1900

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec
sh  
                             call  I/O stat clos TCP   inst hndl proc proc
proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ----
----
p70        Linux 2.4.18 1900 0.84 0.92 2.19 3.31 7.107 1.16 3.34 139. 731.
3328
p70        Linux 2.4.18 1900 0.84 0.93 2.19 3.37 7.102 1.17 3.38 128. 707.
3280
p70        Linux 2.4.18 1900 0.84 0.94 2.23 3.39 7.026 1.17 3.38 132. 709.
3286
pgoipo     Linux 2.4.18 1900 0.84 0.92 1.98 2.99 6.471 1.15 3.17 124. 701.
3240
pgoipo     Linux 2.4.18 1900 0.84 0.92 2.03 3.00 6.471 1.15 3.16 131. 697.
3223
pgoipo     Linux 2.4.18 1900 0.84 0.92 2.02 2.93 6.492 1.15 3.15 126. 697.
3223
inline     Linux 2.4.18 1900 0.84 0.91 2.04 3.00 5.852 1.12 3.15 119. 691.
3209
inline     Linux 2.4.18 1900 0.84 0.93 2.09 3.00 5.858 1.14 3.13 124. 692.
3219
inline     Linux 2.4.18 1900 0.84 0.91 2.05 3.01 6.552 1.14 3.12 130. 699.
3216
gcc30      Linux 2.4.18 1900 0.84 0.93 2.75 3.77 7.908 1.16 3.34 131. 707.
3303
gcc30      Linux 2.4.18 1900 0.84 0.93 2.71 3.76 7.947 1.16 3.35 136. 707.
3322
gcc30      Linux 2.4.18 1900 0.84 0.93 2.72 3.72 7.913 1.16 3.35 130. 710.
3326

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------
Host                 OS 2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                        ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ----- ------ ------ ------ ------ ------- -------
p70        Linux 2.4.18 1.000 2.1900 5.7400 6.4100   41.5    12.2    41.5
p70        Linux 2.4.18 1.070 2.2400 9.6600 4.7900   41.4    12.2    41.7
p70        Linux 2.4.18 1.020 2.4400   10.0 8.0700   41.4    12.4    41.4
pgoipo     Linux 2.4.18 0.960 2.2300 7.3700 5.6800   41.4    12.8    41.5
pgoipo     Linux 2.4.18 1.160 2.1900 5.8900 5.6300   41.5    12.5    41.6
pgoipo     Linux 2.4.18 0.960 2.2200 5.9400 5.6000   41.4    12.8    41.4
inline     Linux 2.4.18 0.930 2.2100   14.8 6.5200   41.6    12.5    41.6
inline     Linux 2.4.18 1.130 2.1400 6.3400 5.5700   41.4    12.4    41.4
inline     Linux 2.4.18 0.790 2.1800 6.2600 5.3600   41.3    12.2    41.5
gcc30      Linux 2.4.18 1.040 2.9000 6.6000 5.8500   41.4    12.2    41.6
gcc30      Linux 2.4.18 1.020 2.3000   11.8 4.8200   41.6    12.1    41.5
gcc30      Linux 2.4.18 1.040 2.4500 7.9700 5.4100   41.0    12.5    41.5

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
p70        Linux 2.4.18 1.000 6.086 8.91  12.3  22.9  14.1  29.3 41.5
p70        Linux 2.4.18 1.070 6.087 8.79  12.2  23.5  14.1  29.7 41.1
p70        Linux 2.4.18 1.020 6.515 9.01  12.3  24.1  14.2  30.6 41.5
pgoipo     Linux 2.4.18 0.960 6.133 8.38  11.2  23.6  12.5  26.8 38.2
pgoipo     Linux 2.4.18 1.160 5.961 8.73  11.3  24.1  13.0  27.8 37.4
pgoipo     Linux 2.4.18 0.960 6.037 8.48  11.3  21.3  12.7  26.6 38.1
inline     Linux 2.4.18 0.930 5.972 8.48  11.2  22.0  12.5  26.3 38.0
inline     Linux 2.4.18 1.130 6.213 8.69  12.2  22.4  12.8  26.6 37.5
inline     Linux 2.4.18 0.790 5.881 9.21  11.2  22.5  12.4  27.1 39.5
gcc30      Linux 2.4.18 1.040 6.259 8.95  19.1  23.8  14.7  28.9 43.1
gcc30      Linux 2.4.18 1.020 6.216 9.09  12.6  25.4  14.7  30.1 48.4
gcc30      Linux 2.4.18 1.040 6.253 9.00  12.6  24.1  15.3  28.7 600K

File & VM system latencies in microseconds - smaller is better
--------------------------------------------------------------
Host                 OS   0K File      10K File      Mmap    Prot    Page

                        Create Delete Create Delete  Latency Fault   Fault 
--------- ------------- ------ ------ ------ ------  ------- -----   ----- 
p70        Linux 2.4.18 9.1580 3.3540   33.3 6.4340    737.0 1.598 3.00000
p70        Linux 2.4.18   11.6 4.5730   35.4 7.9510    746.0 1.542 3.00000
p70        Linux 2.4.18 9.2350 3.4030   31.5 6.5050    744.0 1.567 3.00000
pgoipo     Linux 2.4.18 9.5180 2.9890   32.6 5.9670    732.0 1.579 3.00000
pgoipo     Linux 2.4.18 9.5060 2.9900   31.9 5.8690    724.0 1.579 3.00000
pgoipo     Linux 2.4.18 9.7190 2.9990   31.5 5.9370    723.0 1.578 3.00000
inline     Linux 2.4.18 9.2640 2.9400   33.9 5.9020    721.0 1.566 3.00000
inline     Linux 2.4.18 9.2830 2.9270   32.9 5.8440    721.0 1.573 3.00000
inline     Linux 2.4.18 9.2660 2.9700   32.4 5.9030    798.0 1.572 3.00000
gcc30      Linux 2.4.18   24.6 3.3240   48.5 6.8920    751.0 1.580 3.00000
gcc30      Linux 2.4.18   24.3 3.3140   47.7 6.8220    749.0 1.536 3.00000
gcc30      Linux 2.4.18   24.6 3.3320   46.9 6.9150    751.0 1.555 3.00000

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------
Host                OS  Pipe AF    TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                             UNIX      reread reread (libc) (hand) read
write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ----
-----
p70        Linux 2.4.18 1188 1470 714. 1471.7 1459.6  623.7  615.5 1459
730.5
p70        Linux 2.4.18 984. 1490 394. 1520.3 1459.7  609.0  621.2 1459
771.0
p70        Linux 2.4.18 1054 1053 380. 1507.1 1459.5  624.2  626.8 1459
798.7
pgoipo     Linux 2.4.18 1130 1432 408. 1529.6 1459.8  623.9  616.3 1459
731.7
pgoipo     Linux 2.4.18 905. 1734 337. 1527.2 1459.6  616.1  624.9 1459
767.3
pgoipo     Linux 2.4.18 1100 1494 396. 1493.3 1459.6  630.9  628.9 1459
796.7
inline     Linux 2.4.18 1151 1629 380. 1530.8 1459.5  612.5  610.3 1459
732.6
inline     Linux 2.4.18 1186 1128 413. 1132.0 1459.5  608.4  623.8 1459
768.0
inline     Linux 2.4.18 937. 1105 345. 1522.3 1459.5  628.1  632.2 1459
800.1
gcc30      Linux 2.4.18 1056 1098 349. 1449.5 1460.0  613.3  608.7 1459
734.2
gcc30      Linux 2.4.18 1231 1343 368. 1472.3 1460.1  616.7  627.0 1459
773.9
gcc30      Linux 2.4.18 1134 1182 372. 1503.9 1459.9  626.1  632.1 1460
801.0

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
---------------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    Guesses
--------- -------------  ---- ----- ------    --------    -------
p70        Linux 2.4.18  1900 1.056 9.7150  166.6
p70        Linux 2.4.18  1900 1.056   20.1  166.4
p70        Linux 2.4.18  1900 1.056 9.7120  166.4
pgoipo     Linux 2.4.18  1900 1.056   54.7  166.6
pgoipo     Linux 2.4.18  1900 1.056 9.7130  166.5
pgoipo     Linux 2.4.18  1900 1.056 9.7170  166.4
inline     Linux 2.4.18  1900 1.056 9.7110  166.3
inline     Linux 2.4.18  1900 1.056 9.7240  166.8
inline     Linux 2.4.18  1900 1.057 9.7120  166.7
gcc30      Linux 2.4.18  1900 1.146 9.7200  166.3
gcc30      Linux 2.4.18  1900 1.059 9.7120  166.6
gcc30      Linux 2.4.18  1900 1.058 9.7130  166.6
make[1]: Leaving directory `/home/benjamin/LMbench/results'
