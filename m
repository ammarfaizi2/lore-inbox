Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWAJKQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWAJKQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWAJKQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:16:06 -0500
Received: from tornado.reub.net ([202.89.145.182]:24794 "EHLO tornado.reub.net")
	by vger.kernel.org with ESMTP id S1750834AbWAJKQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:16:05 -0500
Message-ID: <43C38932.7070302@reub.net>
Date: Tue, 10 Jan 2006 23:15:14 +1300
From: Reuben Farrelly <reuben-lkml@reub.net>
User-Agent: Thunderbird 1.6a1 (Windows/20060109)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm2
References: <20060107052221.61d0b600.akpm@osdl.org>	<43BFD8C1.9030404@reub.net> <20060107133103.530eb889.akpm@osdl.org>
In-Reply-To: <20060107133103.530eb889.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

[removed cc Jeff Garzik and Stephen Hemminger, as this is not about sky2 or libata]

On 8/01/2006 10:31 a.m., Andrew Morton wrote:

>> 3.  The boot up process with -mm2 was pretty lengthy, I had two periods of time 
>> when the whole system just came to a crawl, first time was when starting cups, 
>> and it came back to life and continued booting about 30s later.  Next when 
>> starting hpijs it didn't come to life at all and I had to reboot.  No output to 
>> the console for either, unfortunately.
> 
> Don't know, sorry.  But this kernel had oopsed, hadn't it?

This one is still present in -git6.  The symptoms are that the kernel boots up, 
the userspace applications start launching as the system starts to go to 
runlevel 3, and then the system 'blocks' on $random_service (clamd, mysql and 
vsftp and others).  I've left it for 5 mins and it never continued on..

There's no oops, and nothing seems to be logged about it, I can hit enter and 
the console jumps to a new line, so the machine doesn't lock up hard, it seems 
to be getting 'stuck'.

I gathered this info via serial console:

SysRq : HELP : loglevel0-8 reBoot show-all-locks(D) tErm Full kIll saK showMem 
Nice powerOff showPc unRaw Sync showTasks Unmount
dSysRq : Show Locks Held

