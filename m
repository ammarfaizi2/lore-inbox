Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbSLJWWj>; Tue, 10 Dec 2002 17:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbSLJWWj>; Tue, 10 Dec 2002 17:22:39 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:16535 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S266859AbSLJWVR>; Tue, 10 Dec 2002 17:21:17 -0500
Message-ID: <20021210221023.16603.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Date: Wed, 11 Dec 2002 06:10:23 +0800
Subject: [BENCHMARK] AIM9 results
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
file system is reiserfs.

2.4.19
2.5.50
2.5.51

add_double 10030 23.9282       430707.88 Thousand Double Precision Additions/second
add_double 10040 23.7052       426693.23 Thousand Double Precision Additions/second
add_double 10030 23.7288       427118.64 Thousand Double Precision Additions/second

add_float 10000 35.9       430800.00 Thousand Single Precision Additions/second
add_float 10010 35.5644       426773.23 Thousand Single Precision Additions/second
add_float 10010 35.5644       426773.23 Thousand Single Precision Additions/second

add_long 10010 22.1778      1330669.33 Thousand Long Integer Additions/second
add_long 10020 21.9561      1317365.27 Thousand Long Integer Additions/second
add_long 10020 21.9561      1317365.27 Thousand Long Integer Additions/second

add_int 10020 22.0559      1323353.29 Thousand Integer Additions/second
add_int 10010 21.8781      1312687.31 Thousand Integer Additions/second
add_int 10020 21.8563      1311377.25 Thousand Integer Additions/second

add_short 10000 55.4      1329600.00 Thousand Short Integer Additions/second
add_short 10010 54.8452      1316283.72 Thousand Short Integer Additions/second
add_short 10000 54.9      1317600.00 Thousand Short Integer Additions/second

creat-clo 10040 19.4223        19422.31 File Creations and Closes/second
creat-clo 10040 17.4303        17430.28 File Creations and Closes/second
creat-clo 10010 87.2128        87212.79 File Creations and Closes/second
^^^^Big change here!

page_test 10000 123.9       210630.00 System Allocations & Pages/second
page_test 10000 104.8       178160.00 System Allocations & Pages/second
page_test 10000 105.7       179690.00 System Allocations & Pages/second
^^^ still slower than 2.4.19

brk_test 10010 48.951       832167.83 System Memory Allocations/second
brk_test 10000 44.5       756500.00 System Memory Allocations/second
brk_test 10020 44.6108       758383.23 System Memory Allocations/second
^^^ still slower than 2.4.19

jmp_test 10000 4313.7      4313700.00 Non-local gotos/second
jmp_test 10000 4272.6      4272600.00 Non-local gotos/second
jmp_test 10000 4273.2      4273200.00 Non-local gotos/second

signal_test 10000 166.1       166100.00 Signal Traps/second
signal_test 10000 125.5       125500.00 Signal Traps/second
signal_test 10000 157.4       157400.00 Signal Traps/second
^^^2.5.51 is better than 2.5.50 but 2.4.19 is faster

exec_test 10000 13.8           69.00 Program Loads/second
exec_test 10040 12.9482           64.74 Program Loads/second
exec_test 10020 12.9741           64.87 Program Loads/second
^^^2.5.* is slower than 2.4.19

fork_test 10000 44.8         4480.00 Task Creations/second
fork_test 10010 25.7742         2577.42 Task Creations/second
fork_test 10020 23.9521         2395.21 Task Creations/second
^^^ Very slow here

link_test 10000 155.3         9783.90 Link/Unlink Pairs/second
link_test 10010 141.658         8924.48 Link/Unlink Pairs/second
link_test 10000 147.7         9305.10 Link/Unlink Pairs/second
^^^ I don't know the meaning of this test, but 2.5.* is slower than 2.4.19

disk_rr 10050 6.96517        35661.69 Random Disk Reads (K)/second
disk_rr 10120 7.31225        37438.74 Random Disk Reads (K)/second
disk_rr 10110 7.51731        38488.63 Random Disk Reads (K)/second

disk_rw 10060 5.666        29009.94 Random Disk Writes (K)/second
disk_rw 10120 6.62055        33897.23 Random Disk Writes (K)/second
disk_rw 10000 6.8        34816.00 Random Disk Writes (K)/second

disk_rd 10010 38.1618       195388.61 Sequential Disk Reads (K)/second
disk_rd 10020 38.024       194682.63 Sequential Disk Reads (K)/second
disk_rd 10020 38.024       194682.63 Sequential Disk Reads (K)/second

disk_wrt 10100 8.51485        43596.04 Sequential Disk Writes (K)/second
disk_wrt 10020 9.08184        46499.00 Sequential Disk Writes (K)/second
disk_wrt 10070 9.43396        48301.89 Sequential Disk Writes (K)/second

disk_cp 10120 7.31225        37438.74 Disk Copies (K)/second
disk_cp 10010 7.49251        38361.64 Disk Copies (K)/second
disk_cp 10010 7.69231        39384.62 Disk Copies (K)/second

