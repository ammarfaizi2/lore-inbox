Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJNCMz>; Sat, 13 Oct 2001 22:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273565AbRJNCMs>; Sat, 13 Oct 2001 22:12:48 -0400
Received: from cogito.cam.org ([198.168.100.2]:57352 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S273269AbRJNCMg>;
	Sat, 13 Oct 2001 22:12:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: mount hanging 2.4.12
Date: Sat, 13 Oct 2001 22:07:43 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110132157160.3903-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0110132157160.3903-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014020743.EBF6E18AA2@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 13, 2001 10:01 pm, Alexander Viro wrote:
> On Sat, 13 Oct 2001, Ed Tomlinson wrote:
> > Oct 13 19:28:31 oscar kernel: usb-uhci.c: interrupt, status 2, frame#
> > 1147 Oct 13 19:28:31 oscar kernel:  I/O error: dev 08:01, sector 0
> > Oct 13 19:28:31 oscar kernel: FAT: unable to read boot sector
> > Oct 13 19:28:31 oscar kernel: VFS: Disk change detected on device sd(8,1)
> > Oct 13 19:28:31 oscar kernel: SCSI device sda: 131072 512-byte hdwr
> > sectors (67 MB) Oct 13 19:28:31 oscar kernel: sda: Write Protect is on
> > Oct 13 19:28:31 oscar kernel:  sda: sda1
> >
> > The device is a usb smartmedia reader using the sddr-09 support.
>
> OK, looks like:
> 	a) ->check_media_change() is screwed for that device.
> 	b) we are hanging on something interesting.  It isn't ->s_umount
> and it's very unlikely to be ->s_lock or mount_sem.  What it might be,
> though... I suspect that ->bd_sem is screwed.
>
> 	Could you reproduce the hang and then do Alt-Sysrq-T?  That should
> give you stack traces.  I'm especially interested in stack trace of hung
> mount(8).  It's nice to know that it ends on down(), but knowing what had
> called that down() would help big way.

I left it hung just in case...  Should have the same pid as the original report. 

Ed

ksymoops 2.4.3 on i586 2.4.12.  Options used
     -V (default)
     -k 20011013192239.ksyms (specified)
     -l 20011013192239.modules (specified)
     -o /lib/modules/2.4.12/ (default)
     -m /boot/System.map-2.4.12 (default)

ac97_codec: AC97 Audio codec, id: 0x4352:0x5903 (Cirrus Logic CS4297)
init          S D3FDFF24  3096     1      0  2767       3       (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0132aa6>] 
   [<c0106d53>] 
keventd       S FFFFFFFF  6252     2      1             7       (L-TLB)
Call Trace: [<c011ca8b>] [<c010568c>] 
ksoftirqd_CPU S D3FCE000  5660     3      0             4     1 (L-TLB)
Call Trace: [<c011624e>] [<c010568c>] 
kswapd        S D3FCC000  5360     4      0             5     3 (L-TLB)
Call Trace: [<c0126ad6>] [<c010568c>] 
bdflush       S 00000286  6564     5      0             6     4 (L-TLB)
Call Trace: [<c0110379>] [<c0130293>] [<c010568c>] 
kupdated      S D3FC9FC8  5256     6      0                   5 (L-TLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c013031a>] [<c010568c>] 
khubd         S 00000282  5804     7      1            18     2 (L-TLB)
Call Trace: [<c01aa68a>] [<c0110379>] [<c01aa6cf>] [<c010568c>] 
kreiserfsd    S D2DADFB4  5596    18      1            60     7 (L-TLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c01103ce>] [<c0166b37>] [<c010568c>] 
mdrecoveryd   S D283A000     0    60      1           215    18 (L-TLB)
Call Trace: [<d69970a6>] [<c010568c>] 
usb-storage-0 S D3048D80    12   214      1           227   215 (L-TLB)
Call Trace: [<c0105c2d>] [<c0105ce3>] [<d6b0549d>] [<d6b03214>] [<c0105683>] 
   [<c010568c>] [<d6b06f4c>] 
