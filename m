Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSKTW50>; Wed, 20 Nov 2002 17:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSKTW4R>; Wed, 20 Nov 2002 17:56:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:7334 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262924AbSKTWza>;
	Wed, 20 Nov 2002 17:55:30 -0500
Message-ID: <3DDC1480.402A0E5B@digeo.com>
Date: Wed, 20 Nov 2002 15:02:24 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Aaron Lehmann <aaronl@vitelus.com>, Con Kolivas <conman@kolivas.net>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.47{-mm1} with contest
References: <3DD0E037.1FC50147@digeo.com> <Pine.LNX.3.96.1021112150713.25274B-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2002 23:02:29.0218 (UTC) FILETIME=[E667F420:01C290E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> ...
> In the area of things I do do every day, the occasionally posted AIM and
> BYTE benchmarks look as though pipe latency and thruput are down, UNIX
> socket latency and thruput are down, and these are things which will make
> the system feel slower.


OK, I finally got around to running AIM9.  2.4.20-rc1aa1 versus 2.5.48-mm1+

2.5 has taken a 1% to 1.5% hit everywhere due to the HZ change.  2.5 is faster
at lots of things and significantly slower at a couple of things.  Which is all
exactly as one would hope and expect.  I really don't know what's up with Pavan's
testing.   I tested a quad PIII, so maybe there's a uniprocessor problem or
artifact...




First row: 2.4.30-rc1aa1
Second row: 2.5.48-mm1+


add_double 30040 18.5087 333155.79 Thousand Double Precision Additions/second
add_double 10020 18.1637 326946.11 Thousand Double Precision Additions/second

    In all the compute-intensive operations, 2.5 is 1%-1.5% slower
    due to the increase in HZ from 100 to 1000.

add_float 30000 27.7667 333200.00 Thousand Single Precision Additions/second
add_float 10010 27.2727 327272.73 Thousand Single Precision Additions/second

add_long 30000 17.1333 1028000.00 Thousand Long Integer Additions/second
add_long 10040 16.8327 1009960.16 Thousand Long Integer Additions/second

add_int 30050 17.1381 1028286.19 Thousand Integer Additions/second
add_int 10050 16.8159 1008955.22 Thousand Integer Additions/second

add_short 30000 29.3667 704800.00 Thousand Short Integer Additions/second
add_short 10020 28.8423 692215.57 Thousand Short Integer Additions/second

creat-clo 30000 110.1 110100.00 File Creations and Closes/second
creat-clo 10010 119.181 119180.82 File Creations and Closes/second

    2.5 sped up opens and closes.  I don't know why.

page_test 30020 39.6069 67331.78 System Allocations & Pages/second
page_test 10000 41.1 69870.00 System Allocations & Pages/second

    2.5's page allocator is faster - the per-cpu-pages code
    presumably.

brk_test 30030 31.6017 537229.44 System Memory Allocations/second
brk_test 10010 32.4675 551948.05 System Memory Allocations/second

    Ditto

jmp_test 30000 3311.6 3311600.00 Non-local gotos/second
jmp_test 10000 3249.1 3249100.00 Non-local gotos/second

signal_test 30000 122 122000.00 Signal Traps/second
signal_test 10000 91.7 91700.00 Signal Traps/second

    Signal delivery is a lot slower in 2.5.  I do not know why,

exec_test 30000 38.3 191.50 Program Loads/second
exec_test 10020 37.0259 185.13 Program Loads/second

    Possibly rmap overhead.

fork_test 30010 15.3282 1532.82 Task Creations/second
fork_test 10060 13.5189 1351.89 Task Creations/second

    Possibly rmap overhead

link_test 30000 472.5 29767.50 Link/Unlink Pairs/second
link_test 10010 568.332 35804.90 Link/Unlink Pairs/second

    Again, VFS operations got a lot quicker.  Reason unknown. 
    (This kernel has dcache-rcu).

disk_rr 30050 10.3494 52989.02 Random Disk Reads (K)/second
disk_rr 10080 10.7143 54857.14 Random Disk Reads (K)/second

    2.5's IO paths are more efficient.

disk_rw 30060 9.61411 49224.22 Random Disk Writes (K)/second
disk_rw 10080 9.92063 50793.65 Random Disk Writes (K)/second

    Ditto.

disk_rd 30020 31.9121 163389.74 Sequential Disk Reads (K)/second
disk_rd 10020 31.3373 160447.11 Sequential Disk Reads (K)/second

disk_wrt 30040 17.8096 91185.09 Sequential Disk Writes (K)/second
disk_wrt 10030 18.345 93926.22 Sequential Disk Writes (K)/second

disk_cp 30080 11.2699 57702.13 Disk Copies (K)/second
disk_cp 10010 11.1888 57286.71 Disk Copies (K)/second

sync_disk_rw 33490 0.089579 229.32 Sync Random Disk Writes (K)/second
sync_disk_rw 11120 0.0899281 230.22 Sync Random Disk Writes (K)/second

sync_disk_wrt 53610 0.0373065 95.50 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 24700 0.0404858 103.64 Sync Sequential Disk Writes (K)/second

sync_disk_cp 53400 0.0374532 95.88 Sync Disk Copies (K)/second
sync_disk_cp 24940 0.0400962 102.65 Sync Disk Copies (K)/second

disk_src 30000 317.567 23817.50 Directory Searches/second
disk_src 10000 326.2 24465.00 Directory Searches/second

    VFS is faster here too.

div_double 30010 18.8604 56581.14 Thousand Double Precision Divides/second
div_double 10050 18.5075 55522.39 Thousand Double Precision Divides/second

div_float 30010 18.8604 56581.14 Thousand Single Precision Divides/second
div_float 10040 18.5259 55577.69 Thousand Single Precision Divides/second

div_long 30020 15.4231 13880.75 Thousand Long Integer Divides/second
div_long 10030 15.1545 13639.08 Thousand Long Integer Divides/second

div_int 30010 15.4282 13885.37 Thousand Integer Divides/second
div_int 10030 15.1545 13639.08 Thousand Integer Divides/second

div_short 30020 15.4231 13880.75 Thousand Short Integer Divides/second
div_short 10030 15.1545 13639.08 Thousand Short Integer Divides/second

fun_cal 30010 46.851 23987737.42 Function Calls (no arguments)/second
fun_cal 10010 47.0529 24091108.89 Function Calls (no arguments)/second

fun_cal1 30010 55.7148 28525958.01 Function Calls (1 argument)/second
fun_cal1 10000 55.7 28518400.00 Function Calls (1 argument)/second

fun_cal2 30000 75.8667 38843733.33 Function Calls (2 arguments)/second
fun_cal2 10000 74.5 38144000.00 Function Calls (2 arguments)/second

fun_cal15 30030 27.0729 13861338.66 Function Calls (15 arguments)/second
fun_cal15 10010 26.5734 13605594.41 Function Calls (15 arguments)/second

sieve 30190 1.02683 5.13 Integer Sieves/second
sieve 10840 1.01476 5.07 Integer Sieves/second

mul_double 30020 16.6556 199866.76 Thousand Double Precision Multiplies/second
mul_double 10030 16.3509 196211.37 Thousand Double Precision Multiplies/second

mul_float 30010 16.6611 199933.36 Thousand Single Precision Multiplies/second
mul_float 10020 16.3673 196407.19 Thousand Single Precision Multiplies/second

mul_long 30000 737.667 177040.00 Thousand Long Integer Multiplies/second
mul_long 10000 722.2 173328.00 Thousand Long Integer Multiplies/second

mul_int 30000 735.833 176600.00 Thousand Integer Multiplies/second
mul_int 10000 723.8 173712.00 Thousand Integer Multiplies/second

mul_short 30000 590.4 177120.00 Thousand Short Integer Multiplies/second
mul_short 10010 577.023 173106.89 Thousand Short Integer Multiplies/second

num_rtns_1 30000 320.433 32043.33 Numeric Functions/second
num_rtns_1 10000 314.9 31490.00 Numeric Functions/second

trig_rtns 30020 22.0187 220186.54 Trigonometric Functions/second
trig_rtns 10040 21.9124 219123.51 Trigonometric Functions/second

matrix_rtns 30000 5946.77 594676.67 Point Transformations/second
matrix_rtns 10000 5916.4 591640.00 Point Transformations/second

array_rtns 30090 7.24493 144.90 Linear Systems Solved/second
array_rtns 10000 7.2 144.00 Linear Systems Solved/second

string_rtns 30030 8.25841 825.84 String Manipulations/second
string_rtns 10040 8.06773 806.77 String Manipulations/second

mem_rtns_1 30050 12.0466 361397.67 Dynamic Memory Operations/second
mem_rtns_1 10080 12.1032 363095.24 Dynamic Memory Operations/second

mem_rtns_2 30000 1332.43 133243.33 Block Memory Operations/second
mem_rtns_2 10000 1287.1 128710.00 Block Memory Operations/second

sort_rtns_1 30000 21.6333 216.33 Sort Operations/second
sort_rtns_1 10040 21.2151 212.15 Sort Operations/second

misc_rtns_1 30000 230.467 2304.67 Auxiliary Loops/second
misc_rtns_1 10000 239 2390.00 Auxiliary Loops/second

dir_rtns_1 30000 101.967 1019666.67 Directory Operations/second
dir_rtns_1 10000 81.5 815000.00 Directory Operations/second

    2.5 VFS is slower here.  I don't know why.

shell_rtns_1 30000 47.9333 47.93 Shell Scripts/second
shell_rtns_1 10010 46.7532 46.75 Shell Scripts/second

shell_rtns_2 30010 47.9174 47.92 Shell Scripts/second
shell_rtns_2 10010 46.7532 46.75 Shell Scripts/second

shell_rtns_3 30000 47.8667 47.87 Shell Scripts/second
shell_rtns_3 10010 46.7532 46.75 Shell Scripts/second

    rmap?

series_1 30000 27653.8 2765376.67 Series Evaluations/second
series_1 10000 26897 2689700.00 Series Evaluations/second

shared_memory 30000 1499.8 149980.00 Shared Memory Operations/second
shared_memory 10000 1355 135500.00 Shared Memory Operations/second

    Reason unknown.

tcp_test 30000 341.667 30750.00 TCP/IP Messages/second
tcp_test 10010 296.503 26685.31 TCP/IP Messages/second

    networking to localhost is really unrepeatable.  I tend to
    ignore such results.  Although 2.5 does seem to be consistently
    slower.

udp_test 30000 635.367 63536.67 UDP/IP DataGrams/second
udp_test 10000 619.7 61970.00 UDP/IP DataGrams/second

fifo_test 30000 2008.63 200863.33 FIFO Messages/second
fifo_test 10000 1970.8 197080.00 FIFO Messages/second

stream_pipe 30000 1362.77 136276.67 Stream Pipe Messages/second
stream_pipe 10000 1381.5 138150.00 Stream Pipe Messages/second

dgram_pipe 30000 1315.1 131510.00 DataGram Pipe Messages/second
dgram_pipe 10000 1353.1 135310.00 DataGram Pipe Messages/second

pipe_cpy 30000 2164.77 216476.67 Pipe Messages/second
pipe_cpy 10000 2291.6 229160.00 Pipe Messages/second

    The pipe code has had some work.  Although these tests also
    tend to show very high variation between runs, and between reboots.

ram_copy 30000 17630.1 441104268.00 Memory to Memory Copy/second
ram_copy 10000 17245 431469900.00 Memory to Memory Copy/second
