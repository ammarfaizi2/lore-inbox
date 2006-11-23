Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933256AbWKWIQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933256AbWKWIQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933246AbWKWIQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:16:27 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49637 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933234AbWKWIQ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:16:26 -0500
Date: Thu, 23 Nov 2006 00:14:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@sous-sol.org>, KaiGai Kohei <kaigai@kaigai.gr.jp>,
       Chris Friedhoff <chris@friedhoff.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: security: introduce file caps
Message-Id: <20061123001458.fe73f64a.akpm@osdl.org>
In-Reply-To: <20061114030655.GB31893@sergelap>
References: <20061114030655.GB31893@sergelap>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 21:06:55 -0600
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Implement file posix capabilities.  This allows programs to be given
> a subset of root's powers regardless of who runs them, without
> having to use setuid and giving the binary all of root's powers.

With this patch applied, my X server fails to exit when I do the normal
logout thing from the KDE menus.

The distro is FC5, SELinux is enabled.  I start X via `startx'.

All the X clients have gone away, but the server continues to run.  Black
screen with just a mouse pointer which still responds to movement.

This happens with CONFIG_SECURITY_FS_CAPABILITIES=n as well as =y.

ps auxfw says:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.1  0.0   2000   676 ?        Ss   01:04   0:00 init [3]                                                                                                                                                 
root         2  0.0  0.0      0     0 ?        SN   01:04   0:00 [ksoftirqd/0]
root         3  0.0  0.0      0     0 ?        S    01:04   0:00 [watchdog/0]
root         4  0.0  0.0      0     0 ?        S<   01:04   0:00 [events/0]
root         5  0.0  0.0      0     0 ?        S<   01:04   0:00 [khelper]
root         6  0.0  0.0      0     0 ?        S<   01:04   0:00 [kthread]
root        47  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kblockd/0]
root        48  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kacpid]
root       152  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [ata/0]
root       153  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [ata_aux]
root       154  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [ksuspend_usbd]
root       157  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [khubd]
root       159  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kseriod]
root       179  0.0  0.0      0     0 ?        S    01:04   0:00  \_ [pdflush]
root       180  0.0  0.0      0     0 ?        S    01:04   0:00  \_ [pdflush]
root       181  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kswapd0]
root       182  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [aio/0]
root       291  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [scsi_eh_0]
root       292  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [scsi_eh_1]
root       297  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [scsi_eh_2]
root       298  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [scsi_eh_3]
root       311  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [pccardd]
root       321  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kpsmoused]
root       326  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kedac]
root       354  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kjournald]
root       740  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [hda_codec]
root       975  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [khpsbpkt]
root      1110  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [knodemgrd_0]
root      1680  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [kauditd]
root      2237  0.0  0.0      0     0 ?        S<   01:04   0:00  \_ [ipw2200/0]
root       421  0.0  0.0   2212   648 ?        S<s  01:04   0:00 /sbin/udevd -d
root      1427  0.0  0.0   1584   280 ?        Ss   01:04   0:00 cpuspeed -d -n
root      1624  0.0  0.0   1652   592 ?        Ss   01:04   0:00 syslogd -m 0
root      1627  0.0  0.0   1604   392 ?        Ss   01:04   0:00 klogd -x
rpc       1644  0.0  0.0   1736   552 ?        Ss   01:04   0:00 portmap
rpcuser   1663  0.0  0.0   1744   716 ?        Ss   01:04   0:00 rpc.statd
root      1678  0.0  0.0   9944   604 ?        S<sl 01:04   0:00 auditd
root      1707  0.0  0.0   4728   584 ?        Ss   01:04   0:00 rpc.idmapd
dbus      1721  0.0  0.1  11268  1104 ?        Ssl  01:04   0:00 dbus-daemon --system
root      1763  0.0  0.0   1820   460 ?        Ss   01:04   0:00 /usr/bin/hidd --server
root      1850  0.0  0.0   1872   748 ?        Ss   01:04   0:00 /usr/sbin/automount --timeout=60 --debug /net program /etc/auto.net
root      1863  0.0  0.0   1600   460 ?        Ss   01:04   0:00 /usr/sbin/acpid
root      1872  0.0  0.0   5008   488 ?        Ss   01:04   0:00 ./hpiod
root      1877  0.0  0.4  12572  4720 ?        S    01:04   0:00 python ./hpssd.py
root      1888  0.0  0.1   4984  1100 ?        Ss   01:04   0:00 /usr/sbin/sshd
root      2354  0.0  0.2   7800  2516 ?        Ss   01:04   0:00  \_ sshd: akpm [priv]
akpm      2408  0.0  0.1   7928  1964 ?        S    01:04   0:00  |   \_ sshd: akpm@pts/0 
akpm      2443  0.0  0.2   5872  2364 pts/0    Ss+  01:04   0:00  |       \_ -zsh
root      3198  0.0  0.2   7800  2512 ?        Ss   01:05   0:00  \_ sshd: akpm [priv]
akpm      3202  0.0  0.1   7928  2004 ?        S    01:05   0:00      \_ sshd: akpm@pts/1 
akpm      3209  0.0  0.2   6004  2568 pts/1    Ss   01:05   0:00          \_ -zsh
akpm      3264  0.0  0.0   2104   840 pts/1    R+   01:11   0:00              \_ ps auxfw
root      1900  0.0  0.0   2228   808 ?        Ss   01:04   0:00 xinetd -stayalive -pidfile /var/run/xinetd.pid
ntp       1912  0.0  0.4   4244  4244 ?        SLs  01:04   0:00 ntpd -u ntp:ntp -p /var/run/ntpd.pid -g
root      1957  0.0  0.0   1824   344 ?        Ss   01:04   0:00 gpm -m /dev/input/mice -t exps2
root      1966  0.0  0.1   5188  1192 ?        Ss   01:04   0:00 crond
xfs       2001  0.1  0.2   4204  2492 ?        Ss   01:04   0:00 xfs -droppriv -daemon
root      2010  0.0  0.0   1596   496 ?        SNs  01:04   0:00 anacron -s
root      2018  0.0  0.0   2164   444 ?        Ss   01:04   0:00 /usr/sbin/atd
root      2027  0.0  0.1   3136  1152 ?        Ss   01:04   0:00 cups-config-daemon
68        2037  0.6  0.3   5100  3436 ?        Ss   01:04   0:02 hald
root      2038  0.0  0.1   3136  1048 ?        S    01:04   0:00  \_ hald-runner
68        2044  0.0  0.0   2236   868 ?        S    01:04   0:00      \_ /usr/libexec/hald-addon-acpi
68        2052  0.0  0.0   2236   872 ?        S    01:04   0:00      \_ /usr/libexec/hald-addon-keyboard
root      2127  0.0  0.1   2744  1316 ?        Ss   01:04   0:00 login -- akpm     
akpm      2453  0.0  0.2   5968  2492 tty1     Ss+  01:04   0:00  \_ -zsh
root      2128  0.0  0.0   1588   408 tty2     Ss+  01:04   0:00 /sbin/mingetty tty2
root      2129  0.0  0.0   1588   408 tty3     Ss+  01:04   0:00 /sbin/mingetty tty3
root      2130  0.0  0.0   1584   404 tty4     Ss+  01:04   0:00 /sbin/mingetty tty4
root      2131  0.0  0.0   1584   404 tty5     Ss+  01:04   0:00 /sbin/mingetty tty5
root      2132  0.0  0.0   1584   404 tty6     Ss+  01:04   0:00 /sbin/mingetty tty6
root      2753  0.0  0.1   8364  1928 ?        Ss   01:05   0:00 sendmail: accepting connections
smmsp     2764  0.0  0.1   7344  1712 ?        Ss   01:05   0:00 sendmail: Queue runner@01:00:00 for /var/spool/clientmqueue
root      2784  0.7  0.8  13284  8428 tty7     Ss+  01:05   0:02 X :0 -auth /home/akpm/.serverauth.2767
akpm      2948  0.0  0.0   2864   264 ?        Ss   01:05   0:00 syndaemon -k -i 1 -d

