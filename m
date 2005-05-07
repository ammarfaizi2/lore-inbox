Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVEGPBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVEGPBm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 11:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVEGPBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 11:01:42 -0400
Received: from mail.nagafix.co.uk ([213.228.237.37]:48103 "EHLO
	mail.nagafix.co.uk") by vger.kernel.org with ESMTP id S261428AbVEGPAX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 11:00:23 -0400
Subject: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
From: Antoine Martin <antoine@nagafix.co.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1115392141.12197.3.camel@cobra>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	 <1115248927.12088.52.camel@cobra>  <1115392141.12197.3.camel@cobra>
Content-Type: text/plain
Date: Sat, 07 May 2005 17:31:46 +0100
Message-Id: <1115483506.12131.33.camel@cobra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3-1.3.101mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can crash a host repeatedly just by running a UML instance
(and causing some load on that instance - like running gcc)
I captured these messages from the serial console after it crashed:

Host: Linux x86_64 2.6.11.8 (built with selinux but not enforcing)
Guest: 2.6.12-rc3-uml
The UML patch applied on top of rc3 is available here:
http://213.228.237.37/uml/2.6.12-rc3/uml-x86_64-2.6.12-rc3.patch.bz2
It was built using the instructions from Jeff Dike at:
http://user-mode-linux.sourceforge.net/patches.html
The thread 'kernel-4' is the UML instance, running as a nobody user.
This was reported to the UML ML and Jeff Dike who advised me to
post it here too.
Let me know if you need anything else / testing / etc.
I am not subscribed to LKML, so please CC me on all emails.

general protection fault: 0000 [1]
CPU 0
Pid: 26926, comm: kernel-4 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8010ca47>] <ffffffff8010ca47>{__switch_to+311}
RSP: 0018:ffff8100a7635d48  EFLAGS: 00010016
RAX: 0000c8e816000002 RBX: ffff8100b895f320 RCX: 00000000c0000102
RDX: 000000000000c8e8 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff810090db3a00 R09: 0000000000006933
R10: 0000000000000000 R11: 0000000000000202 R12: ffff8100a827b890
R13: ffff8100b895f010 R14: ffff8100a827b580 R15: ffff8100a827b7f8
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000006880d010 CR3: 00000000a2321000 CR4: 00000000000006e0
Process kernel-4 (pid: 26926, threadinfo ffff810060884000, task
ffff8100a827b580)
Stack: ffff8100dc37e180 ffff8100b895f010 ffffffff806b6d50
ffff8100b895f010
       000003595b049ed6 ffffffff804f4de4 ffff8100a7635de8
0000000000000086
       0000007500000020 ffff8100b895f010
Call Trace:<ffffffff804f4de4>{thread_return+0}
<ffffffff8013cb08>{ptrace_stop+280}
       <ffffffff8013cde6>{get_signal_to_deliver+358}
<ffffffff8010d4e3>{do_signal+163}
       <ffffffff8010e905>{error_exit+0}
<ffffffff8010de67>{sys_rt_sigreturn+535}
       <ffffffff8010dee9>{sys_rt_sigreturn+665}
<ffffffff8010e2b6>{int_signal+18}


Code: 0f 30 66 41 89 6c 24 2e 65 48 8b 04 25 20 00 00 00 49 89 44
RIP <ffffffff8010ca47>{__switch_to+311} RSP <ffff8100a7635d48>
 <0>general protection fault: 0000 [2]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8010ca47>] <ffffffff8010ca47>{__switch_to+311}
RSP: 0018:ffff8100a7635d48  EFLAGS: 00010016
RAX: 0000c8e816000002 RBX: ffff8100b895f320 RCX: 00000000c0000102
RDX: 000000000000c8e8 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf909f0
R13: ffff8100b895f010 R14: ffff8100fbf906e0 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 000000006880d010 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffff8100dc37e180 ffff8100b895f010 ffffffff806b6d50
ffff8100b895f010
       00000359c1aeb8da ffffffff804f4de4 ffff8100a7635de8
0000000000000086
       0000007500000020 ffff8100b895f010
Call Trace:<ffffffff804f4de4>{thread_return+0}
<ffffffff8013cb08>{ptrace_stop+280}
       <ffffffff8013cde6>{get_signal_to_deliver+358}
<ffffffff8010d4e3>{do_signal+163}
       <ffffffff8010e905>{error_exit+0}
<ffffffff8010de67>{sys_rt_sigreturn+535}
       <ffffffff8010dee9>{sys_rt_sigreturn+665}
<ffffffff8010e2b6>{int_signal+18}


