Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWDHQ1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWDHQ1X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWDHQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:27:23 -0400
Received: from wproxy.gmail.com ([64.233.184.224]:29986 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965018AbWDHQ1W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:27:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AiW9GvCupKL6jm3bl5LaLy5FkJdeRnkwIhlYW/MN11BZFV5z+m/gXw3SCRPPiCnzG5TWS3yqPelKNLmbAQSar8o9L3QbgYw5rlHSn5ZlsbCkSEL7FpfzTey2kFc6BaGuaIvgcFZomWs9z75SPJU/QiVPSr3K3bjs4nKQaCFP3Ao=
Message-ID: <5a4c581d0604080927g532b6d10y7992d9adb4e63d08@mail.gmail.com>
Date: Sat, 8 Apr 2006 18:27:21 +0200
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: 40% IDE performance regression going from FC3 to FC5 with same kernel
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <1144511112.2989.8.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0604080747w61464d48k5480391d98b2bc47@mail.gmail.com>
	 <5a4c581d0604080834k7961aff5l7794b8893325a90c@mail.gmail.com>
	 <1144511112.2989.8.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > Just for the record - no, even rebuilding same kernel with same GCC
> >  (3.4.4) under FC5, disk performance is much slower than FC3 -
> >  according to hdparm _and_ dd tests.
>
> what happens if you kill hald and other inotify using animals?

Thanks Arjan for looking into this.

Stopping hald brings hdparm from 18.5MB/s to 20MB/s, which is
 indeed a noticeable improvement, though still far from the FC3
 performance. I'm unsure what else can be stopped however
 from this process list:

[root@donkey init.d]# ps ax
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:00 init [3]
    2 ?        SN     0:00 [ksoftirqd/0]
    3 ?        S      0:00 [watchdog/0]
    4 ?        S<     0:00 [events/0]
    5 ?        S<     0:00 [khelper]
    6 ?        S<     0:00 [kthread]
    8 ?        S<     0:00 [kblockd/0]
   11 ?        S<     0:00 [khubd]
   40 ?        S      0:00 [kapmd]
   72 ?        S      0:00 [pdflush]
   73 ?        S      0:00 [pdflush]
   74 ?        S      0:00 [kswapd0]
   75 ?        S<     0:00 [aio/0]
   76 ?        S      0:00 [cifsoplockd]
   77 ?        S      0:00 [cifsdnotifyd]
  153 ?        S<     0:00 [kseriod]
  186 ?        S      0:00 [kedac]
  199 ?        S      0:00 [kjournald]
  274 ?        S<s    0:00 /sbin/udevd -d
  346 ?        S<     0:00 [kpsmoused]
  781 ?        S<     0:00 [scsi_eh_0]
  782 ?        S<     0:00 [usb-storage]
  836 ?        S      0:00 [kjournald]
  838 ?        S      0:00 [kjournald]
  840 ?        S      0:00 [kjournald]
  842 ?        S      0:00 [kjournald]
  844 ?        S      0:00 [kjournald]
 1170 ?        Ss     0:00 syslogd -m 0
 1173 ?        Ss     0:00 klogd -x
 1197 ?        Ss     0:00 portmap
 1216 ?        Ss     0:00 rpc.statd
 1295 ?        Ss     0:00 /usr/sbin/apmd -p 10 -w 5 -W -P
/etc/sysconfig/apm-sc 1440 ?        Ss     0:00 cupsd
 1480 ?        Ss     0:00 /usr/sbin/sshd
 1504 ?        Ss     0:00 sendmail: accepting connections
 1514 ?        Ss     0:00 sendmail: Queue runner@01:00:00 for
/var/spool/client 1524 ?        Ss     0:00 gpm -m /dev/input/mice -t
exps2
 1533 ?        Ss     0:00 crond
 1582 ?        Ss     0:00 /usr/sbin/atd
 1662 tty1     Ss+    0:00 /sbin/mingetty tty1
 1663 tty2     Ss+    0:00 /sbin/mingetty tty2
 1666 tty3     Ss+    0:00 /sbin/mingetty tty3
 1669 tty4     Ss+    0:00 /sbin/mingetty tty4
 1672 tty5     Ss+    0:00 /sbin/mingetty tty5
 1703 tty6     Ss+    0:00 /sbin/mingetty tty6
 1718 ?        Ss     0:00 sshd: root@pts/0
 1742 pts/0    Ss     0:00 -bash
 1859 pts/0    R+     0:00 ps ax

strace shows read() system time practically identical around 1.3s,
 hence I ran a ltrace comparison, which shows this:

FC3:

[root@donkey ~]#  ltrace -c dd if=/dev/hdb of=/dev/null skip=400
bs=1024k count=200
200+0 records in
200+0 records out
% time     seconds  usecs/call     calls      function
------ ----------- ----------- --------- --------------------
 99.86   14.597554       72987       200 read
  0.10    0.015150          75       200 write
  0.01    0.000947         473         2 dcgettext
  0.01    0.000871         435         2 fprintf
  0.00    0.000634         634         1 setlocale

FC5:

[root@donkey ~]# ltrace -c dd if=/dev/hdb of=/dev/null skip=400
bs=1024k count=200
200+0 records in
200+0 records out
209715200 bytes (210 MB) copied, 9.49944 seconds, 22.1 MB/s
% time     seconds  usecs/call     calls      function
------ ----------- ----------- --------- --------------------
 99.81   27.460675      137303       200 read
  0.12    0.032411       32411         1 dcgettext
  0.05    0.014069          70       200 write
  0.00    0.000908         302         3 __fprintf_chk

FC5 rebooted, with hald stopped:

[root@donkey init.d]# ltrace -c dd if=/dev/hdb of=/dev/null skip=400
bs=1024k count=200
200+0 records in
200+0 records out
209715200 bytes (210 MB) copied, 8.83107 seconds, 23.7 MB/s
% time     seconds  usecs/call     calls      function
------ ----------- ----------- --------- --------------------
 99.93   26.791861      133959       200 read
  0.05    0.014154          70       200 write
  0.00    0.000925         925         1 dcgettext
  0.00    0.000856         285         3 __fprintf_chk


Note the usecs/call comparison for read()...

[Also note how the ltrace output is wrong in terms of absolute
 timing - approximately 3x the actual elapsed time]

Thanks,

--alessandro

 "Dreamer ? Each one of us is a dreamer. We just push it down deep because
   we are repeatedly told that we are not allowed to dream in real life"
     (Reinhold Ziegler)