Showing all blocking locks in the system:
S            init:    1 [c1920a50, 116] (not blocked on mutex)
S     migration/0:    2 [c1920030,   0] (not blocked on mutex)
S     ksoftirqd/0:    3 [c1928a50, 134] (not blocked on mutex)
S      watchdog/0:    4 [c1928540,   0] (not blocked on mutex)
S     migration/1:    5 [c1928030,   0] (not blocked on mutex)
S     ksoftirqd/1:    6 [c1930a50, 134] (not blocked on mutex)
S      watchdog/1:    7 [c1930540,   0] (not blocked on mutex)
S        events/0:    8 [c1930030, 110] (not blocked on mutex)
S        events/1:    9 [c1950a50, 110] (not blocked on mutex)
S         khelper:   10 [c1936a50, 111] (not blocked on mutex)
S         kthread:   11 [c1950540, 111] (not blocked on mutex)
S       kblockd/0:   14 [c1967540, 110] (not blocked on mutex)
S       kblockd/1:   15 [c1967030, 110] (not blocked on mutex)
S          kacpid:   16 [c1936540, 111] (not blocked on mutex)
S           khubd:  108 [c1ba8a50, 110] (not blocked on mutex)
S         pdflush:  160 [c1bdb540, 120] (not blocked on mutex)
D         pdflush:  161 [c1bdb030, 115] (not blocked on mutex)
S         kswapd0:  162 [c1be0a50, 117] (not blocked on mutex)
S           aio/0:  163 [c1b51030, 111] (not blocked on mutex)
S           aio/1:  164 [c1b51540, 111] (not blocked on mutex)
S         kseriod:  252 [f7cdd030, 110] (not blocked on mutex)
S           ata/0:  277 [f7cdd540, 111] (not blocked on mutex)
S           ata/1:  278 [f7cd8a50, 111] (not blocked on mutex)
S       scsi_eh_0:  280 [c1b55030, 110] (not blocked on mutex)
S       scsi_eh_1:  281 [c1b55540, 111] (not blocked on mutex)
S       scsi_eh_2:  282 [f7cd3030, 111] (not blocked on mutex)
S       scsi_eh_3:  283 [c1b55a50, 110] (not blocked on mutex)
S           kirqd:  368 [f7cd8030, 115] (not blocked on mutex)
S       md5_raid1:  374 [f7cd8540, 110] (not blocked on mutex)
S       md4_raid1:  378 [c1b4b030, 110] (not blocked on mutex)
S       md3_raid1:  382 [c1967a50, 110] (not blocked on mutex)
D       md2_raid1:  386 [c1b4b540, 110] (not blocked on mutex)
S       md1_raid1:  391 [c1b51a50, 110] (not blocked on mutex)
D       md0_raid1:  394 [c1b47540, 110] (not blocked on mutex)
D      reiserfs/0:  395 [c1b39030, 110] (not blocked on mutex)
D      reiserfs/1:  396 [f7c70030, 110] (not blocked on mutex)
S           udevd:  446 [c1ba8030, 112] (not blocked on mutex)
S       kjournald: 1299 [f7c67a50, 120] (not blocked on mutex)
S              rc: 1370 [c1b39540, 118] (not blocked on mutex)
D         syslogd: 1675 [f753d540, 116] (not blocked on mutex)
S           klogd: 1678 [f75e3030, 115] (not blocked on mutex)
S           named: 1689 [f753d030, 117] (not blocked on mutex)
S           named: 1690 [f7673540, 116] (not blocked on mutex)
D           named: 1691 [f767b540, 116] (not blocked on mutex)
S           named: 1692 [f7673030, 116] (not blocked on mutex)
S           named: 1693 [f7c6ca50, 116] (not blocked on mutex)
S         portmap: 1715 [f74ee030, 116] (not blocked on mutex)
S           mdadm: 1724 [f75d4030, 116] (not blocked on mutex)
S           acpid: 1804 [f7620030, 123] (not blocked on mutex)
S           hpiod: 1812 [c1b43a50, 116] (not blocked on mutex)
S           hpiod: 1828 [f7696a50, 117] (not blocked on mutex)
S          python: 1817 [f7c67030, 115] (not blocked on mutex)
D           cupsd: 1826 [f771ca50, 116] (not blocked on mutex)
S            sshd: 1879 [c1950030, 115] (not blocked on mutex)
S          xinetd: 1888 [f74fea50, 115] (not blocked on mutex)
S            ntpd: 1899 [c1b39a50, 116] (not blocked on mutex)
S         apcupsd: 1917 [f75d4540, 116] (not blocked on mutex)
S         apcupsd: 2198 [f74ee540, 115] (not blocked on mutex)
S            nfsd: 1953 [c1936030, 119] (not blocked on mutex)
S            nfsd: 1954 [f7696030, 119] (not blocked on mutex)
S            nfsd: 1955 [f7c76540, 120] (not blocked on mutex)
S            nfsd: 1956 [f7c6c030, 120] (not blocked on mutex)
S            nfsd: 1957 [c1be0540, 120] (not blocked on mutex)
S            nfsd: 1958 [f74eea50, 120] (not blocked on mutex)
S            nfsd: 1959 [c1ba8540, 120] (not blocked on mutex)
S            nfsd: 1960 [c1b43540, 121] (not blocked on mutex)
S           lockd: 1962 [c1b43030, 120] (not blocked on mutex)
S        rpciod/0: 1963 [f7594540, 112] (not blocked on mutex)
S        rpciod/1: 1964 [f7594030, 110] (not blocked on mutex)
S      rpc.mountd: 1966 [f7c76030, 119] (not blocked on mutex)
S      rpc.idmapd: 1985 [f7c6c540, 116] (not blocked on mutex)
S          vsftpd: 1995 [f7696540, 118] (not blocked on mutex)
S     mysqld_safe: 2055 [f64cb540, 124] (not blocked on mutex)
S          mysqld: 2086 [c1bdba50, 116] (not blocked on mutex)
S          mysqld: 2087 [f64d4030, 119] (not blocked on mutex)
S          mysqld: 2088 [f64d4a50, 116] (not blocked on mutex)
S          mysqld: 2089 [f64cba50, 117] (not blocked on mutex)
S          mysqld: 2090 [f771c540, 119] (not blocked on mutex)
S          mysqld: 2097 [f760d540, 116] (not blocked on mutex)
S          mysqld: 2098 [f760da50, 116] (not blocked on mutex)
S          mysqld: 2104 [f7594a50, 116] (not blocked on mutex)
S          mysqld: 2105 [f7663a50, 116] (not blocked on mutex)
S          mysqld: 2106 [f753da50, 118] (not blocked on mutex)
S           dhcpd: 2119 [f7cd3a50, 116] (not blocked on mutex)
S         dovecot: 2128 [f64dd540, 115] (not blocked on mutex)
S    dovecot-auth: 2138 [f75e3a50, 116] (not blocked on mutex)
S    dovecot-auth: 2139 [c1b47a50, 116] (not blocked on mutex)
D            imap: 2157 [c1b47030, 116] (not blocked on mutex)
S           clamd: 2158 [f7663540, 118] (not blocked on mutex)
S      S79amavisd: 2161 [f7620a50, 118] (not blocked on mutex)
D            imap: 2164 [f7cd3540, 115] blocked on mutex: [f61e5d44] 
{inode_init_once}
.. held by:              imap: 2188 [f74fe540, 115]
... acquired at:               real_lookup+0x1d/0xc6
S            bash: 2165 [f7c67540, 120] (not blocked on mutex)
D         amavisd: 2166 [f650ba50, 118] (not blocked on mutex)
D            imap: 2174 [f7c76a50, 116] (not blocked on mutex)
X      imap-login: 2176 [f771c030, 116] (not blocked on mutex)
X      imap-login: 2178 [f74fe030, 116] (not blocked on mutex)
S      imap-login: 2179 [f75e3540, 116] (not blocked on mutex)
S      imap-login: 2180 [f767ba50, 116] (not blocked on mutex)
D            imap: 2188 [f74fe540, 115] (not blocked on mutex)
S            imap: 2196 [f650b540, 116] (not blocked on mutex)
X      imap-login: 2197 [f7cdda50, 115] (not blocked on mutex)
X      imap-login: 2202 [f767b030, 116] (not blocked on mutex)
D            imap: 2213 [f6231a50, 115] (not blocked on mutex)
D    dovecot-auth: 2222 [f64d4540, 118] (not blocked on mutex)
D    dovecot-auth: 2223 [f64dd030, 116] (not blocked on mutex)
D    dovecot-auth: 2224 [f760d030, 115] (not blocked on mutex)

---------------------------
| showing all locks held: |
---------------------------

#001:             [f7dc8a4c] {alloc_super}
.. held by:           pdflush:  161 [c1bdb030, 115]
... acquired at:               sync_supers+0x8d/0xeb

#002:             [f61e5d44] {inode_init_once}
.. held by:              imap: 2188 [f74fe540, 115]
... acquired at:               real_lookup+0x1d/0xc6

#003:             [f61529c4] {inode_init_once}
.. held by:              imap: 2157 [c1b47030, 116]
... acquired at:               real_lookup+0x1d/0xc6

#004:             [f700d9c4] {inode_init_once}
.. held by:             named: 1691 [f767b540, 116]
... acquired at:               reiserfs_file_write+0x1be/0x615

#005:             [f68dcd44] {inode_init_once}
.. held by:             cupsd: 1826 [f771ca50, 116]
... acquired at:               sys_unlink+0x66/0x118

#006:             [f6bd2d44] {inode_init_once}
.. held by:             cupsd: 1826 [f771ca50, 116]
... acquired at:               vfs_unlink+0xd4/0x150

=============================================

Is there any other information I can gather to help narrow this one down?

reuben