Code: 0f 30 66 41 89 6c 24 2e 65 48 8b 04 25 20 00 00 00 49 89 44
RIP <ffffffff8010ca47>{__switch_to+311} RSP <ffff8100a7635d48>
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000278
RIP:
<ffffffff804f4c99>{schedule+873}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [3]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff804f4c99>] <ffffffff804f4c99>{schedule+873}
RSP: 0018:ffff8100a7635b68  EFLAGS: 00010007
RAX: 0000000002d3ca44 RBX: 0000000000000000 RCX: ffff810090db3a00
RDX: 000000003b9ac880 RSI: ffff8100b895f010 RDI: ffff8100fbf906e0
RBP: ffff8100a7635bc8 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff806b6d50
R13: ffff8100b895f010 R14: 0000035a27fb7d77 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000278 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: 0000007300000000 ffff8100fbf906e0 0000000000000180
ffff8100b895f010
       ffffffff806a6fc0 0000000000000000 ffff8100fbf906e0
ffff8100a7635be8
       ffff8100fbf906e0 ffff8100fbf91440
Call Trace:<ffffffff801347a7>{do_exit+2535} <ffffffff8010f5ac>{oops_end
+28}
       <ffffffff8010f6e5>{die+69}
<ffffffff801100fe>{do_general_protection+270}
       <ffffffff8010e905>{error_exit+0} <ffffffff8010ca47>{__switch_to
+311}
       <ffffffff804f4de4>{thread_return+0}
<ffffffff8013cb08>{ptrace_stop+280}
       <ffffffff8013cde6>{get_signal_to_deliver+358}
<ffffffff8010d4e3>{do_signal+163}
       <ffffffff8010e905>{error_exit+0}
<ffffffff8010de67>{sys_rt_sigreturn+535}
       <ffffffff8010dee9>{sys_rt_sigreturn+665}
<ffffffff8010e2b6>{int_signal+18}


Code: 0f ba b3 78 02 00 00 00 0f ba a9 78 02 00 00 00 48 8b 51 38
RIP <ffffffff804f4c99>{schedule+873} RSP <ffff8100a7635b68>
CR2: 0000000000000278
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [4]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a76358c8  EFLAGS: 00010006
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a76358d8 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 0000035aa7f554c4 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a7635968 ffff8100a7635948
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ffffffff8013cb08>{ptrace_stop+280}
<ffffffff8013cde6>{get_signal_to_deliver+358}
       <ffffffff8010d4e3>{do_signal+163} <ffffffff8010e905>{error_exit
+0}
       <ffffffff8010de67>{sys_rt_sigreturn+535}
<ffffffff8010dee9>{sys_rt_sigreturn+665}
       <ffffffff8010e2b6>{int_signal+18}

Code: ff 0e 55 48 8b 47 38 48 8b 51 08 48 89 e5 48 89 02 48 89 50
RIP <ffffffff8012e134>{dequeue_task+4} RSP <ffff8100a76358c8>
CR2: 0000000000000000
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [5]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a7635628  EFLAGS: 00010002
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a7635638 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 0000035b3fc7d274 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a76356c8 ffff8100a76356a8
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ffffffff8013cb08>{ptrace_stop+280}
<ffffffff8013cde6>{get_signal_to_deliver+358}
       <ffffffff8010d4e3>{do_signal+163} <ffffffff8010e905>{error_exit
+0}
       <ffffffff8010de67>{sys_rt_sigreturn+535}
<ffffffff8010dee9>{sys_rt_sigreturn+665}
       <ffffffff8010e2b6>{int_signal+18}

Code: ff 0e 55 48 8b 47 38 48 8b 51 08 48 89 e5 48 89 02 48 89 50
RIP <ffffffff8012e134>{dequeue_task+4} RSP <ffff8100a7635628>
CR2: 0000000000000000
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [6]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a7635388  EFLAGS: 00010006
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a7635398 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 0000035bf2d22de7 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a7635428 ffff8100a7635408
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ffffffff8013cb08>{ptrace_stop+280}
<ffffffff8013cde6>{get_signal_to_deliver+358}
       <ffffffff8010d4e3>{do_signal+163} <ffffffff8010e905>{error_exit
+0}
       <ffffffff8010de67>{sys_rt_sigreturn+535}
<ffffffff8010dee9>{sys_rt_sigreturn+665}
       <ffffffff8010e2b6>{int_signal+18}

Code: ff 0e 55 48 8b 47 38 48 8b 51 08 48 89 e5 48 89 02 48 89 50
RIP <ffffffff8012e134>{dequeue_task+4} RSP <ffff8100a7635388>
CR2: 0000000000000000
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [7]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a76350e8  EFLAGS: 00010006
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a76350f8 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 0000035cc114f6cf R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a7635188 ffff8100a7635168
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ffffffff8013cb08>{ptrace_stop+280}
<ffffffff8013cde6>{get_signal_to_deliver+358}
       <ffffffff8010d4e3>{do_signal+163} <ffffffff8010e905>{error_exit
+0}
       <ffffffff8010de67>{sys_rt_sigreturn+535}
<ffffffff8010dee9>{sys_rt_sigreturn+665}
       <ffffffff8010e2b6>{int_signal+18}

