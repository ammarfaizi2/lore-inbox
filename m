Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVHaU5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVHaU5M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbVHaU5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:57:12 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:31113 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S964953AbVHaU5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:57:11 -0400
Date: Wed, 31 Aug 2005 20:56:50 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <20050831142413.GB24383@gallifrey>
Message-ID: <Pine.LNX.4.61.0508312039220.1081@diagnostix.dwd.de>
References: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
 <20050829202529.GA32214@midnight.suse.cz> <Pine.LNX.4.61.0508301919250.25574@diagnostix.dwd.de>
 <20050831071126.GA7502@midnight.ucw.cz> <20050831072644.GF4018@suse.de>
 <Pine.LNX.4.61.0508311029170.16574@diagnostix.dwd.de> <20050831120714.GT4018@suse.de>
 <Pine.LNX.4.61.0508311339140.16574@diagnostix.dwd.de> <20050831142413.GB24383@gallifrey>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Aug 2005, Dr. David Alan Gilbert wrote:

> * Holger Kiehl (Holger.Kiehl@dwd.de) wrote:
>> On Wed, 31 Aug 2005, Jens Axboe wrote:
>>
>> Full vmstat session can be found under:
>
> Have you got iostat?  iostat -x 10 might be interesting to see
> for a period while it is going.
>
The following is the result from all 8 disks at the same time with the command
dd if=/dev/sd?1 of=/dev/null bs=256k count=78125

There is however one difference, here I had set
/sys/block/sd?/queue/nr_requests to 4096.

avg-cpu:  %user   %nice    %sys %iowait   %idle
            0.10    0.00   21.85   58.55   19.50

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
sda          0.00   0.00  0.00  0.30    0.00    2.40     0.00     1.20     8.00     0.00    1.00   1.00   0.03
sdb          0.70   0.00  0.10  0.30    6.40    2.40     3.20     1.20    22.00     0.00    4.25   4.25   0.17
sdc        8276.90   0.00 267.10  0.00 68352.00    0.00 34176.00     0.00   255.90     1.95    7.29   3.74 100.02
sdd        9098.50   0.00 293.50  0.00 75136.00    0.00 37568.00     0.00   256.00     1.93    6.59   3.41 100.03
sde        10428.40   0.00 336.40  0.00 86118.40    0.00 43059.20     0.00   256.00     1.92    5.71   2.97 100.02
sdf        11314.90   0.00 365.10  0.00 93440.00    0.00 46720.00     0.00   255.93     1.92    5.26   2.74  99.98
sdg        7973.20   0.00 257.20  0.00 65843.20    0.00 32921.60     0.00   256.00     1.94    7.53   3.89 100.01
sdh        9436.30   0.00 304.70  0.00 77928.00    0.00 38964.00     0.00   255.75     1.93    6.35   3.28 100.01
sdi        10604.80   0.00 342.40  0.00 87577.60    0.00 43788.80     0.00   255.78     1.92    5.62   2.92 100.02
sdj        10914.30   0.00 352.20  0.00 90132.80    0.00 45066.40     0.00   255.91     1.91    5.43   2.84 100.00
md0          0.00   0.00  0.00  0.10    0.00    0.80     0.00     0.40     8.00     0.00    0.00   0.00   0.00
md2          0.00   0.00  0.80  0.00    6.40    0.00     3.20     0.00     8.00     0.00    0.00   0.00   0.00
md1          0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00

avg-cpu:  %user   %nice    %sys %iowait   %idle
            0.07    0.00   24.49   66.81    8.62

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
sda          0.00   0.40  0.00  1.00    0.00   11.20     0.00     5.60    11.20     0.00    1.30   0.50   0.05
sdb          0.00   0.40  0.00  1.00    0.00   11.20     0.00     5.60    11.20     0.00    1.50   0.70   0.07
sdc        8161.90   0.00 263.70  0.00 67404.80    0.00 33702.40     0.00   255.61     1.95    7.38   3.79 100.02
sdd        9157.30   0.00 295.50  0.00 75622.40    0.00 37811.20     0.00   255.91     1.93    6.53   3.38 100.00
sde        10505.60   0.00 339.20  0.00 86758.40    0.00 43379.20     0.00   255.77     1.93    5.68   2.95  99.99
sdf        11212.50   0.00 361.90  0.00 92595.20    0.00 46297.60     0.00   255.86     1.91    5.28   2.76 100.00
sdg        7988.40   0.00 258.00  0.00 65971.20    0.00 32985.60     0.00   255.70     1.93    7.49   3.88  99.98
sdh        9436.20   0.00 304.40  0.00 77924.80    0.00 38962.40     0.00   255.99     1.92    6.32   3.28  99.99
sdi        10406.10   0.00 336.30  0.00 85939.20    0.00 42969.60     0.00   255.54     1.92    5.70   2.97 100.00
sdj        11027.00   0.00 356.00  0.00 91064.00    0.00 45532.00     0.00   255.80     1.92    5.40   2.81  99.96
md0          0.00   0.00  0.00  1.00    0.00    8.00     0.00     4.00     8.00     0.00    0.00   0.00   0.00
md2          0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
md1          0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00

avg-cpu:  %user   %nice    %sys %iowait   %idle
            0.08    0.00   22.23   60.44   17.25

Device:    rrqm/s wrqm/s   r/s   w/s  rsec/s  wsec/s    rkB/s    wkB/s avgrq-sz avgqu-sz   await  svctm  %util
sda          0.00   0.00  0.00  0.30    0.00    2.40     0.00     1.20     8.00     0.00    1.00   1.00   0.03
sdb          0.00   0.00  0.00  0.30    0.00    2.40     0.00     1.20     8.00     0.00    0.67   0.67   0.02
sdc        8204.50   0.00 264.76  0.00 67754.15    0.00 33877.08     0.00   255.90     1.95    7.38   3.78 100.12
sdd        9166.47   0.00 295.90  0.00 75698.10    0.00 37849.05     0.00   255.83     1.94    6.55   3.38 100.12
sde        10534.93   0.00 339.94  0.00 86999.00    0.00 43499.50     0.00   255.92     1.93    5.67   2.95 100.12
sdf        11282.68   0.00 364.16  0.00 93174.77    0.00 46587.39     0.00   255.86     1.92    5.28   2.75 100.10
sdg        8114.61   0.00 261.76  0.00 67011.01    0.00 33505.51     0.00   256.00     1.95    7.44   3.82 100.11
sdh        9380.68   0.00 302.60  0.00 77466.27    0.00 38733.13     0.00   256.00     1.93    6.38   3.31 100.10
sdi        10507.01   0.00 339.04  0.00 86768.37    0.00 43384.18     0.00   255.92     1.93    5.69   2.95 100.12
sdj        10969.27   0.00 354.15  0.00 90586.59    0.00 45293.29     0.00   255.78     1.92    5.42   2.83 100.11
md0          0.00   0.00  0.00  0.10    0.00    0.80     0.00     0.40     8.00     0.00    0.00   0.00   0.00
md2          0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00
md1          0.00   0.00  0.00  0.00    0.00    0.00     0.00     0.00     0.00     0.00    0.00   0.00   0.00

The full output can be found at:

    ftp://ftp.dwd.de/pub/afd/linux_kernel_debug/iostat-read-256k

Holger

