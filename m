Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265382AbSLPGaS>; Mon, 16 Dec 2002 01:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSLPGaS>; Mon, 16 Dec 2002 01:30:18 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:44418
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S265382AbSLPG34>; Mon, 16 Dec 2002 01:29:56 -0500
Message-ID: <3DFD74B5.5050206@tupshin.com>
Date: Sun, 15 Dec 2002 22:37:41 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: JDIRTY JWAIT errors in 2.4.19
References: <3DFAF9EF.6000501@tupshin.com> <20021214135550.A13549@namesys.com>
In-Reply-To: <20021214135550.A13549@namesys.com>
Content-Type: multipart/mixed;
 boundary="------------070006010202030900080708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070006010202030900080708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Oleg Drokin wrote:

>Hello!
>
>On Sat, Dec 14, 2002 at 01:29:19AM -0800, Tupshin Harper wrote:
>
>  
>
>>i'm getting the following error logged every 11 seconds or so:
>>
>>Dec 14 01:00:49 phylum kernel: vs-3050: wait_buffer_until_released: nobody
>>releases buffer (dev 16:01, size 4096, blocknr 2916352, count 3, list 0, 
>>state
>>0x10019, page c1172108, (UPTODATE, CLEAN, UNLOCKED)). Still waiting
>>(-1320000000) JDIRTY !JWAIT
>>Also, some processes are blocking, include ps (so I can't get a complete 
>>process list), and shutdown.
>>    
>>
>
>Can you please execute SysRq-T, decode it with ksymoops and send us the result?
>  
>
I have succeeded in reproducing this problem at will (and 
deterministically) with a SysRq enabled kernel.

I can reproduce the problem consistently by doing a cp -av of a 
directory(haven't tried other cp permutations, guessing it wouldn't make 
a difference) containing three mp3 files from one location on a 
partition to another location on the same reiserfs partition. During the 
third file, cp hangs(continues to use 80%+ of the CPU), and is 
unkillable. A few minutes later, it starts generating the same JDIRTY 
error messages that I reported before.

The attached file is a ksymoops processed version of SysRq-T after this 
problem has started to occur. There is one cp taking place which is the 
one that triggered the problem, and there is also a sync command that is 
blocking as well which I tried to do after the cp hung.

I have not tried to do any kind of reiserfs check or repair on the 
filesystem, and I can trigger this problem at any point if you would 
like me to test further.

-Tupshin


--------------070006010202030900080708
Content-Type: text/plain;
 name="ksymout.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymout.txt"

ksymoops 2.4.6 on i686 2.4.19-sysrq.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (specified)
     -o /lib/modules/2.4.19-sysrq/ (specified)
     -m /boot/System.map-2.4.19-sysrq (specified)