Code: ff 0e 55 48 8b 47 38 48 8b 51 08 48 89 e5 48 89 02 48 89 50
RIP <ffffffff8012e134>{dequeue_task+4} RSP <ffff8100a76350e8>
CR2: 0000000000000000
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [8]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a7634e48  EFLAGS: 00010002
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a7634e58 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 0000035daaa6e647 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a7634ee8 ffff8100a7634ec8
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ffffffff8013cb08>{ptrace_stop+280}
<ffffffff8013cde6>{get_signal_to_deliver+358}
       <ffffffff8010d4e3>{do_signal+163} <ffffffff8010e905>{error_exit
+0}
       <ffffffff8010de67>{sys_rt_sigreturn+535}
<ffffffff8010dee9>{sys_rt_sigreturn+665}
       <ffffffff8010e2b6>{int_signal+18}

Code: ff 0e 55 48 8b 47 38 48 8b 51 08 48 89 e5 48 89 02 48 89 50
RIP <ffffffff8012e134>{dequeue_task+4} RSP <ffff8100a7634e48>
CR2: 0000000000000000
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [9]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a7634ba8  EFLAGS: 00010002
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a7634bb8 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 0000035eaf57d638 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a7634c48 ffff8100a7634c28
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ffffffff8013cb08>{ptrace_stop+280}
<ffffffff8013cde6>{get_signal_to_deliver+358}
       <ffffffff8010d4e3>{do_signal+163} <ffffffff8010e905>{error_exit
+0}
       <ffffffff8010de67>{sys_rt_sigreturn+535}
<ffffffff8010dee9>{sys_rt_sigreturn+665}
       <ffffffff8010e2b6>{int_signal+18}

Code: ff 0e 55 48 8b 47 38 48 8b 51 08 48 89 e5 48 89 02 48 89 50
RIP <ffffffff8012e134>{dequeue_task+4} RSP <ffff8100a7634ba8>
CR2: 0000000000000000
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [10]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a7634908  EFLAGS: 00010002
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a7634918 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 0000035fcf41c4f5 R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a76349a8 ffff8100a7634988
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ffffffff8013cb08>{ptrace_stop+280}
<ffffffff8013cde6>{get_signal_to_deliver+358}
       <ffffffff8010d4e3>{do_signal+163} <ffffffff8010e905>{error_exit
+0}
       <ffffffff8010de67>{sys_rt_sigreturn+535}
<ffffffff8010dee9>{sys_rt_sigreturn+665}
       <ffffffff8010e2b6>{int_signal+18}

Code: ff 0e 55 48 8b 47 38 48 8b 51 08 48 89 e5 48 89 02 48 89 50
RIP <ffffffff8012e134>{dequeue_task+4} RSP <ffff8100a7634908>
CR2: 0000000000000000
 <1>Unable to handle kernel NULL pointer dereference at 0000000000000000
RIP:
<ffffffff8012e134>{dequeue_task+4}
PGD c8175067 PUD 31aea067 PMD 0
Oops: 0002 [11]
CPU 0
Pid: 3, comm: events/0 Not tainted 2.6.11.8
RIP: 0010:[<ffffffff8012e134>] <ffffffff8012e134>{dequeue_task+4}
RSP: 0018:ffff8100a7634668  EFLAGS: 00010002
RAX: 0000000000000020 RBX: ffff8100fbf906e0 RCX: ffff8100fbf90718
RDX: ffff8100fbf906e0 RSI: 0000000000000000 RDI: ffff8100fbf906e0
RBP: ffff8100a7634678 R08: 0000000000000000 R09: 000000000000000d
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8100fbf906e0
R13: ffff8100fbf91440 R14: 000003610a89cc6d R15: ffff8100fbf90950
FS:  000000006025212c(0000) GS:ffffffff80785a00(0000)
knlGS:0000000000000d7e
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 00000000a2321000 CR4: 00000000000006e0
Process events/0 (pid: 3, threadinfo ffff8100fbfaa000, task
ffff8100fbf906e0)
Stack: ffffffff8012e3d4 ffff8100a7634708 ffff8100a76346e8
ffffffff804f4ae2
       0000000000000000 ffff8100fbf906e0 00000000069f6bc7
ffffffff801301bf
       00000000ffffff01 0000000000000000
Call Trace:<ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8013218c>{__call_console_drivers+76}
<ffffffff8032d55b>{scrup+123}
       <ffffffff8010e905>{error_exit+0} <ffffffff8012e134>{dequeue_task
+4}
       <ffffffff8012e3d4>{deactivate_task+20}
<ffffffff804f4ae2>{schedule+434}
       <ffffffff801301bf>{mm_release+47} <ffffffff801347a7>{do_exit
+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8011f4cf>{do_page_fault
+1855}
       <ffffffff8010e905>{error_exit+0} <ffffffff804f4c99>{schedule+873}
       <ffffffff804f4ae2>{schedule+434} <ffffffff801347a7>{do_exit+2535}
       <ffffffff8010f5ac>{oops_end+28} <ffffffff8010f6e5>{die+69}
       <ffffffff801100fe>{do_general_protection+270}
<ffffffff8010e905>{error_exit+0}
       <ffffffff8010ca47>{__switch_to+311}
<ffffffff804f4de4>{thread_return+0}
       <ff

