Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271074AbTGPTmV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 15:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271081AbTGPTmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 15:42:21 -0400
Received: from fep01-svc.mail.telepac.pt ([194.65.5.200]:24783 "EHLO
	fep01-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S271074AbTGPTmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 15:42:04 -0400
Date: Wed, 16 Jul 2003 20:56:56 +0100
From: Nuno Monteiro <nuno.monteiro@ptnix.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: woes with 2.6.0-test1 and xscreensaver/xlock
Message-ID: <20030716195656.GA1567@hobbes.itsari.int>
References: <20030716172758.GA1792@hobbes.itsari.int> <Pine.LNX.4.53.0307161454180.32541@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On 2003.07.16 19:58, Zwane Mwaikambo wrote:
> On Wed, 16 Jul 2003, Nuno Monteiro wrote:
> 
> 
> Someone reported this on bugzilla too, but i failed to reproduce it so
> it
> appears that perhaps something else died like the keyboard. I tried it
> last night on 2.6.0-test1 and i managed to login fine. It does appear
> that
> something else is dying. It'd be good if you could collect the last few
> messages
> from /var/log/XFree86.0.log and /var/log/messages and also perhaps
> /var/log/dmesg.
> 

Hi Zwane, thanks for the reply.

Ok, I just reproduced it. The last lines in /v/l/messages just after 
entering the password in xscreensaver are:

Jul 16 20:27:11 hobbes xscreensaver(pam_unix)[1503]: authentication 
failure; logname= uid=501 euid=501 tty=:0.0 ruser= rhost=  user=root
Jul 16 20:28:52 hobbes modprobe: FATAL: Module /dev/apm_bios not found. 
Jul 16 20:28:58 hobbes modprobe: FATAL: Module /dev/pts0 not found.

in /v/l/syslog:

Jul 16 20:01:00 hobbes CROND[2575]: (root) CMD (nice -n 19 run-parts /
etc/cron.hourly)
Jul 16 20:26:46 hobbes modprobe: FATAL: Module /dev/apm_bios not found.
Jul 16 20:28:52 hobbes modprobe: FATAL: Module /dev/apm_bios not found. 
Jul 16 20:28:58 hobbes modprobe: FATAL: Module /dev/pts0 not found.

and the last lines in /v/l/XFree86.log are:

GetModeLine - scrn: 0 clock: 94500
GetModeLine - hdsp: 1024 hbeg: 1072 hend: 1168 httl: 1376
               vdsp: 768 vbeg: 769 vend: 772 vttl: 808 flags: 5
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(WW) Open APM failed (/dev/apm_bios) (No such file or directory)

The apm bit is funny. I certainly dont have any apm stuff in the kernel. 
This is a regular desktop machine, an amd xp 3200/asus a7v8x board.

Also, i'm attaching a strace log of the xscreensaver process -- i hung it 
entering the password, switched to the console, strace'd it and killed it 
while being traced. I hope it can be useful. The log is slightly edited 
tho, to remove my password.

Ah, one more thing. After killing the xscreensaver process and returning 
to X, the keyboard wont work with some apps -- I can type just fine on 
aterm, for example, but not on balsa or xchat, as all the keypresses on 
those two programs will appear on aterm.

Let me know if you need more info, .config, etc.


Regards,

		Nuno

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename="out.1503"

rt_sigprocmask(SIG_UNBLOCK, [PIPE CHLD], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [PIPE CHLD], NULL, 8) = 0
time(NULL)                              = 1058383631
getuid32()                              = 501
open("/etc/passwd", O_RDONLY)           = 4
fcntl64(4, F_GETFD)                     = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=954, ...}) = 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4041c000
read(4, "root:x:0:0:root:/root:/bin/bash\n"..., 131072) = 954
close(4)                                = 0
munmap(0x4041c000, 131072)              = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
open("/etc/passwd", O_RDONLY)           = 4
fcntl64(4, F_GETFD)                     = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
fstat64(4, {st_mode=S_IFREG|0644, st_size=954, ...}) = 0
mmap2(NULL, 131072, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4041c000
read(4, "root:x:0:0:root:/root:/bin/bash\n"..., 131072) = 954
close(4)                                = 0
munmap(0x4041c000, 131072)              = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
open("/etc/shadow", O_RDONLY)           = -1 EACCES (Permission denied)
open("/var/nis/NIS_COLD_START", O_RDONLY) = -1 ENOENT (No such file or directory)
uname({sys="Linux", node="hobbes", ...}) = 0
geteuid32()                             = 501
pipe([4, 5])                            = 0
rt_sigaction(SIGCHLD, {SIG_IGN}, {0x8054bb0, [CHLD], SA_RESTORER|SA_RESTART, 0x40298c68}, 8) = 0
fork()                                  = 3163
write(5, "nullok\0\0", 8)               = 8
write(5, "MYPASSWD\0", 12)              = 12
close(4)                                = 0
close(5)                                = 0
wait4(3163, 0xbfffee94, 0, NULL)        = -1 ECHILD (No child processes)
rt_sigaction(SIGCHLD, {0x8054bb0, [CHLD], SA_RESTORER|SA_RESTART, 0x40298c68}, {SIG_IGN}, 8) = 0
getuid32()                              = 501
geteuid32()                             = 501
ioctl(0, SNDCTL_TMR_TIMEBASE, 0xbfffeb30) = -1 ENOTTY (Inappropriate ioctl for device)
ioctl(0, SNDCTL_TMR_TIMEBASE, 0xbfffeb30) = -1 ENOTTY (Inappropriate ioctl for device)
time([1058383631])                      = 1058383631
getpid()                                = 1503
rt_sigaction(SIGPIPE, {0x40353d50, [], SA_RESTORER, 0x40298c68}, {SIG_DFL}, 8) = 0
socket(PF_UNIX, SOCK_DGRAM, 0)          = 4
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
connect(4, {sa_family=AF_UNIX, path="/dev/log"}, 16) = 0
send(4, "<37>Jul 16 20:27:11 xscreensaver"..., 133, 0) = 133
rt_sigaction(SIGPIPE, {SIG_DFL}, NULL, 8) = 0
close(4)                                = 0
select(0, NULL, NULL, NULL, {2, 354066}) = 0 (Timeout)
rt_sigtimedwait([PIPE CHLD], 0xbffff120) = -1 EINTR (Interrupted system call)
+++ killed by SIGKILL +++

--ikeVEW9yuYc//A+q--
