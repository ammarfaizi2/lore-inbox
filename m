Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314557AbSEQFQi>; Fri, 17 May 2002 01:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315423AbSEQFQh>; Fri, 17 May 2002 01:16:37 -0400
Received: from [210.176.202.14] ([210.176.202.14]:50829 "EHLO
	mail.shaolinmicro.com") by vger.kernel.org with ESMTP
	id <S314557AbSEQFQg>; Fri, 17 May 2002 01:16:36 -0400
Message-ID: <3CE49230.40607@shaolinmicro.com>
Date: Fri, 17 May 2002 13:16:32 +0800
From: David Chow <davidchow@shaolinmicro.com>
Organization: Shaolin Microsystems Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020501
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, deanna_bonds@adaptec.com
Subject: complain about dpt_2o driver and CPU time
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Deanna and others,

I am using the ASR2100 RAID card and running 2.4.17 Linux . It seems the 
card is very slow in RAID5 computation. I use 5x18GB 10,000rpm seagate 
drives. The card orginal comes with a 32MB ECC SD RAM as cache buffer. I 
feel that the card is very slow, the test with Bonnie shows 1810KB/sec 
with CPU load less than 2%. This shows the CPU time is idle, but the 
load average go up to around 13-14 . This means the dpt_i2o driver is 
probably not written very good in releasing the cpu time (call to 
schedule()) on blocking calls, probably in some IO waiting routines(I am 
not sure), or it is holding some big locks in a slow place. The CPU is 
sitting there doing nothing, but this behaviour always block my NFS 
clients ("server not responding, still trying") and the machine looks 
like dead not even response to a console keyboard input. Can you tell me 
about what is going on or who else is suffering from the same result? I 
would like to do some improvement of the driver, or the card is really 
that slow? My 10year old SCSI drive (no raid) runs 2200Kb/sec and is 
even faster than this Ultra-160 SCSI i960 RAID with 32MB cache. If this 
is the case, I will just throw it away and use my onboard Ultra-160 
connector with software RAID which runs faster(at least). This is almost 
unusable for even small workgroup server.

regards,
David