sync_disk_rw 16020 0.062422          159.80 Sync Random Disk Writes (K)/second
sync_disk_rw 14500 0.0689655          176.55 Sync Random Disk Writes (K)/second
sync_disk_rw 18790 0.0532198          136.24 Sync Random Disk Writes (K)/second

sync_disk_wrt 11220 0.0891266          228.16 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10240 0.0976562          250.00 Sync Sequential Disk Writes (K)/second
sync_disk_wrt 10150 0.0985222          252.22 Sync Sequential Disk Writes (K)/second

sync_disk_cp 10870 0.0919963          235.51 Sync Disk Copies (K)/second
sync_disk_cp 19900 0.100503          257.29 Sync Disk Copies (K)/second
sync_disk_cp 19580 0.102145          261.49 Sync Disk Copies (K)/second

disk_src 10000 118.2         8865.00 Directory Searches/second
disk_src 10010 109.191         8189.31 Directory Searches/second
disk_src 10010 110.889         8316.68 Directory Searches/second

div_double 10000 24.4        73200.00 Thousand Double Precision Divides/second
div_double 10020 24.1517        72455.09 Thousand Double Precision Divides/second
div_double 10020 24.1517        72455.09 Thousand Double Precision Divides/second

div_float 10010 24.3756        73126.87 Thousand Single Precision Divides/second
div_float 10020 24.1517        72455.09 Thousand Single Precision Divides/second
div_float 10010 24.1758        72527.47 Thousand Single Precision Divides/second

div_long 10020 19.9601        17964.07 Thousand Long Integer Divides/second
div_long 10010 19.7802        17802.20 Thousand Long Integer Divides/second
div_long 10020 19.7605        17784.43 Thousand Long Integer Divides/second

div_int 10020 19.9601        17964.07 Thousand Integer Divides/second
div_int 10020 19.7605        17784.43 Thousand Integer Divides/second
div_int 10010 19.7802        17802.20 Thousand Integer Divides/second

div_short 10030 19.9402        17946.16 Thousand Short Integer Divides/second
div_short 10020 19.7605        17784.43 Thousand Short Integer Divides/second
div_short 10020 19.7605        17784.43 Thousand Short Integer Divides/second

fun_cal 10000 62.5     32000000.00 Function Calls (no arguments)/second
fun_cal 10000 61.9     31692800.00 Function Calls (no arguments)/second
fun_cal 10000 61.9     31692800.00 Function Calls (no arguments)/second

fun_cal1 10000 170.4     87244800.00 Function Calls (1 argument)/second
fun_cal1 10000 169     86528000.00 Function Calls (1 argument)/second
fun_cal1 10010 168.831     86441558.44 Function Calls (1 argument)/second

fun_cal2 10000 112.5     57600000.00 Function Calls (2 arguments)/second
fun_cal2 10010 111.389     57030969.03 Function Calls (2 arguments)/second
fun_cal2 10000 111.5     57088000.00 Function Calls (2 arguments)/second

fun_cal15 10010 34.0659     17441758.24 Function Calls (15 arguments)/second
fun_cal15 10010 33.7662     17288311.69 Function Calls (15 arguments)/second
fun_cal15 10010 33.7662     17288311.69 Function Calls (15 arguments)/second

sieve 10450 0.861244            4.31 Integer Sieves/second
sieve 10620 0.847458            4.24 Integer Sieves/second
sieve 10600 0.849057            4.25 Integer Sieves/second

mul_double 10020 21.5569       258682.63 Thousand Double Precision Multiplies/second
mul_double 10030 21.336       256031.90 Thousand Double Precision Multiplies/second
mul_double 10020 21.3573       256287.43 Thousand Double Precision Multiplies/second

mul_float 10030 21.5354       258424.73 Thousand Single Precision Multiplies/second
mul_float 10030 21.336       256031.90 Thousand Single Precision Multiplies/second
mul_float 10030 21.336       256031.90 Thousand Single Precision Multiplies/second

mul_long 10000 947.7       227448.00 Thousand Long Integer Multiplies/second
mul_long 10000 939.6       225504.00 Thousand Long Integer Multiplies/second
mul_long 10000 939.6       225504.00 Thousand Long Integer Multiplies/second

mul_int 10000 951.9       228456.00 Thousand Integer Multiplies/second
mul_int 10000 941.2       225888.00 Thousand Integer Multiplies/second
mul_int 10000 943.2       226368.00 Thousand Integer Multiplies/second

mul_short 10000 759.1       227730.00 Thousand Short Integer Multiplies/second
mul_short 10000 753.3       225990.00 Thousand Short Integer Multiplies/second
mul_short 10000 753.4       226020.00 Thousand Short Integer Multiplies/second

num_rtns_1 10000 467.2        46720.00 Numeric Functions/second
num_rtns_1 10000 463.8        46380.00 Numeric Functions/second
num_rtns_1 10000 463.8        46380.00 Numeric Functions/second

trig_rtns 10010 28.6713       286713.29 Trigonometric Functions/second
trig_rtns 10020 28.3433       283433.13 Trigonometric Functions/second
trig_rtns 10020 28.3433       283433.13 Trigonometric Functions/second