Dec 15 12:08:30 phylum kernel: init          S C12F5F28  4500     1      0  1135               (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: keventd       S C12D8000  6152     2      1             3       (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [context_thread+253/424] [kernel_thread+40/56]
Dec 15 12:08:30 phylum kernel: ksoftirqd_CPU S C12D4000  6388     3      1             4     2 (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [ksoftirqd+116/180] [kernel_thread+40/56]
Dec 15 12:08:30 phylum kernel: kswapd        S C12D2000  6108     4      1             5     3 (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [kswapd+127/196] [kernel_thread+40/56]
Dec 15 12:08:30 phylum kernel: bdflush       S 00000282  6560     5      1             6     4 (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [interruptible_sleep_on+61/80] [bdflush+166/168] [kernel_thread+40/56]
Dec 15 12:08:30 phylum kernel: kupdated      D 00000282  5664     6      1             9     5 (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sleep_on+61/80] [check_journal_end+294/556] [do_journal_end+178/2584] [flush_old_commits+267/304] [flush_old_commits+281/304]
Dec 15 12:08:30 phylum kernel: mdrecoveryd   S C138C000  6580     9      1             8     6 (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [md_thread+201/316] [kernel_thread+40/56]
Dec 15 12:08:30 phylum kernel: khubd         S C139DFDC  6000     8      1            10     9 (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [usb_hub_thread+127/168] [kernel_thread+40/56]
Dec 15 12:08:30 phylum kernel: kreiserfsd    S CA33DFB0  6064    10      1            24     8 (L-TLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [interruptible_sleep_on_timeout+66/92] [reiserfs_journal_commit_thread+153/208] [kernel_thread+40/56]
Dec 15 12:08:30 phylum kernel: devfsd        S C9DB4000  5964    24      1           206    10 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [devfsd_read+238/868] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: portmap       S 7FFFFFFF     0   206      1           328    24 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_poll+117/204] [do_poll+168/204] [sys_poll+473/748] [sys_socketcall+383/408]
Dec 15 12:08:30 phylum kernel: syslogd       S 7FFFFFFF  4752   328      1           331   206 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: klogd         R C455C000  4752   331      1           339   328 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [do_syslog+208/776] [kmsg_read+18/24] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: named         S C42A9FAC  5408   339      1   340     361   331 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_rt_sigsuspend+238/264] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: named         S CA16FF28  1248   340    339   343               (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_poll+168/204] [sys_poll+473/748] [do_softirq+75/160]
Dec 15 12:08:30 phylum kernel: named         S C4645FAC     0   341    340           342       (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_rt_sigsuspend+238/264] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: named         S CA1F9F88     0   342    340           343   341 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: named         S 7FFFFFFF     0   343    340                 342 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: slapd         S C3E97FAC  4752   361      1   364     366   339 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_rt_sigsuspend+238/264] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: slapd         S C3E09F28  6292   364    361   365               (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_poll+168/204] [sys_poll+473/748] [schedule+714/756]
Dec 15 12:08:30 phylum kernel: slapd         S 7FFFFFFF  2660   365    364                     (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: spamd         S 7FFFFFFF  4752   366      1           517   361 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: proxytest     S C2A07F88  5172   517      1           525   366 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: authdaemond.p S C29C1F28  1024   525      1   531     538   517 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: authdaemond.p S C299BF28  6332   526    525           527       (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: authdaemond.p S C2993F28  6332   527    525           528   526 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: authdaemond.p S C298BF28  6332   528    525           529   527 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: authdaemond.p S C2983F28  6332   529    525           531   528 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: authdaemond.p S C2979F28  6392   531    525                 529 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: couriertcpd   S 7FFFFFFF     4   538      1           542   525 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: courierlogger S C29CA000     0   542      1           552   538 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [pipe_wait+121/164] [pipe_read+191/544] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: couriertcpd   S 7FFFFFFF     0   552      1           555   542 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: courierlogger S C456A000     0   555      1           559   552 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [pipe_wait+121/164] [pipe_read+191/544] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: cupsd         S C2863F28  4752   559      1           783   555 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: dhcpd         S 7FFFFFFF  2656   783      1           793   559 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: inetd         S 7FFFFFFF   104   793      1           811   783 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: safe_mysqld   S 00000000  2656   811      1   843     870   793 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_wait4+860/908] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: mysqld        S 7FFFFFFF     0   843    811   844               (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: mysqld        S C1967F28  6292   844    843   846               (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_poll+168/204] [sys_poll+473/748] [sys_wait4+896/908]
Dec 15 12:08:30 phylum kernel: mysqld        S C1963FAC  4752   845    844           846       (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_rt_sigsuspend+238/264] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: mysqld        S C18F3FAC  6600   846    844                 845 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_rt_sigsuspend+238/264] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: netsaint      S C1871F88     0   870      1           916   811 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: pptpd         S 7FFFFFFF     0   916      1           919   870 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: privoxy       S 7FFFFFFF     0   919      1           924   916 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: qmail-send    S C168DF28  4600   924      1   934     929   919 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: tcpserver     S 7FFFFFFF  4600   928      1           936   929 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: splogger      S C1656000   160   929      1           928   924 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [pipe_wait+121/164] [pipe_read+191/544] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: splogger      S C164A000     0   931    924           932       (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [pipe_wait+121/164] [pipe_read+191/544] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: qmail-lspawn  S 7FFFFFFF  2532   932    924           933   931 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: qmail-rspawn  S 7FFFFFFF     0   933    924           934   932 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: qmail-clean   S C1688000     0   934    924                 933 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [pipe_wait+121/164] [pipe_read+191/544] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: rebootmgr     S 7FFFFFFF  4600   936      1           949   928 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [free_page_and_swap_cache+53/60] [schedule_timeout+23/148] [do_select+30/468] [do_select+412/468] [sys_select+800/1100]
Dec 15 12:08:30 phylum kernel: nmbd          S C0DEFF28  4584   949      1           951   936 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: smbd          S 7FFFFFFF  5076   951      1           954   949 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: slpd          S 7FFFFFFF  6068   954      1           957   951 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: smartd        S C09C3F88  5680   957      1           966   954 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: sshd          S 7FFFFFFF  2656   966      1  1327     991   957 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: rpc.statd     S 7FFFFFFF  2656   991      1           995   966 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: ntpd          S 7FFFFFFF  4692   995      1  1005    1001   991 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: rpc.nfsd      S 7FFFFFFF     0  1001      1          1007   995 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_poll+117/204] [do_poll+168/204] [sys_poll+473/748] [sys_sigreturn+182/224]
Dec 15 12:08:30 phylum kernel: ntpd          S CBD67FAC     0  1005    995                     (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_rt_sigsuspend+238/264] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: rpc.mountd    S 7FFFFFFF     0  1007      1          1026  1001 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_poll+117/204] [do_poll+168/204] [sys_poll+473/748] [sys_sigreturn+182/224]
Dec 15 12:08:30 phylum kernel: squid         S 00000000     0  1026      1  1031    1052  1007 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_wait4+860/908] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: squid         S CBC55F28     0  1031   1026  1043               (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_poll+168/204] [sys_poll+473/748] [filp_close+89/104]
Dec 15 12:08:30 phylum kernel: squid_redirec S 7FFFFFFF  2656  1036   1031          1039       (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [tcp_data_wait+212/304] [tcp_recvmsg+1060/1956] [lru_cache_del+8/24] [inet_recvmsg+58/84]
Dec 15 12:08:30 phylum kernel: squid_redirec S 7FFFFFFF  2656  1039   1031          1040  1036 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [tcp_data_wait+212/304] [tcp_recvmsg+1060/1956] [lru_cache_del+8/24] [inet_recvmsg+58/84]
Dec 15 12:08:30 phylum kernel: squid_redirec S 7FFFFFFF  2656  1040   1031          1041  1039 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [tcp_data_wait+212/304] [tcp_recvmsg+1060/1956] [lru_cache_del+8/24] [inet_recvmsg+58/84]
Dec 15 12:08:30 phylum kernel: squid_redirec S 7FFFFFFF     0  1041   1031          1042  1040 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [tcp_data_wait+212/304] [tcp_recvmsg+1060/1956] [lru_cache_del+8/24] [inet_recvmsg+58/84]
Dec 15 12:08:30 phylum kernel: squid_redirec S 7FFFFFFF  2656  1042   1031          1043  1041 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [tcp_data_wait+212/304] [tcp_recvmsg+1060/1956] [lru_cache_del+8/24] [inet_recvmsg+58/84]
Dec 15 12:08:30 phylum kernel: unlinkd       S CB808000     0  1043   1031                1042 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [pipe_wait+121/164] [pipe_read+191/544] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: proftpd       S CB559F28     0  1052      1          1062  1026 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: usb_perms     S CB42BF88     0  1062      1          1066  1052 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: atd           S CB0E7F88   152  1066      1          1069  1062 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: cron          S CB02DF88  2656  1069      1          1097  1066 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: apache        S C8739F28     0  1097      1  1119    1102  1069 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [generic_file_write+1217/1624] [sys_select+800/1100]
Dec 15 12:08:30 phylum kernel: apache-ssl    S C8417F28     8  1102      1  1141    1128  1097 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [do_select+412/468] [generic_file_write+1217/1624] [sys_select+800/1100]
Dec 15 12:08:30 phylum kernel: apache        S 7FFFFFFF     0  1103   1097          1105       (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache        S 7FFFFFFF     0  1105   1097          1106  1103 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache        S 7FFFFFFF  2656  1106   1097          1107  1105 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache        S 7FFFFFFF     0  1107   1097          1119  1106 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache        S 7FFFFFFF     0  1119   1097                1107 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: bash          S 00000000  4600  1128      1  1175    1129  1102 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_wait4+860/908] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: bash          S 00000000     0  1129      1  1201    1130  1128 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_wait4+860/908] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: bash          S 00000000     0  1130      1  1205    1131  1129 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [sys_wait4+860/908] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: getty         S 7FFFFFFF     0  1131      1          1132  1130 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [read_chan+834/1644] [tty_read+174/216] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: getty         S 7FFFFFFF     0  1132      1          1135  1131 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [read_chan+834/1644] [tty_read+174/216] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: getty         S 7FFFFFFF  2656  1135      1                1132 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [read_chan+834/1644] [tty_read+174/216] [sys_read+152/244] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: gcache        S 7FFFFFFF     0  1136   1102          1137       (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_packet+206/320] [skb_recv_datagram+175/204] [unix_accept+73/192] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache-ssl    S 7FFFFFFF    44  1137   1102          1138  1136 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache-ssl    S 7FFFFFFF  2656  1138   1102          1139  1137 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache-ssl    S 7FFFFFFF  2656  1139   1102          1140  1138 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache-ssl    S 7FFFFFFF  2656  1140   1102          1141  1139 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: apache-ssl    S 7FFFFFFF  2656  1141   1102                1140 (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [wait_for_connect+205/372] [tcp_accept+137/428] [inet_accept+42/308] [sys_accept+97/252]
Dec 15 12:08:30 phylum kernel: cp            R current      0  1175   1128                     (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule+100/756] [wait_buffer_until_released+174/216] [get_empty_nodes+292/432] [fix_nodes+347/1068] [is_tree_node+71/80]
Dec 15 12:08:30 phylum kernel: sync          D CA0CBC44  1632  1201   1129                     (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [__down+81/152] [__down_failed+11/20] [.text.lock.super+123/237] [fsync_dev+34/52] [sys_sync+10/16]
Dec 15 12:08:30 phylum kernel: tail          S C72A1F88     0  1205   1130                     (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+115/148] [process_timeout+0/72] [sys_nanosleep+268/388] [system_call+51/56]
Dec 15 12:08:30 phylum kernel: sshd          S 7FFFFFFF   196  1327    966  1328               (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [unix_stream_data_wait+168/224] [unix_stream_recvmsg+389/928] [sock_recvmsg+55/168] [sock_read+135/144]
Dec 15 12:08:30 phylum kernel: sshd          S 7FFFFFFF  2532  1328   1327                     (NOTLB)
Dec 15 12:08:30 phylum kernel: Call Trace:    [schedule_timeout+23/148] [do_select+412/468] [sys_select+800/1100] [system_call+51/56]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  init

>>EIP; c12f5f28 <_end+f838e4/c593a1c>   <=====
Proc;  keventd

>>EIP; c12d8000 <_end+f659bc/c593a1c>   <=====
Proc;  ksoftirqd_CPU

>>EIP; c12d4000 <_end+f619bc/c593a1c>   <=====
Proc;  kswapd

>>EIP; c12d2000 <_end+f5f9bc/c593a1c>   <=====
Proc;  bdflush

>>EIP; 00000282 Before first symbol   <=====
Proc;  kupdated

>>EIP; 00000282 Before first symbol   <=====
Proc;  mdrecoveryd

>>EIP; c138c000 <_end+10199bc/c593a1c>   <=====
Proc;  khubd

>>EIP; c139dfdc <_end+102b998/c593a1c>   <=====
Proc;  kreiserfsd

>>EIP; ca33dfb0 <_end+9fcb96c/c593a1c>   <=====
Proc;  devfsd

>>EIP; c9db4000 <_end+9a419bc/c593a1c>   <=====
Proc;  portmap

>>EIP; 7fffffff Before first symbol   <=====
Proc;  syslogd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  klogd

>>EIP; c455c000 <_end+41e99bc/c593a1c>   <=====
Proc;  named

>>EIP; c42a9fac <_end+3f37968/c593a1c>   <=====
Proc;  named

>>EIP; ca16ff28 <_end+9dfd8e4/c593a1c>   <=====
Proc;  named

>>EIP; c4645fac <_end+42d3968/c593a1c>   <=====
Proc;  named

>>EIP; ca1f9f88 <_end+9e87944/c593a1c>   <=====
Proc;  named

>>EIP; 7fffffff Before first symbol   <=====
Proc;  slapd

>>EIP; c3e97fac <_end+3b25968/c593a1c>   <=====
Proc;  slapd

>>EIP; c3e09f28 <_end+3a978e4/c593a1c>   <=====
Proc;  slapd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  spamd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  proxytest

>>EIP; c2a07f88 <_end+2695944/c593a1c>   <=====
Proc;  authdaemond.p

>>EIP; c29c1f28 <_end+264f8e4/c593a1c>   <=====
Proc;  authdaemond.p

>>EIP; c299bf28 <_end+26298e4/c593a1c>   <=====
Proc;  authdaemond.p

>>EIP; c2993f28 <_end+26218e4/c593a1c>   <=====
Proc;  authdaemond.p

>>EIP; c298bf28 <_end+26198e4/c593a1c>   <=====
Proc;  authdaemond.p

>>EIP; c2983f28 <_end+26118e4/c593a1c>   <=====
Proc;  authdaemond.p

>>EIP; c2979f28 <_end+26078e4/c593a1c>   <=====
Proc;  couriertcpd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  courierlogger

>>EIP; c29ca000 <_end+26579bc/c593a1c>   <=====
Proc;  couriertcpd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  courierlogger

>>EIP; c456a000 <_end+41f79bc/c593a1c>   <=====
Proc;  cupsd

>>EIP; c2863f28 <_end+24f18e4/c593a1c>   <=====
Proc;  dhcpd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  inetd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  safe_mysqld

>>EIP; 00000000 Before first symbol
Proc;  mysqld

>>EIP; 7fffffff Before first symbol   <=====
Proc;  mysqld

>>EIP; c1967f28 <_end+15f58e4/c593a1c>   <=====
Proc;  mysqld

>>EIP; c1963fac <_end+15f1968/c593a1c>   <=====
Proc;  mysqld

>>EIP; c18f3fac <_end+1581968/c593a1c>   <=====
Proc;  netsaint

>>EIP; c1871f88 <_end+14ff944/c593a1c>   <=====
Proc;  pptpd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  privoxy

>>EIP; 7fffffff Before first symbol   <=====
Proc;  qmail-send

>>EIP; c168df28 <_end+131b8e4/c593a1c>   <=====
Proc;  tcpserver

>>EIP; 7fffffff Before first symbol   <=====
Proc;  splogger

>>EIP; c1656000 <_end+12e39bc/c593a1c>   <=====
Proc;  splogger

>>EIP; c164a000 <_end+12d79bc/c593a1c>   <=====
Proc;  qmail-lspawn

>>EIP; 7fffffff Before first symbol   <=====
Proc;  qmail-rspawn

>>EIP; 7fffffff Before first symbol   <=====
Proc;  qmail-clean

>>EIP; c1688000 <_end+13159bc/c593a1c>   <=====
Proc;  rebootmgr

>>EIP; 7fffffff Before first symbol   <=====
Proc;  nmbd

>>EIP; c0deff28 <_end+a7d8e4/c593a1c>   <=====
Proc;  smbd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  slpd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  smartd

>>EIP; c09c3f88 <_end+651944/c593a1c>   <=====
Proc;  sshd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  rpc.statd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  ntpd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  rpc.nfsd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  ntpd

>>EIP; cbd67fac <_end+b9f5968/c593a1c>   <=====
Proc;  rpc.mountd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  squid

>>EIP; 00000000 Before first symbol
Proc;  squid

>>EIP; cbc55f28 <_end+b8e38e4/c593a1c>   <=====
Proc;  squid_redirec

>>EIP; 7fffffff Before first symbol   <=====
Proc;  squid_redirec

>>EIP; 7fffffff Before first symbol   <=====
Proc;  squid_redirec

>>EIP; 7fffffff Before first symbol   <=====
Proc;  squid_redirec

>>EIP; 7fffffff Before first symbol   <=====
Proc;  squid_redirec

>>EIP; 7fffffff Before first symbol   <=====
Proc;  unlinkd

>>EIP; cb808000 <_end+b4959bc/c593a1c>   <=====
Proc;  proftpd

>>EIP; cb559f28 <_end+b1e78e4/c593a1c>   <=====
Proc;  usb_perms

>>EIP; cb42bf88 <_end+b0b9944/c593a1c>   <=====
Proc;  atd

>>EIP; cb0e7f88 <_end+ad75944/c593a1c>   <=====
Proc;  cron

>>EIP; cb02df88 <_end+acbb944/c593a1c>   <=====
Proc;  apache

>>EIP; c8739f28 <_end+83c78e4/c593a1c>   <=====
Proc;  apache-ssl

>>EIP; c8417f28 <_end+80a58e4/c593a1c>   <=====
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache

>>EIP; 7fffffff Before first symbol   <=====
Proc;  bash

>>EIP; 00000000 Before first symbol
Proc;  bash

>>EIP; 00000000 Before first symbol
Proc;  bash

>>EIP; 00000000 Before first symbol
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====
Proc;  getty

>>EIP; 7fffffff Before first symbol   <=====
Proc;  gcache

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache-ssl

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache-ssl

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache-ssl

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache-ssl

>>EIP; 7fffffff Before first symbol   <=====
Proc;  apache-ssl

>>EIP; 7fffffff Before first symbol   <=====
Proc;  cp

>>EIP; 0000000c Before first symbol   <=====
Proc;  sync

>>EIP; ca0cbc44 <_end+9d59600/c593a1c>   <=====
Proc;  tail

>>EIP; c72a1f88 <_end+6f2f944/c593a1c>   <=====
Proc;  sshd

>>EIP; 7fffffff Before first symbol   <=====
Proc;  sshd

>>EIP; 7fffffff Before first symbol   <=====


1 warning issued.  Results may not be reliable.

--------------070006010202030900080708--

