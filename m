Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274322AbRITGKA>; Thu, 20 Sep 2001 02:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274323AbRITGJv>; Thu, 20 Sep 2001 02:09:51 -0400
Received: from mailc.telia.com ([194.22.190.4]:4606 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S274322AbRITGJd>;
	Thu, 20 Sep 2001 02:09:33 -0400
Message-Id: <200109200609.f8K69uQ26778@mailc.telia.com>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: [PATCH] latency-profiling
Date: Thu, 20 Sep 2001 08:05:07 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_J86Y9OB0Q4XNQ2QRF17S"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_J86Y9OB0Q4XNQ2QRF17S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I ported my old latency-profiling patch to 2.4.10-pre10 with
the reschedulable kernel patch. (I have not checked that it is
preemption safe itself...)

This patch works a little different from Robert Loves.
Since it samples the execution location at ticks.
It is possible to instrument an ordinary kernel too...
These are the results (>5 ms):

Sep 19 20:09:28 jeloin kernel: Latency  17ms PID   316 %% ifconfig
Sep 19 20:09:28 jeloin kernel: Trace: 
[mousedev:__insmod_mousedev_O/lib/modules/2.4.10-pre10/kernel/drivers+-93829/96] 
[__rdtsc_delay+20/28]
Sep 19 20:12:48 jeloin kernel: Latency  10ms PID   870 %% artsd
Sep 19 20:12:48 jeloin kernel: Trace: [console_softint+230/232] 
[__rdtsc_delay+20/28]
Sep 19 20:13:28 jeloin kernel: Latency   8ms PID   667 %% X
Sep 19 20:13:28 jeloin kernel: Trace: [__rdtsc_delay+22/28]
Sep 19 20:13:53 jeloin kernel: Latency  35ms PID   972 %% bash
Sep 19 20:13:53 jeloin kernel: Trace: [unmap_buffer+100/132] 
[kmem_cache_free+140/148] [block_flushpage+43/112]
Sep 19 20:14:19 jeloin kernel: Latency  40ms PID   979 %% bash
Sep 19 20:14:19 jeloin kernel: Trace: [__refile_buffer+95/108] 
[block_flushpage+43/112] [remove_inode_page+36/64] [__lru_cache_del+1/272]
Sep 19 20:15:55 jeloin kernel: Latency  21ms PID  1038 %% cp
Sep 19 20:15:55 jeloin kernel: Trace: [truncate_list_pages+200/456] 
[try_to_free_buffers+332/556]
Sep 19 20:32:18 jeloin kernel: Latency   6ms PID     7 %% kupdated
Sep 19 20:32:19 jeloin kernel: Latency   5ms PID  1214 %% mmap002
Sep 19 20:35:18 jeloin kernel: Latency  22ms PID  1214 %% mmap002
Sep 19 20:35:18 jeloin kernel: Trace: [zap_page_range+318/628] 
[zap_page_range+382/628]
Sep 19 21:49:22 jeloin kernel: Latency  10ms PID     0 %% swapper
Sep 19 21:49:22 jeloin kernel: Trace: [schedule+463/1032]
Sep 19 22:37:45 jeloin kernel: Latency   5ms PID  2439 %% y2bignfat
Sep 19 22:37:45 jeloin kernel: Latency   5ms PID  2446 %% y2bignfat
Sep 19 22:46:18 jeloin kernel: Latency   5ms PID  2552 %% y2bignfat
Sep 19 22:46:18 jeloin kernel: Trace: [zap_page_range+382/628]
Sep 19 22:46:18 jeloin kernel: Latency   5ms PID  2555 %% y2bignfat
Sep 19 22:46:18 jeloin kernel: Trace: [zap_page_range+318/628]
Sep 19 22:46:18 jeloin kernel: Latency   5ms PID  2559 %% y2bignfat
Sep 19 22:46:18 jeloin kernel: Latency   5ms PID  2571 %% y2bignfat
Sep 19 22:46:19 jeloin kernel: Latency   5ms PID  2573 %% y2bignfat
Sep 19 22:46:19 jeloin kernel: Latency   5ms PID  2574 %% y2bignfat
Sep 19 22:46:19 jeloin kernel: Latency   5ms PID  2578 %% y2bignfat
Sep 19 22:46:19 jeloin kernel: Latency   5ms PID  2579 %% y2bignfat
Sep 19 22:46:19 jeloin kernel: Trace: [zap_page_range+382/628]
Sep 19 22:46:19 jeloin kernel: Latency   5ms PID  2593 %% y2bignfat
Sep 19 22:46:19 jeloin kernel: Trace: [zap_page_range+318/628]
Sep 19 22:46:19 jeloin kernel: Latency   5ms PID  2594 %% y2bignfat
Sep 19 22:46:20 jeloin kernel: Latency   5ms PID  2596 %% y2bignfat
Sep 20 07:27:57 jeloin kernel: Latency  59ms PID   281 %% cardmgr
Sep 20 07:27:57 jeloin kernel: Trace: [__rdtsc_delay+20/28] 
[__rdtsc_delay+20/28] [__rdtsc_delay+22/28] [__rdtsc_delay+20/28] 
[__rdtsc_delay+20/28]
Sep 20 07:27:57 jeloin kernel: Trace: [__rdtsc_delay+20/28]
Sep 20 07:27:57 jeloin kernel: Latency  24ms PID   316 %% ifconfig
Sep 20 07:27:57 jeloin kernel: Trace: [__rdtsc_delay+20/28] 
[mousedev:__insmod_mousedev_O/lib/modules/2.4.10-pre10/kernel/drivers+-93829/96] 
[mousedev:__insmod_mousedev_O/lib/modules/2.4.10-pre10/kernel/drivers+-93562/96]
Sep 20 07:27:59 jeloin kernel: Latency   8ms PID   649 %% X
Sep 20 07:27:59 jeloin kernel: Trace: [aux_write_ack+54/60]
-- 
Roger Larsson
Skellefteå
Sweden

--------------Boundary-00=_J86Y9OB0Q4XNQ2QRF17S
Content-Type: application/x-gzip;
  name="latency-profiling-2.4.10-pre10-preempt-r16.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="latency-profiling-2.4.10-pre10-preempt-r16.patch.gz"

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
uFr8HzGxyZ55FQAA

--------------Boundary-00=_J86Y9OB0Q4XNQ2QRF17S--
