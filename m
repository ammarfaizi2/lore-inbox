Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261320AbTCJO53>; Mon, 10 Mar 2003 09:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbTCJO52>; Mon, 10 Mar 2003 09:57:28 -0500
Received: from pushme.nist.gov ([129.6.16.92]:64687 "EHLO postmark.nist.gov")
	by vger.kernel.org with ESMTP id <S261320AbTCJO51>;
	Mon, 10 Mar 2003 09:57:27 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TransMeta longrun control utility maintainer?
References: <9cfy93s4mbd.fsf@rogue.ncsl.nist.gov>
	<20030306181829.GA3431@kroah.com>
From: Ian Soboroff <ian.soboroff@nist.gov>
Date: Mon, 10 Mar 2003 10:07:38 -0500
In-Reply-To: <20030306181829.GA3431@kroah.com> (Greg KH's message of "Thu, 6
 Mar 2003 10:18:30 -0800")
Message-ID: <9cfisurs1j9.fsf@rogue.ncsl.nist.gov>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Thu, Mar 06, 2003 at 09:11:18AM -0500, Ian Soboroff wrote:
>> 
>> I know this isn't the best place to ask, but maybe someone here knows.
>> 
>> Who is maintaining the longrun(1) (should probably be longrun(8))
>> utility?  The author is listed as Daniel Quinlan
>> <quinlan@transmeta.com>, but mail to that address bounces.
>> 
>> The longrun utility frobs the MSR on TransMeta processors to switch
>> between performance and economy modes.
>> 
>> On my laptop, currently running 2.4.21-pre5-ac1, I get the following
>> error:
>
> It works for me just fine on 2.4.21-pre5, have you tried that kernel
> version?

I'm getting the same problem under -pre5, too.

# uname -a
Linux euphrates 2.4.21-pre5 #1 Thu Mar 6 15:10:53 EST 2003 i686 i686 i386 GNU/Linux
# longrun -p
longrun: error reading /dev/cpu/0/cpuid: Invalid argument
# ls -l /dev/cpu/0
total 0
crw-r--r--    1 root     root     203,   0 Aug 30  2002 cpuid
crw-------    1 root     root      10, 184 Aug 30  2002 microcode
crw-------    1 root     root     202,   0 Aug 30  2002 msr
# strace longrun -p
execve("/usr/local/bin/longrun", ["longrun", "-p"], [/* 33 vars */]) = 0
uname({sys="Linux", node="euphrates", ...}) = 0
brk(0)                                  = 0x804ab04
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=84791, ...}) = 0
old_mmap(NULL, 84791, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40013000
close(3)                                = 0
open("/lib/i686/libc.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220Y\1"..., 1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1395734, ...}) = 0
old_mmap(0x42000000, 1239844, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x42000000
mprotect(0x42126000, 35620, PROT_NONE)  = 0
old_mmap(0x42126000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x126000) = 0x42126000
old_mmap(0x4212b000, 15140, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4212b000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40028000
munmap(0x40013000, 84791)               = 0
geteuid32()                             = 0
open("/dev/cpu/0/cpuid", O_RDWR)        = 3
open("/dev/cpu/0/msr", O_RDWR)          = 4
pread(3, 0xbffff890, 16, 18446744071570849792) = -1 EINVAL (Invalid argument)
write(2, "longrun: ", 9longrun: )                = 9
write(2, "error reading /dev/cpu/0/cpuid", 30error reading /dev/cpu/0/cpuid) = 30
write(2, ": Invalid argument\n", 19: Invalid argument
)    = 19
_exit(1)                                = ?

That offset to pread() looks bogus...

Ian