scsi_eh_0     S D19A7FDC     0   215      1           214    60 (L-TLB)
Call Trace: [<c0105c2d>] [<c0105ce3>] [<d6a1e323>] [<d6a1cc67>] [<c010568c>] 
syslogd       S 7FFFFFFF     0   227      1           231   214 (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
watchdog      S D176FF8C  4796   231      1  2914     235   227 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c01191c9>] [<c0106d53>] 
klogd         R D1822000     0   235      1           241   231 (NOTLB)
Call Trace: [<c01122b4>] [<c01452a3>] [<c012c9c5>] [<c0106d53>] 
portmap       S 7FFFFFFF  5660   241      1           245   235 (NOTLB)
Call Trace: [<c010fcdf>] [<c01392b7>] [<c01392ec>] [<c01394ed>] [<c01b3b5b>] 
   [<c0106d53>] 
named         S D1519F24  4796   245      1           279   241 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
dhcpd-2.2.x   S 7FFFFFFF     0   279      1           297   245 (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
inetd         S 7FFFFFFF     0   297      1           302   279 (NOTLB)
Call Trace: [<c01c7e59>] [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] 
   [<c0106d53>] 
klisa         S D120FF24  5684   302      1           313   297 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
lpd           S 7FFFFFFF  4796   313      1           326   302 (NOTLB)
Call Trace: [<c010fcdf>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
rpc.statd     S 7FFFFFFF  2656   326      1           329   313 (NOTLB)
Call Trace: [<c01c7e59>] [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] 
   [<c0106d53>] 
pipsecd       S D0E79F24  5104   329      1           469   326 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
master        S D081DF24  4688   469      1  2890     499   329 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
qmgr          S D0213F24  4688   471    469           472       (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
tlsmgr        S D0203F24  4688   472    469          2206   471 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
pppd          S 7FFFFFFF   644   499      1           505   469 (NOTLB)
Call Trace: [<c010fcdf>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
rinetd        S 7FFFFFFF     0   505      1           507   499 (NOTLB)
Call Trace: [<c010fcdf>] [<c0138b51>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
rwhod         S 7FFFFFFF  4720   507      1   509     512   505 (NOTLB)
Call Trace: [<c010fcdf>] [<c01541e3>] [<c01b6cc2>] [<c01b6dde>] [<c01dbcf9>] 
   [<c01e1085>] [<c01b2661>] [<c01b33e7>] [<c01550b6>] [<c015515b>] [<c0155ec9>] 
   [<c01b3b07>] [<c0106d53>] 
rwhod         S D0091F8C   608   509    507                     (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c01191c9>] [<c0106d53>] 
nmbd          S CFF59F24  4596   512      1   514     515   507 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
nmbd          S CFF3C000  6368   514    512                     (NOTLB)
Call Trace: [<c0133d6c>] [<c0133e43>] [<c012c9c5>] [<c0106d53>] 
smbd          S 7FFFFFFF  5280   515      1  1760     522   512 (NOTLB)
Call Trace: [<c010fcdf>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
sshd          S 7FFFFFFF  4796   522      1           526   515 (NOTLB)
Call Trace: [<c01c7e59>] [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] 
   [<c0106d53>] 
xfs           S CFC29F24  5308   526      1           530   522 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
xfs-xtt       S CFA13F24  5180   530      1           540   526 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
xringd        S 00000286     0   540      1           547   530 (NOTLB)
Call Trace: [<c0110379>] [<c018141c>] [<c011e9ce>] [<c010f518>] [<c010f3b8>] 
   [<c0170979>] [<c01383f6>] [<c0106d53>] 
squid         S 00000000  6100   547      1   552     662   540 (NOTLB)
Call Trace: [<c011523e>] [<c0106d53>] 
squid         S CE779F28  4464   552    547   580               (NOTLB)
Call Trace: [<c01b29dd>] [<c010fd3a>] [<c010fc7c>] [<c01392ec>] [<c01394ed>] 
   [<c012c5fb>] [<c0106d53>] 
squidGuard    S 7FFFFFFF  4688   553    552           556       (NOTLB)
Call Trace: [<c010fcdf>] [<c01ca68f>] [<c01cab7f>] [<c01e1085>] [<c01b2661>] 
   [<c01b2770>] [<c012c9c5>] [<c0106d53>] 
squidGuard    S 7FFFFFFF   188   556    552           559   553 (NOTLB)
Call Trace: [<c010fcdf>] [<c01ca68f>] [<c01cab7f>] [<c01e1085>] [<c01b2661>] 
   [<c01b2770>] [<c012c9c5>] [<c0106d53>] 
squidGuard    S 7FFFFFFF  4624   559    552           560   556 (NOTLB)
Call Trace: [<c010fcdf>] [<c01ca68f>] [<c01cab7f>] [<c01e1085>] [<c01b2661>] 
   [<c01b2770>] [<c012c9c5>] [<c0106d53>] 
squidGuard    S 7FFFFFFF  5312   560    552           580   559 (NOTLB)
Call Trace: [<c010fcdf>] [<c01ca68f>] [<c01cab7f>] [<c01e1085>] [<c01b2661>] 
   [<c01b2770>] [<c012c9c5>] [<c0106d53>] 
unlinkd       S CE432000  4868   580    552                 560 (NOTLB)
Call Trace: [<c0133d6c>] [<c0133e43>] [<c012c9c5>] [<c0106d53>] 
cron          S CE01DF8C     0   662      1           670   547 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c01191c9>] [<c0106d53>] 
_upsd         S CDA3DF24  5252   670      1           672   662 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
bkupsd        S 00000202  5308   672      1           681   670 (NOTLB)
Call Trace: [<c0181b7f>] [<c0181be8>] [<c0181ebc>] [<c016fe02>] [<c012cffd>] 
   [<c0134a87>] [<c012d174>] [<c012c2bd>] [<c012c1d3>] [<c012c505>] [<c0106d53>] 
zsh           S D2C75FB0  4624   681      1   702     682   672 (NOTLB)
Call Trace: [<c0105f17>] [<c0106d53>] 
zsh           S D1AA3FB0     4   682      1   692     683   681 (NOTLB)
Call Trace: [<c0105f17>] [<c0106d53>] 
getty         S 7FFFFFFF     0   683      1           684   682 (NOTLB)
Call Trace: [<c010fcdf>] [<c0172dbd>] [<c016f036>] [<c012c9c5>] [<c0106d53>] 
getty         S 7FFFFFFF     4   684      1           685   683 (NOTLB)
Call Trace: [<c010fcdf>] [<c0172dbd>] [<c016f036>] [<c012c9c5>] [<c0106d53>] 
getty         S 7FFFFFFF  2332   685      1           686   684 (NOTLB)
Call Trace: [<c010fcdf>] [<c0172dbd>] [<c016f036>] [<c012c9c5>] [<c0106d53>] 
getty         S 7FFFFFFF   140   686      1           687   685 (NOTLB)
Call Trace: [<c010fcdf>] [<c0172dbd>] [<c016f036>] [<c012c9c5>] [<c0106d53>] 
getty         S 7FFFFFFF     0   687      1           701   686 (NOTLB)
Call Trace: [<c010fcdf>] [<c0172dbd>] [<c016f036>] [<c012c9c5>] [<c0106d53>] 
ssh           S 7FFFFFFF  4384   692    682                     (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
gpm           S CD4B5F8C   388   701      1           727   687 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c01191c9>] [<c0106d53>] 
zsh           S D129DFB0     4   702    681   703               (NOTLB)
Call Trace: [<c0105f17>] [<c0106d53>] 
startx        S 00000000  5016   703    702   711               (NOTLB)
Call Trace: [<c011523e>] [<c0106d53>] 
xinit         S 00000000  2940   711    703   716               (NOTLB)
Call Trace: [<c011523e>] [<c0106d53>] 
XFree86       S CD3D5F24   388   712    711           716       (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
sh            S 00000000  5356   716    711   717           712 (NOTLB)
Call Trace: [<c011523e>] [<c0106d53>] 
kde2          S 00000000  5016   717    716   756               (NOTLB)
Call Trace: [<c011523e>] [<c0106d53>] 
kdeinit       S 7FFFFFFF     0   724      1  2831     760   755 (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S 7FFFFFFF  4544   727      1           730   701 (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S 7FFFFFFF  5472   730      1           733   727 (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S CAEB5F24  5136   733      1           755   730 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
artsd         S CA1D9F24  4688   753    724           758       (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S 7FFFFFFF  5160   755      1           724   733 (NOTLB)
Call Trace: [<c010fcdf>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
ksmserver     S 7FFFFFFF     0   756    717                     (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S 7FFFFFFF  5052   758    724          2808   753 (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S 7FFFFFFF  5472   760      1   763     762   724 (NOTLB)
Call Trace: [<c010fcdf>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S C8B33F24  5272   762      1           765   760 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
cat           S 7FFFFFFF     0   763    760                     (NOTLB)
Call Trace: [<c010fcdf>] [<c0172dbd>] [<c016f036>] [<c012c9c5>] [<c0106d53>] 
kdeinit       S 7FFFFFFF  4796   765      1           773   762 (NOTLB)
Call Trace: [<c010fcdf>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kmix          S C851FF24     0   773      1           776   765 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S C7499F24     0   776      1           786   773 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
kdeinit       S 7FFFFFFF     0   786      1           806   776 (NOTLB)
Call Trace: [<c010fcdf>] [<c01b29dd>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
xmm           S C5B8BF24     0   806      1           808   786 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c0138cd4>] [<c013906c>] [<c0106d53>] 
newsplex      S C516FF8C     8   808      1   809     876   806 (NOTLB)
Call Trace: [<c010fd3a>] [<c010fc7c>] [<c01191c9>] [<c0106d53>] 
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init
>>EIP; d3fdff24 <_end+13d38cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0132aa6 <sys_stat64+62/70>
Trace; c0106d52 <system_call+32/40>
Proc;  keventd
>>EIP; fffffffe <END_OF_CODE+2946e218/????>   <=====
Trace; c011ca8a <context_thread+ee/194>
Trace; c010568c <kernel_thread+28/38>
Proc;  ksoftirqd_CPU
>>EIP; d3fce000 <_end+13d26db8/1655edb8>   <=====
Trace; c011624e <ksoftirqd+76/b0>
Trace; c010568c <kernel_thread+28/38>
Proc;  kswapd
>>EIP; d3fcc000 <_end+13d24db8/1655edb8>   <=====
Trace; c0126ad6 <kswapd+82/bc>
Trace; c010568c <kernel_thread+28/38>
Proc;  bdflush
>>EIP; 00000286 Before first symbol   <=====
Trace; c0110378 <interruptible_sleep_on+3c/50>
Trace; c0130292 <bdflush+9a/a0>
Trace; c010568c <kernel_thread+28/38>
Proc;  kupdated
>>EIP; d3fc9fc8 <_end+13d22d80/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c013031a <kupdate+82/f4>
Trace; c010568c <kernel_thread+28/38>
Proc;  khubd
>>EIP; 00000282 Before first symbol   <=====
Trace; c01aa68a <usb_hub_events+296/2a8>
Trace; c0110378 <interruptible_sleep_on+3c/50>
Trace; c01aa6ce <usb_hub_thread+32/48>
Trace; c010568c <kernel_thread+28/38>
Proc;  kreiserfsd
>>EIP; d2dadfb4 <_end+12b06d6c/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c01103ce <interruptible_sleep_on_timeout+42/58>
Trace; c0166b36 <reiserfs_journal_commit_thread+8e/c8>
Trace; c010568c <kernel_thread+28/38>
Proc;  mdrecoveryd
>>EIP; d283a000 <_end+12592db8/1655edb8>   <=====
Trace; d69970a6 <[md]md_thread+d6/144>
Trace; c010568c <kernel_thread+28/38>
Proc;  usb-storage-0
>>EIP; d3048d80 <_end+12da1b38/1655edb8>   <=====
Trace; c0105c2c <__down_interruptible+58/c4>
Trace; c0105ce2 <__down_failed_interruptible+6/c>
Trace; d6b0549c <[usb-storage].text.end+11e/1a2>
Trace; d6b03214 <[usb-storage]usb_stor_control_thread+0/2f4>
Trace; c0105682 <kernel_thread+1e/38>
Trace; c010568c <kernel_thread+28/38>
Trace; d6b06f4c <[usb-storage]usb_stor_sense_notready+0/14>
Proc;  scsi_eh_0
>>EIP; d19a7fdc <_end+11700d94/1655edb8>   <=====
Trace; c0105c2c <__down_interruptible+58/c4>
Trace; c0105ce2 <__down_failed_interruptible+6/c>
Trace; d6a1e322 <[scsi_mod]RCSid+462/ca0>
Trace; d6a1cc66 <[scsi_mod].text.end+88/102>
Trace; c010568c <kernel_thread+28/38>
Proc;  syslogd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  watchdog
>>EIP; d176ff8c <_end+114c8d44/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c01191c8 <sys_nanosleep+104/17c>
Trace; c0106d52 <system_call+32/40>
Proc;  klogd
>>EIP; d1822000 <_end+1157adb8/1655edb8>   <=====
Trace; c01122b4 <do_syslog+c4/2c8>
Trace; c01452a2 <kmsg_read+e/14>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  portmap
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01392b6 <do_poll+82/d8>
Trace; c01392ec <do_poll+b8/d8>
Trace; c01394ec <sys_poll+1e0/2e4>
Trace; c01b3b5a <sys_socketcall+1ba/1d4>
Trace; c0106d52 <system_call+32/40>
Proc;  named
>>EIP; d1519f24 <_end+11272cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  dhcpd-2.2.x
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  inetd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c01c7e58 <tcp_poll+2c/140>
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  klisa
>>EIP; d120ff24 <_end+10f68cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  lpd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  rpc.statd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c01c7e58 <tcp_poll+2c/140>
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  pipsecd
>>EIP; d0e79f24 <_end+10bd2cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  master
>>EIP; d081df24 <_end+10576cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  qmgr
>>EIP; d0213f24 <_end+ff6ccdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  tlsmgr
>>EIP; d0203f24 <_end+ff5ccdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  pppd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  rinetd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0138b50 <do_select+1c/1dc>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  rwhod
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01541e2 <reiserfs_update_sd+166/174>
Trace; c01b6cc2 <wait_for_packet+d2/140>
Trace; c01b6dde <skb_recv_datagram+ae/c4>
Trace; c01dbcf8 <udp_recvmsg+58/21c>
Trace; c01e1084 <inet_recvmsg+3c/54>
Trace; c01b2660 <sock_recvmsg+3c/bc>
Trace; c01b33e6 <sys_recvfrom+a2/fc>
Trace; c01550b6 <reiserfs_truncate_file+be/16c>
Trace; c015515a <reiserfs_truncate_file+162/16c>
Trace; c0155ec8 <reiserfs_file_release+338/35c>
Trace; c01b3b06 <sys_socketcall+166/1d4>
Trace; c0106d52 <system_call+32/40>
Proc;  rwhod
>>EIP; d0091f8c <_end+fdead44/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c01191c8 <sys_nanosleep+104/17c>
Trace; c0106d52 <system_call+32/40>
Proc;  nmbd
>>EIP; cff59f24 <_end+fcb2cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  nmbd
>>EIP; cff3c000 <_end+fc94db8/1655edb8>   <=====
Trace; c0133d6c <pipe_wait+7c/a4>
Trace; c0133e42 <pipe_read+ae/1f8>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  smbd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  sshd
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c01c7e58 <tcp_poll+2c/140>
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  xfs
>>EIP; cfc29f24 <_end+f982cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  xfs-xtt
>>EIP; cfa13f24 <_end+f76ccdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  xringd
>>EIP; 00000286 Before first symbol   <=====
Trace; c0110378 <interruptible_sleep_on+3c/50>
Trace; c018141c <rs_ioctl+160/324>
Trace; c011e9ce <handle_mm_fault+86/b8>
Trace; c010f518 <do_page_fault+160/498>
Trace; c010f3b8 <do_page_fault+0/498>
Trace; c0170978 <tty_ioctl+350/388>
Trace; c01383f6 <sys_ioctl+16a/184>
Trace; c0106d52 <system_call+32/40>
Proc;  squid
>>EIP; 00000000 Before first symbol
Trace; c011523e <sys_wait4+362/394>
Trace; c0106d52 <system_call+32/40>
Proc;  squid
>>EIP; ce779f28 <_end+e4d2ce0/1655edb8>   <=====
Trace; c01b29dc <sock_poll+20/28>
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c01392ec <do_poll+b8/d8>
Trace; c01394ec <sys_poll+1e0/2e4>
Trace; c012c5fa <filp_close+5a/64>
Trace; c0106d52 <system_call+32/40>
Proc;  squidGuard
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01ca68e <tcp_data_wait+e2/13c>
Trace; c01cab7e <tcp_recvmsg+40e/76c>
Trace; c01e1084 <inet_recvmsg+3c/54>
Trace; c01b2660 <sock_recvmsg+3c/bc>
Trace; c01b2770 <sock_read+84/90>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  squidGuard
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01ca68e <tcp_data_wait+e2/13c>
Trace; c01cab7e <tcp_recvmsg+40e/76c>
Trace; c01e1084 <inet_recvmsg+3c/54>
Trace; c01b2660 <sock_recvmsg+3c/bc>
Trace; c01b2770 <sock_read+84/90>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  squidGuard
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01ca68e <tcp_data_wait+e2/13c>
Trace; c01cab7e <tcp_recvmsg+40e/76c>
Trace; c01e1084 <inet_recvmsg+3c/54>
Trace; c01b2660 <sock_recvmsg+3c/bc>
Trace; c01b2770 <sock_read+84/90>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  squidGuard
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01ca68e <tcp_data_wait+e2/13c>
Trace; c01cab7e <tcp_recvmsg+40e/76c>
Trace; c01e1084 <inet_recvmsg+3c/54>
Trace; c01b2660 <sock_recvmsg+3c/bc>
Trace; c01b2770 <sock_read+84/90>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  unlinkd
>>EIP; ce432000 <_end+e18adb8/1655edb8>   <=====
Trace; c0133d6c <pipe_wait+7c/a4>
Trace; c0133e42 <pipe_read+ae/1f8>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  cron
>>EIP; ce01df8c <_end+dd76d44/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c01191c8 <sys_nanosleep+104/17c>
Trace; c0106d52 <system_call+32/40>
Proc;  _upsd
>>EIP; cda3df24 <_end+d796cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  bkupsd
>>EIP; 00000202 Before first symbol   <=====
Trace; c0181b7e <block_til_ready+1f6/2b8>
Trace; c0181be8 <block_til_ready+260/2b8>
Trace; c0181ebc <rs_open+114/1cc>
Trace; c016fe02 <tty_open+1fe/370>
Trace; c012cffc <get_chrfops+68/c8>
Trace; c0134a86 <permission+2a/30>
Trace; c012d174 <chrdev_open+40/54>
Trace; c012c2bc <dentry_open+e0/184>
Trace; c012c1d2 <filp_open+42/4c>
Trace; c012c504 <sys_open+34/b8>
Trace; c0106d52 <system_call+32/40>
Proc;  zsh
>>EIP; d2c75fb0 <_end+129ced68/1655edb8>   <=====
Trace; c0105f16 <sys_rt_sigsuspend+e2/100>
Trace; c0106d52 <system_call+32/40>
Proc;  zsh
>>EIP; d1aa3fb0 <_end+117fcd68/1655edb8>   <=====
Trace; c0105f16 <sys_rt_sigsuspend+e2/100>
Trace; c0106d52 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0172dbc <read_chan+37c/6d4>
Trace; c016f036 <tty_read+aa/cc>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0172dbc <read_chan+37c/6d4>
Trace; c016f036 <tty_read+aa/cc>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0172dbc <read_chan+37c/6d4>
Trace; c016f036 <tty_read+aa/cc>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0172dbc <read_chan+37c/6d4>
Trace; c016f036 <tty_read+aa/cc>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  getty
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0172dbc <read_chan+37c/6d4>
Trace; c016f036 <tty_read+aa/cc>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  ssh
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  gpm
>>EIP; cd4b5f8c <_end+d20ed44/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c01191c8 <sys_nanosleep+104/17c>
Trace; c0106d52 <system_call+32/40>
Proc;  zsh
>>EIP; d129dfb0 <_end+10ff6d68/1655edb8>   <=====
Trace; c0105f16 <sys_rt_sigsuspend+e2/100>
Trace; c0106d52 <system_call+32/40>
Proc;  startx
>>EIP; 00000000 Before first symbol
Trace; c011523e <sys_wait4+362/394>
Trace; c0106d52 <system_call+32/40>
Proc;  xinit
>>EIP; 00000000 Before first symbol
Trace; c011523e <sys_wait4+362/394>
Trace; c0106d52 <system_call+32/40>
Proc;  XFree86
>>EIP; cd3d5f24 <_end+d12ecdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  sh
>>EIP; 00000000 Before first symbol
Trace; c011523e <sys_wait4+362/394>
Trace; c0106d52 <system_call+32/40>
Proc;  kde2
>>EIP; 00000000 Before first symbol
Trace; c011523e <sys_wait4+362/394>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; caeb5f24 <_end+ac0ecdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  artsd
>>EIP; ca1d9f24 <_end+9f32cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  ksmserver
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; c8b33f24 <_end+888ccdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  cat
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0172dbc <read_chan+37c/6d4>
Trace; c016f036 <tty_read+aa/cc>
Trace; c012c9c4 <sys_read+94/cc>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kmix
>>EIP; c851ff24 <_end+8278cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; c7499f24 <_end+71f2cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  kdeinit
>>EIP; 7ffffffe Before first symbol   <=====
Trace; c010fcde <schedule_timeout+16/90>
Trace; c01b29dc <sock_poll+20/28>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  xmm
>>EIP; c5b8bf24 <_end+58e4cdc/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c0138cd4 <do_select+1a0/1dc>
Trace; c013906c <sys_select+334/474>
Trace; c0106d52 <system_call+32/40>
Proc;  newsplex
>>EIP; c516ff8c <_end+4ec8d44/1655edb8>   <=====
Trace; c010fd3a <schedule_timeout+72/90>
Trace; c010fc7c <process_timeout+0/4c>
Trace; c01191c8 <sys_nanosleep+104/17c>
Trace; c0106d52 <system_call+32/40>


1 warning issued.  Results may not be reliable.



