Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290011AbSAKQyd>; Fri, 11 Jan 2002 11:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290018AbSAKQyZ>; Fri, 11 Jan 2002 11:54:25 -0500
Received: from iwd_mail.intware.com ([216.94.87.36]:26117 "EHLO
	iwd_mail.intware.com") by vger.kernel.org with ESMTP
	id <S290011AbSAKQyI>; Fri, 11 Jan 2002 11:54:08 -0500
Message-ID: <F7EB06D3ED62D311A15600104B6D909F44205C@IWD_MAIL>
From: Dimitrie Paun <dimi@intelliware.ca>
To: "'Rik van Riel'" <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Severe VM problem on stock RH7.2 while running Java
Date: Fri, 11 Jan 2002 11:33:36 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

We are having a sever VM problem while running 
Tomcat (Java proc) on a stock RedHat 7.2, with 
a 2.4.7-13enterprise kernel.

What happens is that after a while the box stops
responding, without oopsing. It can still be pinged,
but not more than that. VT switching still works,
alas slowly. You can still type a login name, but
chars are echoed to the screen with a .5-1s delay.
After you press <ENTER>, nothing happens.

It looks like the system spends 100% of it's time
in the kernel, doing some VM-related thing.

Here are the details for the box:
  -- RAM:   768MB
  -- Swap:  512MB
  -- Java:  maximum heap of 512MB


We've capture the vmstat of one of this cases.
In this particular case the OOM killer managed to
finally kill the offending java process, and the
system recovered:

Jan  9 21:20:00 vangogh CROND[6256]: (root) CMD (/usr/lib/sa/sa1 1 1)
Jan  9 21:20:23 vangogh timed[1111]: measure: renoir did not respond
Jan  9 21:24:20 vangogh timed[1111]: measure: renoir did not respond
Jan  9 21:27:28 vangogh kernel: Out of Memory: Killed process 6276 (java).
Jan  9 21:28:18 vangogh kernel: Out of Memory: Killed process 6300 (java).
Jan  9 21:28:25 vangogh kernel: Out of Memory: Killed process 6301 (java).
Jan  9 21:28:31 vangogh kernel: Out of Memory: Killed process 6302 (java).
Jan  9 21:28:27 vangogh timed[1111]: measure: renoir did not respond
Jan  9 21:28:43 vangogh kernel: Out of Memory: Killed process 6303 (java).
Jan  9 21:29:30 vangogh kernel: Out of Memory: Killed process 6304 (java).
Jan  9 21:29:55 vangogh kernel: Out of Memory: Killed process 6305 (java).
Jan  9 21:29:59 vangogh kernel: Out of Memory: Killed process 6306 (java).
Jan  9 21:29:59 vangogh kernel: Out of Memory: Killed process 6307 (java).
Jan  9 21:30:00 vangogh CROND[6571]: (root) CMD (/usr/lib/sa/sa1 1 1)

Here's the #vmstat 2 output:

[cellbucksdev@vangogh cellbucksdev]$ vmstat 2
   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 4  0  0      0  51836  71572 170748   0   0     6    21  112   174   3   0
97
 3  0  0      0  46868  71572 170764   0   0     0     0  198   605  33   3
64
 3  0  0  12576   3336  65416 159800   0   0     0    98  254   693  83  17
0
 6  0  0  12576   3512  51752 126056   0   0    10     0  194  1802  85  15
0
 2  0  0  12576   3056  44560 104992   0   0     0    76  118  2653  92   8
0
 3  0  0  12576   9368  39844  44216   0 1946     8  2024  162  2526  81  19
0
 3  0  0  59976   4120  28016  38944   0 2618     2  2632  152  2497  88  12
0
 3  0  0 115864   2708   8416  30768   0   0   216    42  148  2224  88  10
2
 4  2  1 248504   1760    440  28792 156 7032   522  7054  218  1365  56  11
33
 3  0  1 267764   2548    496  28448 310 10060   332 10092  343  1556  16
9  75
 2  0  1 296652   1952    496  27352 198 13674   204 13698  293  4586  57
8  35
 2  2  0 302764   2512    552  27468 162 14422   286 14424  293  1105  14
6  79
 4  0  2 318472   2544    584  27424 104 12164   154 12196  311  2506  40
15  45
 6  1  0 342588   2136    584  26772 182 13660   214 13662  321  2767  39
15  46
 1  1  1 326780   2972    600  26660 6884 6618  6884  6692  348  3148  63
9  28
 1  1  1 321488   2928    600  26396 6574 8378  6574  8392  351  3573  67
7  26
 3  0  0 316504   3012    580  26184 6012 7186  6016  7204  372  3522  73
8  18
 3  0  0 287996   3052    596  24228 6490 4234  6490  4308  327  3203  66
10  25
 1  2  1 281788   3056    604  25888 2838 4176  3702  4188  301  2480  49
3  48
 6  0  0 276332   3004    620  24840 4152 5020  4152  5062  299  2684  68
7  25
 2  2  1 272396   3392    556  24960 5602 5884  5668  5918  320  2754  55
6  39
 6  0  0 272680   3056    556  23884 3314 4948  3318  4964  359  3224  69
9  22

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 8  1  0 278040   2556    572  23876 3502 6510  3512  6574  298  2910  54
8  38
 5  0  0 287368   1812    588  23700 432 6996   500  7010  297  2433  57   6
36
 5  0  0 299720   3024    596  20188 212 6328   212  6370  210  2332  60   6
34
 3  1  0 321520   2552    600  16920 146 9274   232  9312  285  1735  35   8
57
 7  0  1 357440   2592    584  12600 206 5920   206  5922  256  2550  58   6
35
 0  2  1 414292   1920    584  12356 210 4758   210  4852  269  1826  42  16
42
 3  0  0 412600   1868    584  12364 488 7900   488  7900  280   984  29   4
67
 2  0  4 419532   2048    596  11500 548 5690   548  5738  262  2542  61   8
31
 0  2  1 418720   2860    592  11168 434 5178   434  5204  217  1169  30   3
67
 5  1  1 417344   2744    612   9564 666 6160   748  6172  307  1716  39   8
53
 2  0  0 440744   2040    628   9492 374 8888   386  8916  247  1511  45   8
47
 4  0  0 471220   2548    628   8916 392 6844   414  6850  237  2269  49   9
42
 1  2  1 474212   2292    612   8684 3364 8092  3390  8114  344  2944  51
8  40
 0  2  1 484720   2048    612   8132 2348 6076  2356  6144  316  1174  16
4  80
 7  0  1 530088   2824    524   6420 568 13354   598 13366  510  1007   6
9  85
 1  1  1 530100   1804    548   6352 426 7682   686  7754  268  1622  24  27
50
 0  2  1 523096   2356    564   6952 662 8984  1030  8984  297   586   2  15
82
 1  2  3 514984   2616    580   6844 246 8388   246  8402  414   417   3  11
86
 2  1  0 505276   2336    580   6896 266 11302   296 11304  326   661   0
5  95
 5  2  1 528160   3056    552   6728 490 9606   490  9606  355   928   4   9
87
 2  2  1 530060   1528    548   6220 1882 5602  1884  5602  383   832   3
3  93
 7  0  1 530096   2048    528   6048 178 10928   178 10928  379   561   0
10  90

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy
id
 9  0  0 530104   2556    516   5684 206 7676   206  7676  310   377   1  30
69
 7  0  0 529960   2548    500   4660 298 8506   298  8512  328   396   2  18
80
 4  0  0 530096   2536    476   4084 240 7226   240  7226  360   458   0  18
81
 2  4  1 530072   1776    300    784 274 5228   290  5234  367   585   0  39
61
20  2  1 530104   1844    300    564 1806 472 15460   472 1702  7418   0  99
1
 6 15  2 530100   1564    308    972 7432 382 88178   518 9773 38300   0 100
0
15  7  1 530104   1824    304    540 3618  66 70724   152 6303 31206   0 100
0
 5  3  1 128004 484600    704   7056 1440   0  9964   100  799  3279   0  70
30
 1  0  0 127996 480132    940   8580 1426   0  2294    36  255   576   1   1
97
 1  0  0 117396 475396    964  11104 4026   0  5300     0  221   560   1   3
96
 1  0  0 117380 461336    996  11104 6876   0  6880    80  348   686   9   0
91
 1  0  0 117380 446864    996  11168 7028   0  7060     0 1106   873  24   2
74
 1  0  0  35064 469940   1016  11432 4394   0  4530    20  716   726  16   3
81
 0  0  0  31768 470416   1016  11432 292   0   292     0  114   143   0   0
100
 0  0  0  31768 470416   1016  11432   0   0     0     0  103   113   0   0
100
 0  0  0  31768 470416   1016  11432   0   0     0     0  103   113   0   0
100
 0  0  0  31768 470416   1040  11432   0   0     4    18  108   121   0   0
100
 0  0  0  31768 470416   1048  11432   0   0     0     8  105   116   0   0
100
 0  0  0  31768 470416   1048  11432   0   0     0     0  104   113   0   0
100
 0  0  0  31768 470416   1048  11432   0   0     0     0  107   113   0   0
100
 0  0  0  31768 470416   1048  11432   0   0     0     0  103   112   0   0
100
 0  0  0  31768 470416   1048  11432   0   0     0     0  104   114   0   0
100
 0  0  0  31768 470416   1048  11432   0   0     0     0  104   112   0   0
100

I appologise if the output gets mangled by my mailer (I hope not!). 
If so, I can resend it as an attachment.

Any help with this problem would be greatly appreciated as this 
particular application is one of our most important projects.

TIA,
Dimi.
