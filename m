Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbVIJNWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbVIJNWP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbVIJNWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:22:15 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:47510 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S1750825AbVIJNWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:22:14 -0400
Date: Sat, 10 Sep 2005 15:22:12 +0200
From: Frank van Maarseveen <frankvm@frankvm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13 SMP on AMD Athlon X2 (i386): time anomalies
Message-ID: <20050910132212.GA32128@janus>
References: <20050906211029.GA1638@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906211029.GA1638@janus>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New food for bugzilla #5105 (I'll stick it there too). stracing xclock
on the system with _zero_ load shows time warps and even time going
backward! The xclock itself occasionally gets stuck and then jumps
multiple seconds at once.

There are many other anomalies, e.g. the Xorg screenblank should operate
after 300 seconds but it does much earlier, seemingly with a random
interval: 15 seconds, 38 second, 50 seconds.

system wall clock seems ok now which is kind of surprising.

booting with nosmp fixes it but that's no fun anymore.

There should be a lot of people noticing these kind of anomalies: it is
not a recent regression but it seems to show up only on AMD Athlon64 X2
(SMP), for both i386 and x86_64.

strace -tt -p 2208
Process 2208 attached - interrupt to quit
15:00:44.175424 select(4, [3], [], [], {0, 684000}) = 0 (Timeout)
15:00:46.999608 gettimeofday({1126357246, 999713}, NULL) = 0
15:00:46.999734 gettimeofday({1126357246, 999792}, NULL) = 0
15:00:46.999853 gettimeofday({1126357246, 999910}, NULL) = 0
15:00:46.999978 ioctl(3, FIONREAD, [0]) = 0
15:00:47.000110 write(3, ">\n\7\0\f\0\340\0\v\0\340\0\7\0\340\0\0\0\0\0\0\0\0\0\0"..., 28) = 28
15:00:47.000261 ioctl(3, FIONREAD, [0]) = 0
15:00:44.856241 gettimeofday({1126357244, 856298}, NULL) = 0
15:00:44.856355 select(4, [3], [], [], {2, 143612}) = 0 (Timeout)
15:00:49.143862 gettimeofday({1126357249, 143964}, NULL) = 0
15:00:49.144024 gettimeofday({1126357249, 144111}, NULL) = 0
15:00:49.144167 gettimeofday({1126357249, 144252}, NULL) = 0
15:00:49.144431 ioctl(3, FIONREAD, [0]) = 0
15:00:47.000441 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\10\0\24\0E\0(\0\233\6\5\0\r"..., 8980) = 8980
15:00:47.000660 ioctl(3, FIONREAD, [0]) = 0
15:00:47.000789 gettimeofday({1126357247, 871}, NULL) = 0
15:00:47.000920 select(4, [3], [], [], {2, 998381}) = 0 (Timeout)
15:00:50.001238 gettimeofday({1126357250, 1340}, NULL) = 0
15:00:50.001399 gettimeofday({1126357250, 1486}, NULL) = 0
15:00:50.001540 gettimeofday({1126357250, 1626}, NULL) = 0
15:00:50.001807 ioctl(3, FIONREAD, [0]) = 0
15:00:50.001949 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\f\0\24\0A\0(\0\233\6\5\0\r"..., 8980) = 8980
15:00:50.002170 ioctl(3, FIONREAD, [0]) = 0
15:00:50.002298 gettimeofday({1126357250, 2381}, NULL) = 0
15:00:50.002430 select(4, [3], [], [], {0, 997245}) = 0 (Timeout)
15:00:51.001328 gettimeofday({1126357251, 1435}, NULL) = 0
15:00:51.001491 gettimeofday({1126357251, 1577}, NULL) = 0
15:00:51.001631 gettimeofday({1126357251, 1727}, NULL) = 0
15:00:51.001981 ioctl(3, FIONREAD, [0]) = 0
15:00:51.002131 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\16\0\24\0?\0(\0\233\6\5\0\r"..., 8980) = 8980
15:00:51.002276 ioctl(3, FIONREAD, [0]) = 0
15:00:51.002347 gettimeofday({1126357251, 2402}, NULL) = 0
15:00:51.002418 select(4, [3], [], [], {0, 997325}) = 0 (Timeout)
15:00:52.001454 gettimeofday({1126357252, 1557}, NULL) = 0
15:00:52.001624 gettimeofday({1126357252, 1681}, NULL) = 0
15:00:52.001697 gettimeofday({1126357252, 1752}, NULL) = 0
15:00:52.001891 ioctl(3, FIONREAD, [0]) = 0
15:00:52.001965 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\20\0\24\0=\0(\0\233\6\5\0\r"..., 8980) = 8980
15:00:52.002107 ioctl(3, FIONREAD, [0]) = 0
15:00:52.002178 gettimeofday({1126357252, 2233}, NULL) = 0
15:00:52.002249 select(4, [3], [], [], {0, 997519}) = 0 (Timeout)
15:00:53.001569 gettimeofday({1126357253, 1672}, NULL) = 0
15:00:53.001738 gettimeofday({1126357253, 1795}, NULL) = 0
15:00:53.001811 gettimeofday({1126357253, 1866}, NULL) = 0
15:00:53.002006 ioctl(3, FIONREAD, [0]) = 0
15:00:53.002080 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\24\0\24\0009\0(\0\233\6\5\0"..., 8980) = 8980
15:00:53.002224 ioctl(3, FIONREAD, [0]) = 0
15:00:53.002295 gettimeofday({1126357253, 2350}, NULL) = 0
15:00:53.002366 select(4, [3], [], [], {0, 997516}) = 0 (Timeout)
15:00:54.001628 gettimeofday({1126357254, 1728}, NULL) = 0
15:00:54.001804 gettimeofday({1126357254, 1862}, NULL) = 0
15:00:54.001878 gettimeofday({1126357254, 1933}, NULL) = 0
15:00:54.002073 ioctl(3, FIONREAD, [0]) = 0
15:00:54.002147 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\27\0\20\0006\0,\0\233\6\5\0"..., 8980) = 8980
15:00:54.002289 ioctl(3, FIONREAD, [0]) = 0
15:00:54.002360 gettimeofday({1126357254, 2415}, NULL) = 0
15:00:54.002431 select(4, [3], [], [], {0, 997518}) = 0 (Timeout)
15:00:55.001713 gettimeofday({1126357255, 1813}, NULL) = 0
15:00:55.001887 gettimeofday({1126357255, 1944}, NULL) = 0
15:00:55.001961 gettimeofday({1126357255, 2015}, NULL) = 0
15:00:55.002155 ioctl(3, FIONREAD, [0]) = 0
15:00:55.002229 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\33\0\16\0002\0.\0\233\6\5\0"..., 8980) = 8980
15:00:55.002371 ioctl(3, FIONREAD, [0]) = 0
15:00:55.002442 gettimeofday({1126357255, 2497}, NULL) = 0
15:00:55.002513 select(4, [3], [], [], {0, 997518}) = 0 (Timeout)
15:00:56.001826 gettimeofday({1126357256, 1931}, NULL) = 0
15:00:56.001997 gettimeofday({1126357256, 2055}, NULL) = 0
15:00:56.002071 gettimeofday({1126357256, 2126}, NULL) = 0
15:00:56.002266 ioctl(3, FIONREAD, [0]) = 0
15:00:56.002340 write(3, "F\n\5\0\f\0\340\0\7\0\340\0\37\0\f\0.\0000\0\233\6\5\0"..., 8980) = 8980
15:00:56.002482 ioctl(3, FIONREAD, [0]) = 0
15:00:56.002552 gettimeofday({1126357256, 2607}, NULL) = 0
15:00:56.002623 select(4, [3], [], [], {0, 996519}) = 0 (Timeout)
15:00:57.002161 gettimeofday({1126357257, 2266}, NULL) = 0
15:00:57.002332 gettimeofday({1126357257, 2390}, NULL) = 0
15:00:57.002406 gettimeofday({1126357257, 2461}, NULL) = 0
15:00:57.002600 ioctl(3, FIONREAD, [0]) = 0
15:00:57.002674 write(3, "F\n\5\0\f\0\340\0\7\0\340\0$\0\n\0)\0002\0\233\6\5\0\r"..., 8980) = 8980
15:00:57.002816 ioctl(3, FIONREAD, [0]) = 0
15:00:57.002887 gettimeofday({1126357257, 2941}, NULL) = 0
15:00:57.002958 select(4, [3], [], [], {0, 996520}) = 0 (Timeout)
15:01:00.144797 gettimeofday({1126357260, 144867}, NULL) = 0
15:01:00.144888 gettimeofday({1126357260, 144943}, NULL) = 0
15:01:00.144959 gettimeofday({1126357260, 145013}, NULL) = 0
15:01:00.145152 ioctl(3, FIONREAD, [0]) = 0
15:00:58.001094 write(3, "F\n\5\0\f\0\340\0\7\0\340\0(\0\10\0%\0004\0\233\6\5\0\r"..., 8780) = 8780
15:00:58.001237 ioctl(3, FIONREAD, [0]) = 0
15:00:58.001308 gettimeofday({1126357258, 1363}, NULL) = 0
15:00:58.001379 select(4, [3], [], [], {2, 998650}) = 0 (Timeout)
15:01:03.145072 gettimeofday({1126357263, 145171}, NULL) = 0
15:01:03.145238 gettimeofday({1126357263, 145296}, NULL) = 0
15:01:03.145313 gettimeofday({1126357261, 1234}, NULL) = 0
15:01:01.001372 gettimeofday({1126357261, 1429}, NULL) = 0
15:01:01.001444 gettimeofday({1126357261, 1498}, NULL) = 0
15:01:01.001603 writev(3, [{"F\n\5\0\f\0\340\0\7\0\340\0004\0\10\0\31\0004\0\233\6\5"..., 16336}, {"\254\26\26\0\216v\26\0,I]\0\254\26\26\0\301i[\0X\306\27"..., 120}], 2) = 16456
15:01:01.001793 gettimeofday({1126357261, 1849}, NULL) = 0
15:01:01.001864 gettimeofday({1126357261, 1919}, NULL) = 0
15:01:01.001936 gettimeofday({1126357261, 1990}, NULL) = 0
15:01:01.002005 gettimeofday({1126357261, 2059}, NULL) = 0
15:01:01.002076 gettimeofday({1126357261, 2130}, NULL) = 0
15:01:01.002145 gettimeofday({1126357261, 2199}, NULL) = 0
15:01:01.002216 gettimeofday({1126357261, 2270}, NULL) = 0
15:01:01.002284 gettimeofday({1126357261, 2339}, NULL) = 0
15:01:01.002355 gettimeofday({1126357261, 2410}, NULL) = 0
15:01:01.002424 gettimeofday({1126357261, 2478}, NULL) = 0
15:01:01.002495 gettimeofday({1126357261, 2549}, NULL) = 0
15:01:01.002564 gettimeofday({1126357261, 2618}, NULL) = 0
15:01:01.002635 gettimeofday({1126357261, 2689}, NULL) = 0
15:01:01.002704 gettimeofday({1126357261, 2758}, NULL) = 0
15:01:01.002774 gettimeofday({1126357261, 2829}, NULL) = 0
15:01:01.002843 gettimeofday({1126357261, 2898}, NULL) = 0
15:01:01.002914 gettimeofday({1126357261, 2968}, NULL) = 0
15:01:01.002983 gettimeofday({1126357261, 3037}, NULL) = 0
15:01:01.003054 gettimeofday({1126357261, 3108}, NULL) = 0
15:01:01.003122 gettimeofday({1126357261, 3177}, NULL) = 0
15:01:01.003193 gettimeofday({1126357261, 3248}, NULL) = 0
15:01:01.003262 gettimeofday({1126357261, 3316}, NULL) = 0
15:01:01.003333 gettimeofday({1126357261, 3387}, NULL) = 0
15:01:01.003402 gettimeofday({1126357261, 3456}, NULL) = 0
15:01:01.003472 gettimeofday({1126357261, 3527}, NULL) = 0
15:01:01.003541 gettimeofday({1126357261, 3596}, NULL) = 0
15:01:01.003612 gettimeofday({1126357261, 3667}, NULL) = 0
15:01:01.003681 gettimeofday({1126357261, 3735}, NULL) = 0
15:01:01.003752 gettimeofday({1126357261, 3806}, NULL) = 0
15:01:01.003821 gettimeofday({1126357261, 3875}, NULL) = 0
15:01:01.003892 gettimeofday({1126357263, 148080}, NULL) = 0
15:01:03.148095 gettimeofday({1126357263, 148149}, NULL) = 0
15:01:03.148269 ioctl(3, FIONREAD, [0]) = 0
15:01:01.005260 write(3, "\233\n$\0\3\0\340\0\17\0\340\0\r\0\340\0,\0\0\0\0\0\0\0"..., 10864) = 10864
15:01:01.005404 ioctl(3, FIONREAD, [0]) = 0
15:01:01.005476 gettimeofday({1126357261, 5531}, NULL) = 0
15:01:01.005547 select(4, [3], [], [], {2, 993618}) = 0 (Timeout)
15:01:06.145317 gettimeofday({1126357266, 145416}, NULL) = 0
15:01:06.145493 gettimeofday({1126357264, 1418}, NULL) = 0
15:01:04.001435 gettimeofday({1126357264, 1490}, NULL) = 0
15:01:04.001629 gettimeofday({1126357264, 1684}, NULL) = 0
15:01:04.001699 gettimeofday({1126357264, 1753}, NULL) = 0
15:01:04.001770 gettimeofday({1126357264, 1824}, NULL) = 0
15:01:04.001838 gettimeofday({1126357264, 1893}, NULL) = 0
15:01:04.001909 gettimeofday({1126357264, 1963}, NULL) = 0
15:01:04.001978 gettimeofday({1126357264, 2032}, NULL) = 0
15:01:04.002049 gettimeofday({1126357264, 2103}, NULL) = 0
15:01:04.002117 gettimeofday({1126357264, 2172}, NULL) = 0
15:01:04.002188 gettimeofday({1126357264, 2242}, NULL) = 0
15:01:04.002257 gettimeofday({1126357264, 2311}, NULL) = 0
15:01:04.002327 gettimeofday({1126357264, 2382}, NULL) = 0
15:01:04.002396 gettimeofday({1126357264, 2450}, NULL) = 0
15:01:04.002467 gettimeofday({1126357264, 2521}, NULL) = 0
15:01:04.002535 gettimeofday({1126357264, 2589}, NULL) = 0
15:01:04.002606 gettimeofday({1126357264, 2660}, NULL) = 0
15:01:04.002674 gettimeofday({1126357264, 2729}, NULL) = 0
15:01:04.002745 gettimeofday({1126357264, 2799}, NULL) = 0
15:01:04.002814 gettimeofday({1126357264, 2868}, NULL) = 0
15:01:04.002884 gettimeofday({1126357264, 2939}, NULL) = 0
15:01:04.002953 gettimeofday({1126357264, 3007}, NULL) = 0
15:01:04.003024 gettimeofday({1126357264, 3078}, NULL) = 0
15:01:04.003092 gettimeofday({1126357264, 3147}, NULL) = 0
15:01:04.003163 gettimeofday({1126357264, 3217}, NULL) = 0
15:01:04.003232 gettimeofday({1126357264, 3286}, NULL) = 0
15:01:04.003302 gettimeofday({1126357264, 3357}, NULL) = 0
15:01:04.003371 gettimeofday({1126357264, 3425}, NULL) = 0
15:01:04.003442 gettimeofday({1126357264, 3496}, NULL) = 0
15:01:04.003510 gettimeofday({1126357264, 3565}, NULL) = 0
15:01:04.003581 gettimeofday({1126357264, 3635}, NULL) = 0
15:01:04.003650 gettimeofday({1126357264, 3704}, NULL) = 0
15:01:04.003720 gettimeofday({1126357264, 3775}, NULL) = 0
15:01:04.003789 gettimeofday({1126357264, 3843}, NULL) = 0
15:01:04.003860 gettimeofday({1126357264, 3914}, NULL) = 0
15:01:04.003928 gettimeofday({1126357264, 3983}, NULL) = 0
15:01:04.003999 gettimeofday({1126357264, 4053}, NULL) = 0
15:01:04.004068 gettimeofday({1126357266, 148256}, NULL) = 0
15:01:06.148275 ioctl(3, FIONREAD, [0]) = 0
15:01:06.148348 write(3, "F\n\5\0\f\0\340\0\7\0\340\0004\0\n\0\31\0002\0\233\6\5"..., 9484) = 9484
15:01:06.148492 ioctl(3, FIONREAD, [0]) = 0
15:01:04.005443 gettimeofday({1126357264, 5500}, NULL) = 0
15:01:04.005516 select(4, [3], [], [], {3, 137756}) = 0 (Timeout)
15:01:09.289582 gettimeofday({1126357269, 289681}, NULL) = 0
15:01:07.145616 gettimeofday({1126357267, 145673}, NULL) = 0
15:01:07.145690 gettimeofday({1126357267, 145744}, NULL) = 0
15:01:07.145884 gettimeofday({1126357267, 145939}, NULL) = 0
15:01:07.145954 gettimeofday({1126357267, 146008}, NULL) = 0
15:01:07.146025 gettimeofday({1126357267, 146079}, NULL) = 0
15:01:07.146094 gettimeofday({1126357267, 146148}, NULL) = 0
15:01:07.146164 gettimeofday({1126357267, 146218}, NULL) = 0
15:01:07.146233 gettimeofday({1126357267, 146287}, NULL) = 0
15:01:07.146303 gettimeofday({1126357267, 146358}, NULL) = 0
15:01:07.146372 gettimeofday({1126357267, 146426}, NULL) = 0
15:01:07.146443 gettimeofday({1126357267, 146497}, NULL) = 0
15:01:07.146511 gettimeofday({1126357267, 146566}, NULL) = 0
15:01:07.146582 gettimeofday({1126357267, 146636}, NULL) = 0
15:01:07.146651 gettimeofday({1126357267, 146705}, NULL) = 0
15:01:07.146721 gettimeofday({1126357267, 146775}, NULL) = 0
15:01:07.146790 gettimeofday({1126357267, 146844}, NULL) = 0
15:01:07.146860 gettimeofday({1126357267, 146915}, NULL) = 0
15:01:07.146929 gettimeofday({1126357267, 146983}, NULL) = 0
15:01:07.147000 gettimeofday({1126357267, 147054}, NULL) = 0
15:01:07.147068 gettimeofday({1126357267, 147122}, NULL) = 0
15:01:07.147139 gettimeofday({1126357267, 147193}, NULL) = 0
15:01:07.147207 gettimeofday({1126357267, 147262}, NULL) = 0
15:01:07.147278 gettimeofday({1126357267, 147332}, NULL) = 0
15:01:07.147347 gettimeofday({1126357267, 147401}, NULL) = 0
15:01:07.147417 gettimeofday({1126357267, 147471}, NULL) = 0
15:01:07.147486 gettimeofday({1126357267, 147540}, NULL) = 0
15:01:07.147556 gettimeofday({1126357267, 147610}, NULL) = 0
15:01:07.147625 gettimeofday({1126357267, 147679}, NULL) = 0
15:01:07.147695 gettimeofday({1126357267, 147750}, NULL) = 0
15:01:07.147764 gettimeofday({1126357267, 147818}, NULL) = 0
15:01:07.147835 gettimeofday({1126357267, 147889}, NULL) = 0
15:01:07.147903 gettimeofday({1126357267, 147957}, NULL) = 0
15:01:07.147974 gettimeofday({1126357267, 148028}, NULL) = 0
15:01:07.148042 gettimeofday({1126357267, 148097}, NULL) = 0
15:01:07.148113 gettimeofday({1126357267, 148167}, NULL) = 0
15:01:07.148182 gettimeofday({1126357267, 148236}, NULL) = 0
15:01:07.148252 gettimeofday({1126357269, 292440}, NULL) = 0
15:01:09.292455 gettimeofday({1126357269, 292509}, NULL) = 0
15:01:09.292609 write(3, "F\n\5\0\f\0\340\0\7\0\340\0004\0\f\0%\0000\0\233\6\5\0"..., 16376) = 16376
15:01:07.149665 ioctl(3, FIONREAD, [0]) = 0
15:01:07.149764 write(3, "\233\n$\0\3\0\340\0\17\0\340\0\r\0\340\0,\0\0\0\0\0\0\0"..., 2060) = 2060
15:01:07.149864 ioctl(3, FIONREAD, [0]) = 0
15:01:07.149933 gettimeofday({1126357267, 149988}, NULL) = 0
15:01:07.150004 select(4, [3], [], [], {2, 849521} <unfinished ...>
Process 2208 detached


-- 
Frank
