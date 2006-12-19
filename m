Return-Path: <linux-kernel-owner+w=401wt.eu-S1752314AbWLSEGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314AbWLSEGY (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 23:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWLSEGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 23:06:24 -0500
Received: from an-out-0708.google.com ([209.85.132.247]:13113 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbWLSEGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 23:06:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=oFf/ZROS/jwNXlRK49hA6wbj1cFBlw4BJK8BHmf/nvWYxXgqtwnMVVqDRhmF7i8W/QPskd6EiAQs4RPTigZZWSAljgK/kpnseopoU0erOnBfZjVBkTAERzlQLLDwssC1VPff0/ePxjBvC/KOxDHCSMbDSv1DzB6tNX+QlwxfQdE=
Message-ID: <4587653C.1080100@gmail.com>
Date: Tue, 19 Dec 2006 12:06:20 +0800
From: Hawk Xu <hxunix@gmail.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Aiee, killing interrupt handler!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Our server(running Oracle 10g) is having a kernel panic problem:

Process swapper (pid: 0, threadinfo ffffffff80582000, task ffffffff80464300)
Stack: 0000000000000296 ffffffff8013f325 ffff81007f7f54d0 0000000000000100
       0000000000000001 000000000000000e ffffffff8053e098 ffffffff8013f3a5
       ffff81007f7f54d0 ffff810002c10a20
Call Trace: <IRQ> <ffffffff8013f325>{group_send_sig_info+85}
<ffffffff8013f3a5>{send_group_sig_info+53}
       <ffffffff80137a50>{it_real_fn+0} <ffffffff80137a66>{it_real_fn+22}
       <ffffffff8013c9bf>{run_timer_softirq+383}
<ffffffff80111660>{profile_pc+32}
       <ffffffff80138921>{__do_softirq+113}
<ffffffff801389d5>{do_softirq+53}
       <ffffffff8010e3d3>{apic_timer_interrupt+99}  <EOI>
<ffffffff8010e676>{kernel_thread+130}
       <ffffffff8010bc40>{default_idle+0}
<ffffffff8010bc60>{default_idle+32}
       <ffffffff8010be9a>{cpu_idle+74} <ffffffff805847b5>{start_kernel+469}
       <ffffffff80584243>{_sinittext+579}
Code: 80 3f 00 7e f9 e9 4a fd ff ff e8 b0 25 ec ff e9 74 fd ff ff
console shuts up ...
<0>Kernel panic - not syncing: Aiee, killing interrupt handler!


And, we have these error messages in the /var/log/kernel file:

Dec  7 17:19:09 kf85-1 kernel: set_local_var[9683]: segfault at
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc4e8 error 6
Dec  7 17:27:44 kf85-1 kernel: set_local_var[12020]: segfault at
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffb978 error 6
Dec  7 17:29:39 kf85-1 kernel: dbi[12608]: segfault at 0000000000000000
rip 00000000080ecea8 rsp 00000000ffffa0b0 error 4
Dec 14 14:00:39 kf85-1 kernel: set_local_var[1886]: segfault at
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffb358 error 6
Dec 15 10:03:17 kf85-1 kernel: set_local_var[2459]: segfault at
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc2e8 error 6
Dec 15 10:36:27 kf85-1 kernel: modeling[12173] trap bounds rip:806aec8
rsp:ffff9820 error:0
Dec 15 10:51:49 kf85-1 kernel: modeling[14405]: segfault at
0000000000000008 rip 0000000056b97e8c rsp 00000000ffffaa78 error 6
Dec 15 11:09:14 kf85-1 kernel: set_local_var[20817]: segfault at
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc928 error 6
Dec 15 11:16:29 kf85-1 kernel: set_local_var[21760]: segfault at
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffbd98 error 6
Dec 15 15:10:52 kf85-1 kernel: rtdb_server[17604] trap bounds
rip:80f5247 rsp:5b9f9040 error:0
Dec 15 15:11:01 kf85-1 kernel: rtdb_server[18631] trap bounds
rip:80f5247 rsp:58905040 error:0
Dec 15 15:11:16 kf85-1 kernel: rtdb_server[18718] trap bounds
rip:80f5247 rsp:59300040 error:0
Dec 15 15:11:23 kf85-1 kernel: rtdb_server[18762] trap bounds
rip:80f5247 rsp:59106040 error:0
Dec 15 15:14:17 kf85-1 kernel: rtdb_server[18869] trap bounds
rip:80f5247 rsp:5b10a040 error:0
Dec 15 15:14:22 kf85-1 kernel: rtdb_server[19567] trap bounds
rip:80f5247 rsp:59106040 error:0
Dec 15 15:14:32 kf85-1 kernel: rtdb_server[19586] trap bounds
rip:80f5247 rsp:57903040 error:0
Dec 15 15:48:30 kf85-1 kernel: set_local_var[2430]: segfault at
00000000fffffffc rip 0000000055f41d69 rsp 00000000ffffc7f8 error 6
Dec 15 16:16:17 kf85-1 kernel: GFileManager[10453]: segfault at
0000000000003135 rip 00000000574d5f99 rsp 00000000597b3158 error 6


The kernel version is 2.6.12.5.  The kernel panic problem happened 3
times last week, and we don't know whether there are some relationships
between the kernel panic and the error messages in the kernel log file.

That's all we know now, the server is in Nanjing, which is 1000
kilometers south of us, and we are not allowed to access the server.

Any help would be great!


Best regards,

hxu

