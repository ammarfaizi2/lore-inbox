Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUF3P6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUF3P6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUF3P6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 11:58:39 -0400
Received: from pier.botik.ru ([193.232.174.1]:7406 "EHLO pier.botik.ru")
	by vger.kernel.org with ESMTP id S266717AbUF3P5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 11:57:43 -0400
Message-ID: <40E2E28E.8010709@namesys.com>
Date: Wed, 30 Jun 2004 19:55:58 +0400
From: "E. Gryaznova" <grev@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: reiserfs-dev@namesys.com
Subject: [2.6.7-mm4: OOPS] kernel BUG at mm/mmap.c:1793
Content-Type: multipart/mixed;
 boundary="------------070207070501060607030300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070207070501060607030300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

this is reproducible for me problem:
This wilson mmap test (attached) causes the kernel BUG at mm/mmap.c:1793 
immediately after running.

kernel :  2.6.7-mm4 (no extra patches)
test : wison-mmap-test -s 1000
tested filesystem :  ext2
RAM : 256Mb

machine :
# car /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP Processor 1700+
stepping        : 2
cpu MHz         : 1460.204
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2883.58

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1460.204
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2916.35


------------[ cut here ]------------
kernel BUG at mm/mmap.c:1793!
invalid operand: 0000 [#1]
SMP

Program received signal SIGTRAP, Trace/breakpoint trap.
0xc01441af in exit_mmap (mm=0xcf90a040) at tlb.h:78
78                      tlb->nr = 0;
(gdb)

(gdb) bt
#0  0xc01441af in exit_mmap (mm=0xcf90a040) at tlb.h:78
#1  0xc011c137 in mmput (mm=0xcf90a040) at kernel/fork.c:464
#2  0xc011ff95 in do_exit (code=11) at kernel/exit.c:516
#3  0xc012024a in do_group_exit (exit_code=11) at kernel/exit.c:886
#4  0xc0127f3f in get_signal_to_deliver (info=0xccd4df24, regs=0xccd4dfc4,
    cookie=0xc12067c8) at kernel/signal.c:1871
#5  0xc01059eb in do_signal (regs=0xccd4dfc4, oldset=0xcf53ec04)
    at arch/i386/kernel/signal.c:572
#6  0xc0105acb in do_notify_resume (regs=0xccd4dfc4, oldset=0xffffffd4,
    thread_info_flags=3240126408) at arch/i386/kernel/signal.c:619
#7  0xc0105cbe in work_notifysig () at arch/i386/kernel/entry.S:350
#8  0x1ffccfd8 in ?? ()
#9  0x00000400 in ?? ()
(gdb)

(gdb) c
Continuing.
CPU:    0
EIP:    0060:[<c01441af>]    Not tainted VLI
EFLAGS: 00010202   (2.6.7-mm4)
EIP is at exit_mmap+0x13f/0x150
eax: 00000001   ebx: c1204040   ecx: c12067c8   edx: ffffffd4
esi: cf90a040   edi: cf53e6c0   ebp: ccd4dea0   esp: ccd4de80
ds: 007b   es: 007b   ss: 0068
Process wilson-mmap-tes (pid: 968, threadinfo=ccd4c000 task=cf53e6c0)
Stack: 00000000 ffffffff ccd4de94 00000000 c1204040 0000002c cf90a040 
cf90a06c
       ccd4deac c011c137 cf90a040 ccd4ded0 c011ff95 00000000 cf53e6c0 
0000000a
       00000000 cf652b00 ccd4c000 0000000b ccd4deec c012024a 0000000b 
cf53ec04
Call Trace:
 [<c0106aa6>] show_stack+0xa6/0xb0
 [<c0106c1d>] show_registers+0x14d/0x1c0
 [<c0106dca>] die+0xaa/0x130
 [<c01071ec>] do_invalid_op+0x9c/0xa0
 [<c01066dd>] error_code+0x2d/0x38
 [<c011c137>] mmput+0x57/0x90
 [<c011ff95>] do_exit+0x155/0x330
 [<c012024a>] do_group_exit+0x3a/0xc0
 [<c0127f3f>] get_signal_to_deliver+0x26f/0x370
 [<c01059eb>] do_signal+0x5b/0x100
 [<c0105acb>] do_notify_resume+0x3b/0x3d
 [<c0105cbe>] work_notifysig+0x13/0x15
Code: 5b 5e c9 c3 8b 03 c7 43 08 00 00 00 00 e8 fa fa fc ff 8b 53 04 83 
fa ff 74 a2 8d 43 14 e8 4a 67 00 00 c7 43 04 00 00 00 00 eb 91 <0f> 0b 
01 07 ec c3 41 c0 e9 59 ff ff ff 8d 74 26 00 55 89 e5 56


Thanks,
Lena.

--------------070207070501060607030300
Content-Type: text/plain;
 name="wilson-mmap-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wilson-mmap-test.c"

/*
 * This program was originaly from W.Wilson Ho.
 */

/*
 * @(#)bigfile.c        1.2     98/12/19 Connectathon Testsuite
 */

/*
  * Write and reread a large file.  This potentially covers a few problems
  * that have appeared in the past:
  * - inability of server to commit a large file range with one RPC
  * - client's dirtying memory faster than it can clean it
  * - server's returning bogus file attributes, confusing the client
  * - client and server not propagating "filesystem full" errors back to the
  *   application
  */
 
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/mman.h>
#include <errno.h>

static char usage[] = "usage: bigfile [-s size_in_MB] filename";
 
static off_t file_size = 30 * 1024 * 1024;
 
static char *filename;                  /* name of test file */
static int buffer_size = 8192;          /* size of read/write buffer */
 
static long pagesize;
 
