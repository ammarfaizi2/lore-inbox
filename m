Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265897AbRFYSTm>; Mon, 25 Jun 2001 14:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbRFYSTc>; Mon, 25 Jun 2001 14:19:32 -0400
Received: from mnh-1-11.mv.com ([207.22.10.43]:37384 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265897AbRFYSTS>;
	Mon, 25 Jun 2001 14:19:18 -0400
Message-Id: <200106251933.OAA03356@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Bulent Abali" <abali@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Stevenson <mistral@stev.org>
Subject: Re: all processes waiting in TASK_UNINTERRUPTIBLE state 
In-Reply-To: Your message of "Mon, 25 Jun 2001 12:48:46 -0400."
             <OF831FC2D7.C211A862-ON85256A76.005AEC98@pok.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Jun 2001 14:33:54 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

abali@us.ibm.com said:
> Can you give more details? 

BTW, here are a couple of the UML stacks:

#3  0x1000895d in schedule () at sched.c:669
#4 0x1001c9bd in ___wait_on_page (page=0x50025740) at filemap.c:641
#5  0x1001d286 in do_generic_file_read (filp=0x50d4c674, ppos=0x50d4c694,
    desc=0x50d1bea8, actor=0x1001d410 <file_read_actor>) at 
/home/mistral/dev/kernel/linux-2.4.5-um-06-15/include/linux/pagemap.h:97
#6  0x1001d528 in generic_file_read (filp=0x50d4c674, buf=0x401b7000 <Address 
0x401b7000 out of bounds>, count=4096, ppos=0x50d4c694) at filemap.c:1302
#7  0x1002ba2b in sys_read (fd=6, buf=0x401b7000 <Address 0x401b7000 out of 
bounds>, count=4096) at read_write.c:133

#3  0x1000895d in schedule () at sched.c:669
#4  0x1001c9bd in ___wait_on_page (page=0x50015bb4) at filemap.c:641
#5  0x1001a2e1 in do_swap_page (mm=0x5009ea34, vma=0x50f83dac, 
address=3212835782, page_table=0x50d5cffc, entry={val = 202240}, 
write_access=0) at /home/mistral/dev/kernel/linux-2.4.5-um7/include/linux/pagem
ap.h:97
#6  0x1001a733 in handle_mm_fault (mm=0x5009ea34, vma=0x50f83dac, 
address=3212835782, write_access=0) at memory.c:1307
#7  0x10012c40 in access_one_page (mm=0x5009ea34, vma=0x50f83dac, 
addr=3212835782, buf=0x5153e000, len=15, write=0) at ptrace.c:78
#8  0x10012cd8 in access_mm (mm=0x5009ea34, vma=0x50f83dac, addr=3212835782, 
buf=0x5153e000, len=15, write=0) at ptrace.c:104
#9  0x10012d5b in access_process_vm (tsk=0x50db0000, addr=3212835782, 
buf=0x5153e000, len=15, write=0) at ptrace.c:147
#10 0x1004656b in proc_pid_cmdline (task=0x50db0000, buffer=0x5153e000 "74 66 
64 8 0 58 14\n") at base.c:157
#11 0x10046914 in proc_info_read (file=0x50d4eefc, buf=0xbf7ff0b0 
"/proc/117/cmdline", count=2047, ppos=0x50d4ef1c) at base.c:288
#12 0x1002ba2b in sys_read (fd=6, buf=0xbf7ff0b0 "/proc/117/cmdline", 
count=2047) at read_write.c:133

There are a few more at http://www.geocrawler.com/lists/3/SourceForge/709/0/598
8636/

				Jeff


