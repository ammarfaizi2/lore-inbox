Return-Path: <linux-kernel-owner+w=401wt.eu-S1030319AbWLTUZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWLTUZo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbWLTUZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:25:44 -0500
Received: from mailhub.hp.com ([192.151.27.10]:40466 "EHLO mailhub.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030319AbWLTUZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:25:43 -0500
X-Greylist: delayed 1151 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 15:25:42 EST
From: "Bob Picco" <bob.picco@hp.com>
Date: Wed, 20 Dec 2006 15:06:28 -0500
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       clameter@engr.sgi.com, apw@shadowen.org, heiko.carstens@de.ibm.com,
       bob.picco@hp.com
Subject: Re: [PATCH][2.6.20-rc1-mm1] sparsemem vmem_map optimzed pfn_valid() [0/2]
Message-ID: <20061220200628.GA10271@localhost>
References: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiroyuki KAMEZAWA wrote:	[Sat Dec 16 2006, 03:31:36AM EST]
> This patch implements pfn_valid() micro optimization.
> 
> This uses ia64_pfn_valid() idea to check mem_map is valid or not instead of
> sparsemem's logic.
> 
> By this, we'll not access mem_section[] in usual ops.
> 
> I attaches my easy test result with *micro* benchmark on SMP system.
> I'm glad if you give me an advice about testing.
Sorry I was looking for AIM VII and/or reaim which are multiuser loads.
The results (2.6.20-rc1-mm1) for EXTREME, SPARSEMEM+VMEMMAP and
SPARSEMEM+VMEMMAP+your+patch are below. Note SPARSEMEM+VMEMMAP AIM VII
wasn't benchmarked to higher load limit because of my time constraints. 
The runs should be repeated more times.

Any difference between the three configurations looks insignificant and
within benchmark noise.

After tomorrow I'm on vacation until Jan 2.

bob
> 
> -Kame
> ==
> AIM Independent Resource Benchmark - Suite IX "1.1"
> 
> test on 
> CPU: Itanium2(madison) 1.3GHz x2, SMP
> Memory: memory 8G
> 2.6.20-rc1-m1 / 
>   extreme means  SPARSEMEM_VMEMMAP=n
>   vmem_map means SPARSEMEM_VMEMMAP=y + optimze pfn_valid patch.
> ==
>                 extreme	    vmem_map
> creat-clo       136322      136989  File Creations and Closes per second
> page_test       1042187     1076976 System Allocations & Pages per second
> brk_test        2678559     2727286 System Memory Allocations per second
> signal_test     309525      321052  Signal Traps per second
> exec_test       803         801     Program Loads per second
> fork_test       9354        9679    Task Creations per second
> disk_rr         103766      103970  Random Disk Reads (K) per second
> disk_rw         82978       80244   Random Disk Writes (K) per second
> disk_rd         802548      872983  Sequential Disk Reads (K) per second
> disk_wrt        130342      131408  Sequential Disk Writes (K) per second
> disk_cp         107498      107823  Disk Copies (K) per second
> sync_disk_rw    800         752     Sync Random Disk Writes (K) per second
> sync_disk_wrt   81          78      Sync Sequential Disk Writes (K) per second
> sync_disk_cp    84          78      Sync Disk Copies (K) per second
> disk_src        44417       44379   Directory Searches per second
> mem_rtns_1      3239352     3222140 Dynamic Memory Operations per second
> mem_rtns_2      1157321     1155260 Block Memory Operations per second
> misc_rtns_1     10799       10993   Auxiliary Loops per second
> dir_rtns_1      1276159     1373725 Directory Operations per second
> shell_rtns_1    175         176     Shell Scripts per second
> shell_rtns_2    174         175     Shell Scripts per second
> shell_rtns_3    175         175     Shell Scripts per second
> shared_memory   646725      628769  Shared Memory Operations per second
> tcp_test        93258       94928   TCP/IP Messages per second
> udp_test        177984      177276  UDP/IP DataGrams per second
> fifo_test       362774      385434  FIFO Messages per second
> stream_pipe     320825      325931  Stream Pipe Messages per second
> dgram_pipe      300789      303339  DataGram Pipe Messages per second
> pipe_cpy        410539      449521  Pipe Messages per second
> 

EXTREME

AIM Multiuser Benchmark - Suite VII Run Beginning

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      111.22  100       111.2215     52.33      0.88   Tue Dec 19 13:43:42 2006
  101     6896.87   96        68.2858     85.23     42.02   Tue Dec 19 13:49:31 2006
  201     7997.07   94        39.7864    146.28     83.69   Tue Dec 19 13:59:30 2006
  301     8580.37   95        28.5062    204.17    125.72   Tue Dec 19 14:13:27 2006
  401     8800.62   94        21.9467    265.19    167.80   Tue Dec 19 14:31:33 2006
  501     9445.73   91        18.8537    308.69    210.16   Tue Dec 19 14:52:38 2006
  601     9446.80   93        15.7185    370.26    252.50   Tue Dec 19 15:17:55 2006
  701     9353.27   92        13.3427    436.19    295.04   Tue Dec 19 15:47:42 2006
  918     9543.22   91        10.3957    559.85    387.02   Tue Dec 19 16:25:55 2006
 1000     9571.14   93         9.5711    608.08    421.95   Tue Dec 19 17:07:26 2006

AIM Multiuser Benchmark - Suite VII Run Beginning

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      111.43  100       111.4281     52.23      0.88   Wed Dec 20 07:16:00 2006
  101     6940.84   95        68.7212     84.69     42.08   Wed Dec 20 07:21:47 2006
  201     8206.67   94        40.8292    142.54     83.68   Wed Dec 20 07:31:31 2006
  301     8692.77   94        28.8796    201.53    125.65   Wed Dec 20 07:45:16 2006
  401     8910.40   93        22.2204    261.92    167.79   Wed Dec 20 08:03:09 2006
  500     9149.02   93        18.2980    318.07    209.55   Wed Dec 20 08:24:52 2006

REAIM Workload
Times are in seconds - Child times from tms.cstime and tms.cutime

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
1       0.01     0.00    0.00    127500.00  127500.00  0.00     0.00     100  
101     0.13     0.11    0.15    798604.65  7906.98    0.04     47.04    52   
201     0.26     0.21    0.31    804000.00  4000.00    0.08     52.22    47   
301     0.38     0.30    0.48    801618.80  2663.19    0.12     51.47    48   
401     0.51     0.42    0.63    797309.94  1988.30    0.15     51.25    48   
501     0.64     0.53    0.75    794743.39  1586.31    0.19     50.83    49   
601     0.78     0.63    0.92    790993.55  1316.13    0.23     50.64    49   
701     0.91     0.72    1.08    786600.66  1122.11    0.27     49.94    50   
801     1.04     0.86    1.21    784841.50  979.83     0.31     50.01    49   
901     1.23     0.95    1.34    746563.77  828.59     0.38     49.06    50   
Max Jobs per Minute 804000.00

REAIM Workload (without drop_caches)
Times are in seconds - Child times from tms.cstime and tms.cutime

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
1       0.00     0.00    0.00    1020000.00 1020000.00 0.00     0.00     100  
101     0.13     0.11    0.15    804843.75  7968.75    0.04     49.58    50   
201     0.26     0.22    0.30    800859.38  3984.38    0.08     50.29    49   
301     0.39     0.31    0.47    797454.55  2649.35    0.12     50.56    49   
401     0.51     0.43    0.62    795758.75  1984.44    0.16     51.25    48   
501     0.65     0.54    0.75    791052.63  1578.95    0.19     50.35    49   
601     0.78     0.62    0.92    789974.23  1314.43    0.23     50.71    49   
701     0.91     0.75    1.07    787466.96  1123.35    0.27     50.49    49   
801     1.11     0.83    1.19    736054.05  918.92     0.28     37.97    62   
901     1.18     0.96    1.34    781479.59  867.35     0.35     49.50    50   
Max Jobs per Minute 1020000.00

SPARSEMEM+VMEMMAP

AIM Multiuser Benchmark - Suite VII Run Beginning

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      111.16  100       111.1578     52.36      0.87   Wed Dec 20 10:44:28 2006
  101     6802.68   96        67.3533     86.41     42.03   Wed Dec 20 10:50:22 2006
  201     8204.25   94        40.8172    142.59     83.54   Wed Dec 20 11:00:06 2006
  301     8779.86   94        29.1690    199.53    125.39   Wed Dec 20 11:13:44 2006
  401     8980.38   94        22.3950    259.88    167.24   Wed Dec 20 11:31:29 2006
  500     9337.55   93        18.6751    311.64    209.03   Wed Dec 20 11:52:45 2006

REAIM Workload
Times are in seconds - Child times from tms.cstime and tms.cutime

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
1       0.01     0.00    0.00    145714.29  145714.29  0.00     0.00     100  
101     0.13     0.12    0.14    804843.75  7968.75    0.04     49.80    50   
201     0.26     0.22    0.30    800859.38  3984.38    0.08     50.66    49   
301     0.39     0.30    0.48    797454.55  2649.35    0.12     51.39    48   
401     0.52     0.43    0.61    794213.59  1980.58    0.16     51.43    48   
501     0.68     0.52    0.74    757066.67  1511.11    0.20     48.22    51   
601     0.78     0.61    0.93    788957.53  1312.74    0.23     50.30    49   
701     0.91     0.73    1.07    788335.17  1124.59    0.27     50.32    49   
801     1.04     0.80    1.24    784841.50  979.83     0.31     48.68    51   
901     1.18     0.94    1.37    781479.59  867.35     0.36     50.25    49   
Max Jobs per Minute 804843.75

REAIM Workload
Times are in seconds - Child times from tms.cstime and tms.cutime

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
1       0.00     0.00    0.00    510000.00  510000.00  0.00     0.00     100  
101     0.13     0.11    0.15    804843.75  7968.75    0.04     49.95    50   
201     0.26     0.22    0.29    804000.00  4000.00    0.08     50.85    49   
301     0.39     0.32    0.45    797454.55  2649.35    0.12     51.26    48   
401     0.51     0.40    0.62    797309.94  1988.30    0.15     50.84    49   
501     0.65     0.51    0.78    792279.07  1581.40    0.19     49.92    50   
601     0.78     0.64    0.90    788957.53  1312.74    0.23     50.60    49   
701     0.91     0.70    1.08    786600.66  1122.11    0.27     49.94    50   
801     1.04     0.87    1.20    784841.50  979.83     0.31     50.01    49   
901     1.18     0.90    1.39    781479.59  867.35     0.36     50.01    49   
Max Jobs per Minute 804843.75

SPARSEMEM+VMEMMAP+your+patch

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      111.02  100       111.0200     52.42      0.88   Tue Dec 19 17:24:48 2006
  101     6815.54   95        67.4806     86.25     41.74   Tue Dec 19 17:30:41 2006
  201     8465.49   95        42.1168    138.19     83.09   Tue Dec 19 17:40:07 2006
  301     8747.60   94        29.0618    200.26    125.15   Tue Dec 19 17:53:48 2006
  401     9118.91   94        22.7404    255.93    167.03   Tue Dec 19 18:11:16 2006
  501     9227.16   93        18.4175    316.00    209.36   Tue Dec 19 18:32:51 2006
  601     9673.07   94        16.0950    361.60    251.29   Tue Dec 19 18:57:32 2006
  701     9613.08   93        13.7134    424.40    293.63   Tue Dec 19 19:26:31 2006
  918     9881.59   92        10.7643    540.68    386.21   Tue Dec 19 20:03:25 2006
 1000     9686.10   92         9.6861    600.86    420.91   Tue Dec 19 20:44:27:

AIM Multiuser Benchmark - Suite VII Run Beginning

Tasks    jobs/min  jti  jobs/min/task      real       cpu
    1      111.10  100       111.1047     52.38      0.88   Wed Dec 20 08:52:20 2006
  101     6703.54   96        66.3717     87.69     41.94   Wed Dec 20 08:58:20 2006
  201     7986.37   95        39.7332    146.48     83.53   Wed Dec 20 09:08:20 2006
  301     8711.32   95        28.9413    201.10    125.41   Wed Dec 20 09:22:04 2006
  401     8690.61   94        21.6723    268.55    166.96   Wed Dec 20 09:40:24 2006
  500     9168.16   94        18.3363    317.40    209.11   Wed Dec 20 10:02:04 2006

AIM Multiuser Benchmark - Suite VII

REAIM Workload
Times are in seconds - Child times from tms.cstime and tms.cutime

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
1       0.01     0.00    0.00    127500.00  127500.00  0.00     0.00     100  
101     0.13     0.12    0.14    811181.10  8031.50    0.04     47.61    52   
201     0.26     0.20    0.32    804000.00  4000.00    0.08     48.63    51   
301     0.38     0.33    0.45    803717.28  2670.16    0.12     50.77    49   
401     0.53     0.38    0.63    773194.71  1928.17    0.16     52.07    47   
501     0.64     0.52    0.78    798468.75  1593.75    0.19     50.84    49   
601     0.77     0.60    0.95    795097.28  1322.96    0.23     50.79    49   
701     0.91     0.74    1.06    790077.35  1127.07    0.27     49.24    50   
801     1.04     0.83    1.23    785596.15  980.77     0.31     50.30    49   
901     1.17     0.93    1.38    784146.76  870.31     0.35     49.64    50   
Max Jobs per Minute 811181.10

REAIM Workload (without drop_caches)
Times are in seconds - Child times from tms.cstime and tms.cutime

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent 
1       0.00     0.00    0.00    1020000.00 1020000.00 0.00     0.00     100  
101     0.13     0.10    0.16    811181.10  8031.50    0.04     51.66    48   
201     0.25     0.18    0.33    807165.35  4015.75    0.08     51.16    48   
301     0.38     0.32    0.45    799531.25  2656.25    0.12     51.83    48   
401     0.51     0.41    0.62    797309.94  1988.30    0.15     50.72    49   
501     0.64     0.53    0.76    795981.31  1588.79    0.19     49.92    50   
601     0.78     0.62    0.93    790993.55  1316.13    0.23     49.80    50   
701     0.91     0.71    1.11    789205.30  1125.83    0.27     50.14    49   
801     1.04     0.82    1.25    787868.85  983.61     0.31     50.50    49   
901     1.17     0.95    1.36    784816.40  871.05     0.35     49.76    50   
Max Jobs per Minute 1020000.00