static void write_read_mmap (int fd);
 
int main(argc, argv)
         int argc;
         char **argv;
 {
         int c;
         off_t size;
         int fd;
         extern int optind;
         extern char *optarg;
 
         pagesize = sysconf(_SC_PAGESIZE);
         if (pagesize < 0) {
                 fprintf(stderr, "can't get page size\n");
                 exit(2);
         }
 
         while ((c = getopt(argc, argv, "s:")) != EOF)
                 switch (c) {
                 case 's':
                         size = atol(optarg) * 1024 * 1024;
                         if (size > 0)
                                 file_size = size;
                         break;
                 case '?':
                         fprintf(stderr, "%s\n", usage);
                         exit(2);
                         break;
                 }
         if (optind != argc - 1) {
                 fprintf(stderr, "%s\n", usage);
                 exit(2);
         }
         filename = argv[optind];
	 printf ("file: %s, size = %lu\n", filename, file_size);
         fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
         if (fd < 0) {
                 fprintf(stderr, "can't create %s: %s\n",
                         filename, strerror(errno));
                 exit(2);
         }
 
         write_read_mmap(fd);

         if (unlink(filename) < 0) {
                 fprintf(stderr, "can't unlink %s: %s\n",
                         filename, strerror(errno));
                 exit(2);
         }

	 printf ("OK. Passed.\n");
         exit(0);
 }
 
 /*
  * Return non-zero if the given buffer is full of the given value.
  * Otherwise, return zero.
  */
 
 static int
 verify(buf, bufsize, val)
         char *buf;
         long bufsize;
         unsigned char val;
 {
         int i;
 
         for (i = 0; i < bufsize; i++) {
                 if ((unsigned char)(buf[i]) != val)
                         return (0);
         }
 
         return (1);
 }
 
 /*
  * Print the contents of the buffer in hex to stderr.
  */
 
 static void
 dump_buf(buf, bufsize)
         char *buf;
         int bufsize;
 {
         int i;
 
         for (i = 0; i < bufsize; i++) {
                 fprintf(stderr, "%x ", buf[i]);
                 if ((i + 1) % 40 == 0)
                         fprintf(stderr, "\n");
         }
         fprintf(stderr, "\n");
 }
 
 /*
  * Write out the given error message and exit.  If the error is because
  * there is no more space, flag it as a warning, and delete the file.
  * Otherwise, flag it as an error and leave the file alone.
  */
 
 static void
 io_error(error, errmsg)
         int error;                      /* errno value */
         char *errmsg;
 {
         if (error == EDQUOT || error == ENOSPC)
                 fprintf(stderr, "Warning: can't complete test: ");
         else
                 fprintf(stderr, "Error: ");
         fprintf(stderr, "%s\n", errmsg);
 
         if (error == EDQUOT || error == ENOSPC)
                 unlink(filename);
 
         exit(2);
 }
 
 /*
  * Return the test value for the given offset.
  */
 
 static inline unsigned char
 testval(off_t offset)
 {
         return 'a' + (offset % 26);
 }
 
 /*
  * Write and then randomly reread the file, by mapping it.  Same error
  * handling as write_read().
  */
 
 static void
 write_read_mmap (int fd)
 {
     long numpages = file_size / pagesize;
     char *buf;
     int i;
 
     /*
      * Truncate the file and then map it in (the entire file).  Then
      * fill it with unsigned chars, the same as write_read().
      */
 
     if (ftruncate(fd, 0) < 0) {
         fprintf(stderr, "can't truncate %s: %s\n",
                 filename, strerror(errno));
         exit(2);
     }
     if (ftruncate(fd, file_size) < 0) {
         int error = errno;
         char errmsg[1024];
 
         sprintf(errmsg, "write to %s failed: %s",
                 filename, strerror(errno));
         io_error(error, errmsg);
     }
     buf = mmap(0, file_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
     if (buf == (char *)MAP_FAILED) {
         fprintf(stderr, "can't map %s for writing: %s\n",
                 filename, strerror(errno));
         exit(2);
     }
 
     for (i = 0; i < numpages; i++) {
         unsigned char val = testval(i);
 
         memset(buf + i * pagesize, val, pagesize);
     }
 
     if (msync(buf, file_size, MS_SYNC | MS_INVALIDATE) < 0) {
         char errmsg[1024];
         int error = errno;
 
         sprintf(errmsg, "can't msync %s: %s", filename,
                 strerror(error));
         io_error(error, errmsg);
     }
     if (munmap(buf, file_size) < 0) {
         char errmsg[1024];
         int error = errno;
 
         sprintf(errmsg, "can't munmap %s: %s", filename,
                 strerror(error));
         io_error(error, errmsg);
     }
 
     /*
      * Reread the file, a page at a time, and make sure it has correct
      * bits.
      */
 
     for (i = 0; i < numpages; i++) {
         unsigned char val = testval(i);
 
         buf = mmap(0, pagesize, PROT_READ, MAP_SHARED, fd,
                    i * pagesize);
         if (buf == (char *)MAP_FAILED) {
             fprintf(stderr, "can't map %s for reading: %s\n",
                     filename, strerror(errno));
             exit(2);
         }
         if (!verify(buf, pagesize, val)) {
             fprintf(stderr,
                     "verify of mapped file failed, offset %ld; ",
                     (long)i * pagesize);
	     fprintf(stderr, "expected %x, got \n",
                     val);
	     dump_buf(buf, pagesize);
             exit(1);
         }
 
         if (munmap(buf, pagesize) < 0) {
             fprintf(stderr,
                     "can't unmap file after verifying: %s\n",
                     strerror(errno));
             exit(2);
         }
     }
 }




--------------070207070501060607030300--