matrix_rtns 10000 5964.3       596430.00 Point Transformations/second
matrix_rtns 10000 5904.9       590490.00 Point Transformations/second
matrix_rtns 10000 5906.8       590680.00 Point Transformations/second

array_rtns 10010 13.6863          273.73 Linear Systems Solved/second
array_rtns 10050 13.5323          270.65 Linear Systems Solved/second
array_rtns 10010 13.2867          265.73 Linear Systems Solved/second

string_rtns 10060 9.04573          904.57 String Manipulations/second
string_rtns 10050 8.95522          895.52 String Manipulations/second
string_rtns 10050 8.95522          895.52 String Manipulations/second

mem_rtns_1 10000 27.7       831000.00 Dynamic Memory Operations/second
mem_rtns_1 10020 23.4531       703592.81 Dynamic Memory Operations/second
mem_rtns_1 10010 24.975       749250.75 Dynamic Memory Operations/second
^^^ 2.5.51 is faster than 2.5.50 but is not fast as 2.4.19

mem_rtns_2 10000 1632.5       163250.00 Block Memory Operations/second
mem_rtns_2 10000 1631.9       163190.00 Block Memory Operations/second
mem_rtns_2 10000 1631.8       163180.00 Block Memory Operations/second

sort_rtns_1 10020 33.6327          336.33 Sort Operations/second
sort_rtns_1 10010 33.0669          330.67 Sort Operations/second
sort_rtns_1 10010 33.0669          330.67 Sort Operations/second

misc_rtns_1 10000 782.2         7822.00 Auxiliary Loops/second
misc_rtns_1 10000 713.8         7138.00 Auxiliary Loops/second
misc_rtns_1 10000 738         7380.00 Auxiliary Loops/second
^^^ 2.5.* is still slow

dir_rtns_1 10000 85.8       858000.00 Directory Operations/second
dir_rtns_1 10010 73.7263       737262.74 Directory Operations/second
dir_rtns_1 10000 96.9       969000.00 Directory Operations/second
^^^ Good result here for 2.5.51

shell_rtns_1 10020 25.9481           25.95 Shell Scripts/second
shell_rtns_1 10000 23.9           23.90 Shell Scripts/second
shell_rtns_1 10030 24.1276           24.13 Shell Scripts/second

shell_rtns_2 10010 26.0739           26.07 Shell Scripts/second
shell_rtns_2 10010 23.976           23.98 Shell Scripts/second
shell_rtns_2 10000 24.1           24.10 Shell Scripts/second

shell_rtns_3 10010 26.0739           26.07 Shell Scripts/second
shell_rtns_3 10030 23.9282           23.93 Shell Scripts/second
shell_rtns_3 10000 24.1           24.10 Shell Scripts/second

series_1 10000 31924.9      3192490.00 Series Evaluations/second
series_1 10000 31644.6      3164460.00 Series Evaluations/second
series_1 10000 31651.5      3165150.00 Series Evaluations/second

shared_memory 10000 2227.4       222740.00 Shared Memory Operations/second
shared_memory 10000 1935.9       193590.00 Shared Memory Operations/second
shared_memory 10000 1987.5       198750.00 Shared Memory Operations/second
^^^ Slow

tcp_test 10000 661.7        59553.00 TCP/IP Messages/second
tcp_test 10000 537.6        48384.00 TCP/IP Messages/second
tcp_test 10000 558.7        50283.00 TCP/IP Messages/second
^^^Debug I guess

udp_test 10000 1182.7       118270.00 UDP/IP DataGrams/second
udp_test 10000 994.6        99460.00 UDP/IP DataGrams/second
udp_test 10000 972.3        97230.00 UDP/IP DataGrams/second
^^^Debug I guess

fifo_test 10000 1207       120700.00 FIFO Messages/second
fifo_test 10000 991.2        99120.00 FIFO Messages/second
fifo_test 10000 1052.3       105230.00 FIFO Messages/second
^^^ Slow

stream_pipe 10000 2418.6       241860.00 Stream Pipe Messages/second
stream_pipe 10000 2161.5       216150.00 Stream Pipe Messages/second
stream_pipe 10000 2281.5       228150.00 Stream Pipe Messages/second
^^^ 2.5.51 is better than 2.5.50, but 2.4.19 is the winner

dgram_pipe 10000 2357.8       235780.00 DataGram Pipe Messages/second
dgram_pipe 10000 2132.4       213240.00 DataGram Pipe Messages/second
dgram_pipe 10000 2112.2       211220.00 DataGram Pipe Messages/second
^^^ Slow

pipe_cpy 10000 3918       391800.00 Pipe Messages/second
pipe_cpy 10000 3137.1       313710.00 Pipe Messages/second
pipe_cpy 10000 3139       313900.00 Pipe Messages/second
^^^ Slow

ram_copy 10000 19338.7    483854274.00 Memory to Memory Copy/second
ram_copy 10000 19158.1    479335662.00 Memory to Memory Copy/second
ram_copy 10000 19160.9    479405718.00 Memory to Memory Copy/second


-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
