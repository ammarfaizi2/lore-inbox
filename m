Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284394AbRLENpi>; Wed, 5 Dec 2001 08:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284397AbRLENpT>; Wed, 5 Dec 2001 08:45:19 -0500
Received: from pD90058F6.dip.t-dialin.net ([217.0.88.246]:60688 "HELO
	mail.system") by vger.kernel.org with SMTP id <S284396AbRLENpF>;
	Wed, 5 Dec 2001 08:45:05 -0500
Message-ID: <3C0E269A.926922A0@analogon.com>
Date: Wed, 05 Dec 2001 14:52:26 +0100
From: Tom Beer <mailings@analogon.com>
X-Mailer: Mozilla 4.75 [de] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Segmentation Fault
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after installing amanda I get segmentation
faults running updatedb, slocate, ls, find
and every other prog that tries to access the
/usr/src/linux-2.4.4/linux/Documentation/filesystems
As far as I can see only this specific directory
is affected. It is reproduceable. dmesg is below.
First the files that I added:


> Added object name:  /usr/sbin/smrsh
> Added object name:  /usr/sbin/mailstats
> Added object name:  /usr/sbin/makemap
> Added object name:  /usr/sbin/praliases
> Added object name:  /usr/sbin/sendmail
> Added object name:  /usr/lib/sendmail
> Added object name:  /usr/lib/sasl/Sendmail.conf
> Added object name:  /usr/lib/libhistory.so.3.0
> Added object name:  /usr/lib/libreadline.so.3.0
> Added object name:  /usr/lib/libreadline.so.3
> Added object name:  /usr/lib/libhistory.so.3
> Added object name:  /usr/lib/libform.so.4
> Added object name:  /usr/lib/libform.so.4.0
> Added object name:  /usr/lib/libmenu.so.4
> Added object name:  /usr/lib/libmenu.so.4.0
> Added object name:  /usr/lib/libncurses.so.4
> Added object name:  /usr/lib/libncurses.so.4.0
> Added object name:  /usr/lib/libpanel.so.4
> Added object name:  /usr/lib/libpanel.so.4.0
> Added object name:  /usr/lib/libgd.so.1.3
> Added object name:  /usr/lib/libgd.so.1
> Added object name:  /usr/lib/libfl.a
> Added object name:  /usr/lib/libl.a
> Added object name:  /usr/lib/libhistory.a
> Added object name:  /usr/lib/libhistory.so
> Added object name:  /usr/lib/libreadline.a
> Added object name:  /usr/lib/libreadline.so
 Added object name:  /usr/bin/gtar
> Added object name:  /usr/bin/makemap
> Added object name:  /usr/bin/giftogd
> Added object name:  /usr/bin/webgif
> Added object name:  /usr/bin/gnuplot
> Added object name:  /usr/bin/gnuplot_x11
> Added object name:  /usr/bin/flex
> Added object name:  /usr/bin/flex++
> Added object name:  /usr/bin/lex
> Added object name:  /usr/bin/hoststat
> Added object name:  /usr/bin/mailq
> Added object name:  /usr/bin/newaliases
> Added object name:  /usr/bin/purgestat
> Added object name:  /usr/bin/rmail
Added object name:  /usr/local/lib/libamanda.la
> Added object name:  /usr/local/lib/libamanda.a
> Added object name:  /usr/local/lib/libamclient.la
> Added object name:  /usr/local/lib/libamclient.a
> Added object name:  /usr/local/lib/libamtape.la
> Added object name:  /usr/local/lib/libamtape.a
> Added object name:  /usr/local/lib/libamserver.la
> Added object name:  /usr/local/lib/libamserver.a

a dmesg output

Code: 8b 40 34 85 c0 74 0a 52 ff d0 89 c3 83 c4 04 eb 02 31 db 85 
Unable to handle kernel paging request at virtual address 02110034
 printing eip:
c013af90
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013af90>]
EFLAGS: 00210206
eax: 02110000   ebx: 00000000   ecx: ca3f3000   edx: d37adf40
esi: cb519fa4   edi: bfffe758   ebp: bfffe620   esp: cb519f9c
ds: 0018   es: 0018   ss: 0018
Process mc (pid: 7957, stackpage=cb519000)
Stack: cb518000 080c6ee0 d37adf40 d7e34140 00000005 08112d00 08112ce0
00000008 
       00000001 c0106e03 0810b960 bfffe568 00004000 080c6ee0 bfffe758
bfffe620 
       000000c4 0000002b 0000002b 000000c4 4012d5f3 00000023 00200246
bfffe564 
Call Trace: [<c0106e03>] 

Code: 8b 40 34 85 c0 74 0a 52 ff d0 89 c3 83 c4 04 eb 02 31 db 85 

Additionally the permissions in the whole
/usr/src/linux-2.4.3 & 2.4.4 directory have changed to:


-rw-r--r--    1 1046     101          2940 Mär 22  2001 SAK.txt
-rw-r--r--    1 1046     101          4581 Apr  6  2001
SubmittingDrivers

but even to other uid's and gid's.


I changed them back to root:root with chown (-R). However chown also
exits in the filesystems directory.

free:

          total       used       free     shared    buffers     cached
Mem:        384080     303944      80136          0      39328     
92288
-/+ buffers/cache:     172328     211752
Swap:      2096440       1180    2095260
Total:     2480520     305124    2175396

That's not much. Basically what was running when I issued free -t is:

init-+-automount
     |-bdflush
     |-crond
     |-deskguide_apple
     |-esd
     |-eth1
     |-gmc
     |-gnome-name-serv
     |-gnome-smproxy
     |-gnome-terminal-+-bash---pstree
     |                |-bash
     |                `-gnome-pty-helpe
     |-gpm
     |-httpd---8*[httpd]
     |-identd---identd---3*[identd]
     |-keventd
     |-khubd
     |-klogd
     |-kreclaimd
     |-kswapd
     |-kupdated
     |-lockd
     |-login---bash---startx---xinit-+-X
     |                               `-gnome-session
     |-lpd
     |-magicdev
     |-5*[mingetty]
     |-netscape-commun---netscape-commun
     |-8*[nfsd]
     |-panel
     |-portmap
     |-rpc.mountd
     |-rpc.rquotad
     |-rpciod
     |-sawfish
     |-screenshooter_a
     |-svscan-+-supervise---dnscache
     |        |-2*[supervise---multilog]
     |        `-supervise---tinydns
     |-syslogd
     |-tasklist_applet
     |-xfs
     `-xinetd

If there are informations missing it would be nice if I
can provide them. I tryed some days and running out of 
thoughts what to do.

Thanks Tom


