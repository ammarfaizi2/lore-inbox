Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbTBDJo1>; Tue, 4 Feb 2003 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267128AbTBDJo1>; Tue, 4 Feb 2003 04:44:27 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:36552 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S267203AbTBDJoG>;
	Tue, 4 Feb 2003 04:44:06 -0500
Date: Tue, 4 Feb 2003 10:53:34 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Daniel Forrest <forrest@lmcg.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 NFS server lock-up (SMP)
Message-ID: <20030204105334.H1584@fi.muni.cz>
References: <20030129133434.A1584@fi.muni.cz> <200301300700.h0U70RM05470@leinie.lmcg.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200301300700.h0U70RM05470@leinie.lmcg.wisc.edu>; from forrest@lmcg.wisc.edu on Thu, Jan 30, 2003 at 01:00:27AM -0600
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Forrest wrote:
: My guess is that this is related to a bug in garbage collection in
: lockd.  The breakpoint is when you pass 32 unique clients.  If you are
: able to recompile the kernel, try this patch:

	Hello again,

	unfortunately, my server crashed again yesterday even with this patch.
A co-worker of mine managed to catch the output of SysRQ+T - attached here.
All NFS daemons, lockd, one kjournald and few smbd's are stuck in the
"D" state. Maybe this is not a NFS-related problem (altough NFS is the
main load on this server).

	Any clues? Attached is dmesg output of sysrq+t (ran through ksymoops)
and the "ps axuw" output.

-Yenya

--------------------------------------------------------------------
ksymoops 2.4.5 on i686 2.4.20-acl.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20-acl/ (default)
     -m /boot/System.map-2.4.20-acl (specified)

c0177b2b>] [<c0177bf5>]
  [<c016f210>] [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c0199473>]
  [<c0199827>] [<c019fb85>] [<c01a17ca>] [<c0194f20>] [<c0194fee>] [<c02797ff>]
  [<c0194dc4>] [<c01058de>] [<c0194b70>]
nfsd          D F7E6C000  3988   867      1           866   868 (L-TLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c01d3374>] [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>]
  [<c016f210>] [<c0153e55>] [<c01552cb>] [<c0169635>] [<c023e590>] [<c014d722>]
  [<c019ed40>] [<c019b4c9>] [<c019ed40>] [<c0194f20>] [<c0196ba0>] [<c019ed40>]
  [<c019e94b>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>] [<c0194b70>]
nfsd          D 00003A00  4080   868      1           867   869 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c0169635>] [<c023e99e>] [<c023e590>] [<c014d722>]
  [<c019ed40>] [<c019b4c9>] [<c019ed40>] [<c0194f20>] [<c0196ba0>] [<c019ed40>]
  [<c019e94b>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>] [<c0194b70>]
nfsd          D 00003A00  3988   869      1           868   870 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c0169635>] [<c023e590>] [<c014d722>] [<c019ed40>]
  [<c019b4c9>] [<c019ed40>] [<c0194f20>] [<c0196ba0>] [<c019ed40>] [<c019e94b>]
  [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>] [<c0194b70>]
nfsd          D 00000000  3988   870      1           869   871 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c0199473>] [<c0199827>]
  [<c0195c13>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>]
  [<c0194b70>]
nfsd          D F56EA000  3464   871      1           870   872 (L-TLB)
Call Trace:    [<c01060d4>] [<c0106278>] [<c016f46c>] [<c0155e7f>] [<c0198fea>]
  [<c019f6df>] [<c01a1541>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>]
  [<c01058de>] [<c0194b70>]
nfsd          D 00000000  3988   872      1           871   874 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c0199473>] [<c0199827>]
  [<c0195c13>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>]
  [<c0194b70>]
nfsd          D F7EB0000  3988   874      1           872   875 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c0155ac6>] [<c016ebd2>] [<c0155e7f>] [<c0198fea>] [<c01958e8>]
  [<c019e1c6>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>]
  [<c0194b70>]
nfsd          D 00003A00  3464   875      1           874   877 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c0169635>] [<c023e590>] [<c014d722>] [<c019ed40>]
  [<c019b4c9>] [<c019ed40>] [<c0194f20>] [<c0196ba0>] [<c019ed40>] [<c019e94b>]
  [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>] [<c0194b70>]
lockd         D F681FAB0  4508   873      1   876     881   860 (L-TLB)
Call Trace:    [<c027b194>] [<c01abaa0>] [<c0115b2e>] [<c019c7dc>] [<c01a618f>]
  [<c01058de>] [<c01a5fe0>]
rpciod        S DBA151C0  5220   876    873                     (L-TLB)
Call Trace:    [<c02769c3>] [<c02773b0>] [<c02771e0>] [<c01058de>] [<c02771e0>]
nfsd          D F4108BC0  3960   877      1           875   878 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c0199473>] [<c0199827>]
  [<c0195c13>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>]
  [<c0194b70>]
nfsd          D 00000000  4052   878      1           877   879 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c0199473>] [<c0199827>]
  [<c019fb85>] [<c01a17ca>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>]
  [<c01058de>] [<c0194b70>]
nfsd          D C0324C40  3988   879      1           878   880 (L-TLB)
Call Trace:    [<c0115b2e>] [<c017e038>] [<c017933f>] [<c017943a>] [<c017474c>]
  [<c0169944>] [<c016cdb0>] [<c0199630>] [<c01698c0>] [<c0199ce1>] [<c01a10b0>]
  [<c01a260c>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>]
  [<c0194b70>]
nfsd          D 00000000  3988   880      1           879   881 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c0199473>] [<c0199827>]
  [<c0195c13>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>]
  [<c0194b70>]
nfsd          D 00000000  4024   881      1           880   873 (L-TLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c0199473>] [<c0199827>]
  [<c0195c13>] [<c0194f20>] [<c0194fee>] [<c02797ff>] [<c0194dc4>] [<c01058de>]
  [<c0194b70>]
rpc.mountd    S F72F8080  4252   889      1           905   864 (NOTLB)
Call Trace:    [<c0115a1e>] [<c019c85a>] [<c019cf4d>] [<c0208d68>] [<c01953ca>]
  [<c0144f43>] [<c01525a1>] [<c0147e45>] [<c0144fbd>] [<c01076af>]
sendmail      S 00000058  4900   905      1           914   889 (NOTLB)
Call Trace:    [<c0115108>] [<c0115050>] [<c014e4cc>] [<c014e951>] [<c01076af>]
sendmail      S 00000000  5160   914      1           924   905 (NOTLB)
Call Trace:    [<c0106942>] [<c010e1f2>] [<c01076af>]
nsrexecd      S C02C6440  2404   924      1   925     933   914 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115153>] [<c02251a7>] [<c014e4cc>] [<c014e951>]
  [<c01076af>]
nsrexecd      S 00000000  2400   925    924                     (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c02251a7>] [<c0115050>] [<c014e4cc>]
  [<c014e951>] [<c01076af>]
gpm           S 0001753E  5360   933      1           942   924 (NOTLB)
Call Trace:    [<c0115108>] [<c0115050>] [<c014e4cc>] [<c014e951>] [<c01076af>]
crond         S 00000000  4440   942      1           951   933 (NOTLB)
Call Trace:    [<c0115108>] [<c0115050>] [<c0122140>] [<c01076af>]
smbd          S 00000000  4436   951      1 16544     955   942 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115153>] [<c02251a7>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01076af>]
nmbd          S C02C6440  4696   955      1           973   951 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01076af>]
atd           S F4A4FF40  2404   973      1           983   955 (NOTLB)
Call Trace:    [<c0144f43>] [<c0115108>] [<c0115050>] [<c0122140>] [<c01076af>]
mingetty      S 203A6E69  2400   983      1           984   973 (NOTLB)
Call Trace:    [<c0129100>] [<c0115153>] [<c01c481a>] [<c01bb248>] [<c01bad16>]
  [<c01b6946>] [<c013c5b3>] [<c012abe3>] [<c01076af>]
mingetty      S 203A6E69  5096   984      1           985   983 (NOTLB)
Call Trace:    [<c0129100>] [<c0115153>] [<c01bb248>] [<c01bad16>] [<c01b6946>]
  [<c013c5b3>] [<c012abe3>] [<c01076af>]
mingetty      S 203A6E69  4744   985      1           986   984 (NOTLB)
Call Trace:    [<c0129100>] [<c0115153>] [<c01bb248>] [<c01bad16>] [<c01b6946>]
  [<c013c5b3>] [<c012abe3>] [<c01076af>]
mingetty      S 203A6E69  5096   986      1         16329   985 (NOTLB)
Call Trace:    [<c0129100>] [<c0115153>] [<c01bb248>] [<c01bad16>] [<c01b6946>]
  [<c013c5b3>] [<c012abe3>] [<c01076af>]
smbd          S 00000000     0  1155    951          1860       (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S C02C6440     0  1860    951          2266  1155 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c02251a7>] [<c0115050>] [<c01472b7>]
  [<c014e4cc>] [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S C02C6440     0  2266    951          2293  1860 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c02251a7>] [<c0115050>] [<c01472b7>]
  [<c014e4cc>] [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S 00000000  1376  2293    951          2414  2266 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
sshd          S 00000000     0  2323    833  2325    2366       (NOTLB)
Call Trace:    [<c0134d42>] [<c0115153>] [<c01bb406>] [<c01b7c33>] [<c014e4cc>]
  [<c014e951>] [<c01076af>]
bash          S 00000001  1376  2325   2323  2365               (NOTLB)
Call Trace:    [<c011c9e6>] [<c01b60a4>] [<c01076af>]
throughput    S 00000000     0  2365   2325                     (NOTLB)
Call Trace:    [<c0115108>] [<c0115050>] [<c0122140>] [<c01076af>]
sshd          S 00000000     0  2366    833  2368   14528  2323 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115153>] [<c01bb406>] [<c01b7c33>] [<c014e4cc>]
  [<c014e951>] [<c01076af>]
bash          S 00000000     0  2368   2366 14596               (NOTLB)
Call Trace:    [<c011c9e6>] [<c01b60a4>] [<c01076af>]
smbd          S 00000000     0  2414    951          2635  2293 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S C02C6440     0  2635    951          2804  2414 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c02251a7>] [<c0115050>] [<c01472b7>]
  [<c014e4cc>] [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S C02C6440     0  2804    951          2811  2635 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c02251a7>] [<c0115050>] [<c01472b7>]
  [<c014e4cc>] [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S 00000000  2400  2811    951          3978  2804 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S 00000000     0  3978    951          4173  2811 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S C02C6440     0  4173    951         13947  3978 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c02251a7>] [<c0115050>] [<c01472b7>]
  [<c014e4cc>] [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S C02C6440  2400 13947    951         13951  4173 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c02251a7>] [<c0115050>] [<c01472b7>]
  [<c014e4cc>] [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S 00000000  2400 13951    951         14247 13947 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          D 00003A00     0 14247    951         14354 13951 (NOTLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c0169635>] [<c0176f9f>] [<c0144f43>] [<c014d722>]
  [<c014de50>] [<c014dfbb>] [<c014de50>] [<c014ce3d>] [<c01076af>]
smbd          D 00000000     0 14354    951         14358 14247 (NOTLB)
Call Trace:    [<c020da66>] [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>]
  [<c016f210>] [<c0153e55>] [<c01552cb>] [<c0148672>] [<c0148a97>] [<c0148de9>]
  [<c0144f8f>] [<c01076af>]
smbd          S 00000000     0 14358    951         14359 14354 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S 00000000     0 14359    951         14360 14358 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S 00000000     0 14360    951         14362 14359 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115108>] [<c0115050>] [<c01472b7>] [<c014e4cc>]
  [<c014e951>] [<c01450b9>] [<c01076af>]
smbd          S 00000000     0 14362    951         16227 14360 (NOTLB)
Call Trace:    [<c0134d42>] [<c01092ac>] [<c0115108>] [<c0115050>] [<c01472b7>]
  [<c014e4cc>] [<c014e951>] [<c01450b9>] [<c01076af>]
sshd          S 00000000  2400 14528    833 14530   16225  2366 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115153>] [<c01bb406>] [<c01b7c33>] [<c014e4cc>]
  [<c014e951>] [<c01076af>]
bash          S 74614074     0 14530  14528                     (NOTLB)
Call Trace:    [<c0115153>] [<c01bb248>] [<c01bad16>] [<c01b6946>] [<c013c5b3>]
  [<c01076af>]
top           S 00000046     0 14596   2368                     (NOTLB)
Call Trace:    [<c0115108>] [<c0115050>] [<c01b7c33>] [<c014e4cc>] [<c014e951>]
  [<c01076af>]
sshd          S 00000000     0 16225    833 16228         14528 (NOTLB)
Call Trace:    [<c0134d42>] [<c0115153>] [<c01bb406>] [<c01b7c33>] [<c014e4cc>]
  [<c014e951>] [<c01076af>]
smbd          D C0147D5F     0 16227    951         16503 14362 (NOTLB)
Call Trace:    [<c0147d5f>] [<c01481e0>] [<c01060d4>] [<c0106278>] [<c0169330>]
  [<c014e121>] [<c014dfbb>] [<c014de50>] [<c014ce3d>] [<c01076af>]
bash          S 00000001     8 16228  16225 16418               (NOTLB)
Call Trace:    [<c011c9e6>] [<c01b60a4>] [<c01076af>]
bash          D 00003A00     0 16283      1         16584 16305 (NOTLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c0169635>] [<c0176f9f>] [<c0144f43>] [<c014d722>]
  [<c014de50>] [<c014dfbb>] [<c014de50>] [<c014ce3d>] [<c01076af>]
bash          D 00003A00  2400 16305      1         16283 16329 (NOTLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c0169635>] [<c0176e35>] [<c0176f9f>] [<c0144f43>]
  [<c014d722>] [<c014de50>] [<c014dfbb>] [<c014de50>] [<c014ce3d>] [<c01076af>]
bash          D 00000000     0 16329      1         16305   986 (NOTLB)
Call Trace:    [<c0108ee2>] [<c01060d4>] [<c0106278>] [<c014c196>] [<c0148775>]
  [<c0148a97>] [<c0148de9>] [<c0144f8f>] [<c01076af>]
screen        S 0809DED4   128 16418  16228 16419               (NOTLB)
Call Trace:    [<c010e1f2>] [<c01076af>]
screen        S C1C14000     0 16419  16418 16473               (NOTLB)
Call Trace:    [<c0115153>] [<c01bb406>] [<c01b7c33>] [<c014e4cc>] [<c014e951>]
  [<c01076af>]
bash          S 00000000     0 16420  16419 16443   16447       (NOTLB)
Call Trace:    [<c011c9e6>] [<c01b60a4>] [<c01076af>]
mutt          D 00000286     0 16443  16420                     (NOTLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c012cf18>] [<c012cd80>] [<c013c5b3>] [<c01076af>]
bash          S 00000000     0 16447  16419 16632   16473 16420 (NOTLB)
Call Trace:    [<c011c9e6>] [<c01b60a4>] [<c01076af>]
bash          S 6140746F     0 16473  16419               16447 (NOTLB)
Call Trace:    [<c0115153>] [<c01bb248>] [<c01bad16>] [<c01b6946>] [<c013c5b3>]
  [<c01076af>]
smbd          D 00003A00  2400 16503    951         16544 16227 (NOTLB)
Call Trace:    [<c0115b2e>] [<c0177a68>] [<c0177b2b>] [<c0177bf5>] [<c016f210>]
  [<c0153e55>] [<c01552cb>] [<c0169635>] [<c0176f9f>] [<c0144f43>] [<c014d722>]
  [<c014de50>] [<c014dfbb>] [<c014de50>] [<c014ce3d>] [<c01076af>]
smbd          D C0147D5F  2408 16544    951               16503 (NOTLB)
Call Trace:    [<c0147d5f>] [<c01481e0>] [<c01060d4>] [<c0106278>] [<c0169330>]
  [<c014e121>] [<c014dfbb>] [<c014de50>] [<c014ce3d>] [<c01076af>]
login         S 00000000  4744 16584      1 16587         16283 (NOTLB)
Call Trace:    [<c011c9e6>] [<c01076af>]
bash          S 74614074     0 16587  16584                     (NOTLB)
Call Trace:    [<c0115153>] [<c01cbb84>] [<c01bb248>] [<c01bad16>] [<c01b6946>]
  [<c013c5b3>] [<c01076af>]
less          S 1B48313B     0 16632  16447                     (NOTLB)
Call Trace:    [<c0115153>] [<c020fd23>] [<c01bb248>] [<c01bad16>] [<c01b6946>]
  [<c013c5b3>] [<c01076af>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  nfsd

>>EIP; f7e6c000 <_end+37ad55bc/3847a63c>   <=====

Trace; c01d3374 <__make_request+2a4/650>
Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c023e590 <udp_getfrag+0/110>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019b4c9 <nfsd_readdir+d9/1b0>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0196ba0 <nfsd_proc_readdir+a0/140>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019e94b <nfssvc_decode_readdirargs+4b/a0>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00003a00 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c023e99e <udp_sendmsg+27e/4b0>
Trace; c023e590 <udp_getfrag+0/110>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019b4c9 <nfsd_readdir+d9/1b0>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0196ba0 <nfsd_proc_readdir+a0/140>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019e94b <nfssvc_decode_readdirargs+4b/a0>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00003a00 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c023e590 <udp_getfrag+0/110>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019b4c9 <nfsd_readdir+d9/1b0>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0196ba0 <nfsd_proc_readdir+a0/140>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019e94b <nfssvc_decode_readdirargs+4b/a0>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00000000 Before first symbol

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c012cf18 <generic_file_read+a8/150>
Trace; c012cd80 <file_read_actor+0/f0>
Trace; c0199473 <nfsd_open+1c3/2a0>
Trace; c0199827 <nfsd_read+147/200>
Trace; c0195c13 <nfsd_proc_read+e3/1a0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; f56ea000 <_end+353535bc/3847a63c>   <=====

Trace; c01060d4 <__down+74/d0>
Trace; c0106278 <__down_failed+8/c>
Trace; c016f46c <.text.lock.inode+e7/13b>
Trace; c0155e7f <notify_change+2bf/2d1>
Trace; c0198fea <nfsd_setattr+3ea/5d0>
Trace; c019f6df <nfsd3_proc_setattr+7f/f0>
Trace; c01a1541 <nfs3svc_decode_sattrargs+91/100>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00000000 Before first symbol

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c012cf18 <generic_file_read+a8/150>
Trace; c012cd80 <file_read_actor+0/f0>
Trace; c0199473 <nfsd_open+1c3/2a0>
Trace; c0199827 <nfsd_read+147/200>
Trace; c0195c13 <nfsd_proc_read+e3/1a0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; f7eb0000 <_end+37b195bc/3847a63c>   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c0155ac6 <inode_setattr+86/110>
Trace; c016ebd2 <ext3_setattr+152/430>
Trace; c0155e7f <notify_change+2bf/2d1>
Trace; c0198fea <nfsd_setattr+3ea/5d0>
Trace; c01958e8 <nfsd_proc_setattr+78/100>
Trace; c019e1c6 <nfssvc_decode_sattrargs+66/a0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00003a00 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c023e590 <udp_getfrag+0/110>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019b4c9 <nfsd_readdir+d9/1b0>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0196ba0 <nfsd_proc_readdir+a0/140>
Trace; c019ed40 <nfssvc_encode_entry+0/d0>
Trace; c019e94b <nfssvc_decode_readdirargs+4b/a0>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  lockd

>>EIP; f681fab0 <_end+3648906c/3847a63c>   <=====

Trace; c027b194 <svc_recv+2d4/640>
Trace; c01abaa0 <nlm4svc_encode_res+0/60>
Trace; c0115b2e <sleep_on+4e/80>
Trace; c019c7dc <exp_readlock+1c/40>
Trace; c01a618f <lockd+1af/2c0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c01a5fe0 <lockd+0/2c0>
Proc;  rpciod

>>EIP; dba151c0 <_end+1b67e77c/3847a63c>   <=====

Trace; c02769c3 <__rpc_schedule+b3/170>
Trace; c02773b0 <rpciod+1d0/240>
Trace; c02771e0 <rpciod+0/240>
Trace; c01058de <kernel_thread+2e/40>
Trace; c02771e0 <rpciod+0/240>
Proc;  nfsd

>>EIP; f4108bc0 <_end+33d7217c/3847a63c>   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c012cf18 <generic_file_read+a8/150>
Trace; c012cd80 <file_read_actor+0/f0>
Trace; c0199473 <nfsd_open+1c3/2a0>
Trace; c0199827 <nfsd_read+147/200>
Trace; c0195c13 <nfsd_proc_read+e3/1a0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00000000 Before first symbol

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c012cf18 <generic_file_read+a8/150>
Trace; c012cd80 <file_read_actor+0/f0>
Trace; c0199473 <nfsd_open+1c3/2a0>
Trace; c0199827 <nfsd_read+147/200>
Trace; c019fb85 <nfsd3_proc_read+f5/1c0>
Trace; c01a17ca <nfs3svc_decode_readargs+2a/100>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; c0324c40 <irq_desc+440/3800>   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c017e038 <log_wait_commit+58/a0>
Trace; c017933f <journal_stop+15f/1e0>
Trace; c017943a <journal_force_commit+7a/90>
Trace; c017474c <ext3_force_commit+4c/80>
Trace; c0169944 <ext3_sync_file+84/c0>
Trace; c016cdb0 <ext3_writepage+0/350>
Trace; c0199630 <nfsd_sync+70/b0>
Trace; c01698c0 <ext3_sync_file+0/c0>
Trace; c0199ce1 <nfsd_commit+a1/b0>
Trace; c01a10b0 <nfsd3_proc_commit+a0/120>
Trace; c01a260c <nfs3svc_decode_commitargs+2c/100>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00000000 Before first symbol

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c012cf18 <generic_file_read+a8/150>
Trace; c012cd80 <file_read_actor+0/f0>
Trace; c0199473 <nfsd_open+1c3/2a0>
Trace; c0199827 <nfsd_read+147/200>
Trace; c0195c13 <nfsd_proc_read+e3/1a0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  nfsd

>>EIP; 00000000 Before first symbol

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c012cf18 <generic_file_read+a8/150>
Trace; c012cd80 <file_read_actor+0/f0>
Trace; c0199473 <nfsd_open+1c3/2a0>
Trace; c0199827 <nfsd_read+147/200>
Trace; c0195c13 <nfsd_proc_read+e3/1a0>
Trace; c0194f20 <nfsd_dispatch+0/1e2>
Trace; c0194fee <nfsd_dispatch+ce/1e2>
Trace; c02797ff <svc_process+45f/550>
Trace; c0194dc4 <nfsd+254/3b0>
Trace; c01058de <kernel_thread+2e/40>
Trace; c0194b70 <nfsd+0/3b0>
Proc;  rpc.mountd

>>EIP; f72f8080 <_end+36f6163c/3847a63c>   <=====

Trace; c0115a1e <interruptible_sleep_on+4e/80>
Trace; c019c85a <exp_writelock+5a/100>
Trace; c019cf4d <exp_addclient+4d/280>
Trace; c0208d68 <sys_sendto+e8/100>
Trace; c01953ca <sys_nfsservctl+21a/4e0>
Trace; c0144f43 <cp_new_stat64+f3/120>
Trace; c01525a1 <dput+21/180>
Trace; c0147e45 <path_release+15/40>
Trace; c0144fbd <sys_stat64+4d/80>
Trace; c01076af <system_call+33/38>
Proc;  sendmail

>>EIP; 00000058 Before first symbol   <=====

Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  sendmail

>>EIP; 00000000 Before first symbol

Trace; c0106942 <sys_sigreturn+102/120>
Trace; c010e1f2 <sys_pause+12/20>
Trace; c01076af <system_call+33/38>
Proc;  nsrexecd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  nsrexecd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c0115050 <process_timeout+0/60>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  gpm

>>EIP; 0001753e Before first symbol   <=====

Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  crond

>>EIP; 00000000 Before first symbol

Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c0122140 <sys_nanosleep+d0/160>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  nmbd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  atd

>>EIP; f4a4ff40 <_end+346b94fc/3847a63c>   <=====

Trace; c0144f43 <cp_new_stat64+f3/120>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c0122140 <sys_nanosleep+d0/160>
Trace; c01076af <system_call+33/38>
Proc;  mingetty

>>EIP; 203a6e69 Before first symbol   <=====

Trace; c0129100 <do_no_page+80/240>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01c481a <set_cursor+7a/a0>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c012abe3 <sys_munmap+43/70>
Trace; c01076af <system_call+33/38>
Proc;  mingetty

>>EIP; 203a6e69 Before first symbol   <=====

Trace; c0129100 <do_no_page+80/240>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c012abe3 <sys_munmap+43/70>
Trace; c01076af <system_call+33/38>
Proc;  mingetty

>>EIP; 203a6e69 Before first symbol   <=====

Trace; c0129100 <do_no_page+80/240>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c012abe3 <sys_munmap+43/70>
Trace; c01076af <system_call+33/38>
Proc;  mingetty

>>EIP; 203a6e69 Before first symbol   <=====

Trace; c0129100 <do_no_page+80/240>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c012abe3 <sys_munmap+43/70>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  sshd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb406 <normal_poll+106/160>
Trace; c01b7c33 <tty_poll+83/a0>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00000001 Before first symbol   <=====

Trace; c011c9e6 <sys_wait4+126/400>
Trace; c01b60a4 <tty_check_change+44/a0>
Trace; c01076af <system_call+33/38>
Proc;  throughput

>>EIP; 00000000 Before first symbol

Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c0122140 <sys_nanosleep+d0/160>
Trace; c01076af <system_call+33/38>
Proc;  sshd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb406 <normal_poll+106/160>
Trace; c01b7c33 <tty_poll+83/a0>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011c9e6 <sys_wait4+126/400>
Trace; c01b60a4 <tty_check_change+44/a0>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c02c6440 <contig_page_data+220/340>   <=====

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c02251a7 <tcp_poll+37/190>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00003a00 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c0176f9f <ext3_permission+1f/30>
Trace; c0144f43 <cp_new_stat64+f3/120>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c014de50 <filldir64+0/110>
Trace; c014dfbb <sys_getdents64+5b/c0>
Trace; c014de50 <filldir64+0/110>
Trace; c014ce3d <sys_fcntl64+5d/c0>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c020da66 <skb_copy_datagram_iovec+46/260>
Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0148672 <link_path_walk+4f2/710>
Trace; c0148a97 <path_lookup+37/40>
Trace; c0148de9 <__user_walk+49/60>
Trace; c0144f8f <sys_stat64+1f/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c01092ac <do_IRQ+dc/e0>
Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01472b7 <pipe_poll+37/80>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01450b9 <sys_fstat64+49/80>
Trace; c01076af <system_call+33/38>
Proc;  sshd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb406 <normal_poll+106/160>
Trace; c01b7c33 <tty_poll+83/a0>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 74614074 Before first symbol   <=====

Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c01076af <system_call+33/38>
Proc;  top

>>EIP; 00000046 Before first symbol   <=====

Trace; c0115108 <schedule_timeout+58/b0>
Trace; c0115050 <process_timeout+0/60>
Trace; c01b7c33 <tty_poll+83/a0>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  sshd

>>EIP; 00000000 Before first symbol

Trace; c0134d42 <__alloc_pages+42/180>
Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb406 <normal_poll+106/160>
Trace; c01b7c33 <tty_poll+83/a0>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c0147d5f <permission+4f/a0>   <=====

Trace; c0147d5f <permission+4f/a0>
Trace; c01481e0 <link_path_walk+60/710>
Trace; c01060d4 <__down+74/d0>
Trace; c0106278 <__down_failed+8/c>
Trace; c0169330 <ext3_readdir+0/450>
Trace; c014e121 <.text.lock.readdir+5/a4>
Trace; c014dfbb <sys_getdents64+5b/c0>
Trace; c014de50 <filldir64+0/110>
Trace; c014ce3d <sys_fcntl64+5d/c0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00000001 Before first symbol   <=====

Trace; c011c9e6 <sys_wait4+126/400>
Trace; c01b60a4 <tty_check_change+44/a0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00003a00 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c0176f9f <ext3_permission+1f/30>
Trace; c0144f43 <cp_new_stat64+f3/120>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c014de50 <filldir64+0/110>
Trace; c014dfbb <sys_getdents64+5b/c0>
Trace; c014de50 <filldir64+0/110>
Trace; c014ce3d <sys_fcntl64+5d/c0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00003a00 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c0176e35 <__ext3_permission+b5/200>
Trace; c0176f9f <ext3_permission+1f/30>
Trace; c0144f43 <cp_new_stat64+f3/120>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c014de50 <filldir64+0/110>
Trace; c014dfbb <sys_getdents64+5b/c0>
Trace; c014de50 <filldir64+0/110>
Trace; c014ce3d <sys_fcntl64+5d/c0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c0108ee2 <__global_cli+62/70>
Trace; c01060d4 <__down+74/d0>
Trace; c0106278 <__down_failed+8/c>
Trace; c014c196 <.text.lock.namei+35/4df>
Trace; c0148775 <link_path_walk+5f5/710>
Trace; c0148a97 <path_lookup+37/40>
Trace; c0148de9 <__user_walk+49/60>
Trace; c0144f8f <sys_stat64+1f/80>
Trace; c01076af <system_call+33/38>
Proc;  screen

>>EIP; 0809ded4 Before first symbol   <=====

Trace; c010e1f2 <sys_pause+12/20>
Trace; c01076af <system_call+33/38>
Proc;  screen

>>EIP; c1c14000 <_end+187d5bc/3847a63c>   <=====

Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb406 <normal_poll+106/160>
Trace; c01b7c33 <tty_poll+83/a0>
Trace; c014e4cc <do_select+11c/240>
Trace; c014e951 <sys_select+331/4b0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011c9e6 <sys_wait4+126/400>
Trace; c01b60a4 <tty_check_change+44/a0>
Trace; c01076af <system_call+33/38>
Proc;  mutt

>>EIP; 00000286 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c012cf18 <generic_file_read+a8/150>
Trace; c012cd80 <file_read_actor+0/f0>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 00000000 Before first symbol

Trace; c011c9e6 <sys_wait4+126/400>
Trace; c01b60a4 <tty_check_change+44/a0>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 6140746f Before first symbol   <=====

Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; 00003a00 Before first symbol   <=====

Trace; c0115b2e <sleep_on+4e/80>
Trace; c0177a68 <start_this_handle+f8/170>
Trace; c0177b2b <new_handle+4b/70>
Trace; c0177bf5 <journal_start+a5/d0>
Trace; c016f210 <ext3_dirty_inode+110/130>
Trace; c0153e55 <__mark_inode_dirty+b5/c0>
Trace; c01552cb <update_atime+6b/70>
Trace; c0169635 <ext3_readdir+305/450>
Trace; c0176f9f <ext3_permission+1f/30>
Trace; c0144f43 <cp_new_stat64+f3/120>
Trace; c014d722 <vfs_readdir+a2/100>
Trace; c014de50 <filldir64+0/110>
Trace; c014dfbb <sys_getdents64+5b/c0>
Trace; c014de50 <filldir64+0/110>
Trace; c014ce3d <sys_fcntl64+5d/c0>
Trace; c01076af <system_call+33/38>
Proc;  smbd

>>EIP; c0147d5f <permission+4f/a0>   <=====

Trace; c0147d5f <permission+4f/a0>
Trace; c01481e0 <link_path_walk+60/710>
Trace; c01060d4 <__down+74/d0>
Trace; c0106278 <__down_failed+8/c>
Trace; c0169330 <ext3_readdir+0/450>
Trace; c014e121 <.text.lock.readdir+5/a4>
Trace; c014dfbb <sys_getdents64+5b/c0>
Trace; c014de50 <filldir64+0/110>
Trace; c014ce3d <sys_fcntl64+5d/c0>
Trace; c01076af <system_call+33/38>
Proc;  login

>>EIP; 00000000 Before first symbol

Trace; c011c9e6 <sys_wait4+126/400>
Trace; c01076af <system_call+33/38>
Proc;  bash

>>EIP; 74614074 Before first symbol   <=====

Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c01cbb84 <rs_flush_chars+64/80>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c01076af <system_call+33/38>
Proc;  less

>>EIP; 1b48313b Before first symbol   <=====

Trace; c0115153 <schedule_timeout+a3/b0>
Trace; c020fd23 <netif_receive_skb+c3/180>
Trace; c01bb248 <write_chan+158/210>
Trace; c01bad16 <read_chan+276/650>
Trace; c01b6946 <tty_read+116/150>
Trace; c013c5b3 <sys_read+a3/150>
Trace; c01076af <system_call+33/38>


1 warning issued.  Results may not be reliable.

--------------------------------------------------------------------
Mon Feb  3 18:17:10 CET 2003
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1336  408 ?        S    Jan30   0:15 init
root         2  0.0  0.0     0    0 ?        SW   Jan30   0:00 [keventd]
root         3  0.0  0.0     0    0 ?        SWN  Jan30   0:00 [ksoftirqd_CPU0]
root         4  0.0  0.0     0    0 ?        SWN  Jan30   0:00 [ksoftirqd_CPU1]
root         5  0.0  0.0     0    0 ?        SW   Jan30   1:49 [kswapd]
root         6  0.0  0.0     0    0 ?        SW   Jan30   0:00 [bdflush]
root         7  0.0  0.0     0    0 ?        SW   Jan30   0:09 [kupdated]
root         8  0.0  0.0     0    0 ?        SW<  Jan30   0:00 [mdrecoveryd]
root         9  0.0  0.0     0    0 ?        SW<  Jan30   0:00 [raid1d]
root        10  0.0  0.0     0    0 ?        SW<  Jan30   0:00 [raid1d]
root        11  0.0  0.0     0    0 ?        SW<  Jan30   0:00 [raid1d]
root        12  0.0  0.0     0    0 ?        SW<  Jan30   0:00 [raid1d]
root        13  0.0  0.0     0    0 ?        SW<  Jan30   0:00 [raid1d]
root        14  0.0  0.0     0    0 ?        SW<  Jan30   0:00 [raid1d]
root        15  0.0  0.0     0    0 ?        SW   Jan30   0:12 [kjournald]
root       257  0.0  0.0     0    0 ?        SW   Jan30   0:00 [kjournald]
root       258  0.0  0.0     0    0 ?        SW   Jan30   1:53 [kjournald]
root       259  0.1  0.0     0    0 ?        DW   Jan30   7:55 [kjournald]
root       260  0.0  0.0     0    0 ?        SW   Jan30   0:00 [kjournald]
root       646  0.0  0.0  1752  632 ?        S    Jan30   0:44 syslogd -m 0
root       650  0.0  0.0  1336  348 ?        S    Jan30   0:00 klogd -x
rpc        661  0.0  0.0  1492  540 ?        S    Jan30   1:04 portmap
rpcuser    680  0.0  0.0  4396  828 ?        S    Jan30   0:01 rpc.statd
nscd       791  0.0  0.1 17152 1628 ?        S    Jan30   1:48 /usr/sbin/nscd
root       806  0.0  0.1  8604 1548 ?        S    Jan30   0:10 /usr/sbin/snmpd -s -l /dev/null -P /var/run/snmpd -a
named      815  0.0  0.1 13184 1796 ?        S    Jan30   0:06 named -u named -t /var/named
root       833  0.0  0.0  3236  844 ?        S    Jan30   0:04 /usr/sbin/sshd
root       847  0.0  0.0  3576  652 ?        S    Jan30   0:00 xinetd-ipv6 -stayalive -reuse -pidfile /var/run/xinetd.pid
root       860  0.0  0.3 15020 3732 ?        S    Jan30   2:35 rpc.rquotad
root       864  0.1  0.0     0    0 ?        DW   Jan30   6:54 [nfsd]
root       865  0.1  0.0     0    0 ?        DW   Jan30   6:40 [nfsd]
root       866  0.1  0.0     0    0 ?        DW   Jan30   6:37 [nfsd]
root       867  0.1  0.0     0    0 ?        DW   Jan30   6:39 [nfsd]
root       868  0.1  0.0     0    0 ?        DW   Jan30   7:05 [nfsd]
root       869  0.1  0.0     0    0 ?        DW   Jan30   6:46 [nfsd]
root       870  0.1  0.0     0    0 ?        DW   Jan30   6:46 [nfsd]
root       871  0.1  0.0     0    0 ?        DW   Jan30   6:44 [nfsd]
root       872  0.1  0.0     0    0 ?        DW   Jan30   7:15 [nfsd]
root       874  0.1  0.0     0    0 ?        DW   Jan30   6:50 [nfsd]
root       875  0.1  0.0     0    0 ?        DW   Jan30   6:44 [nfsd]
root       873  0.0  0.0     0    0 ?        DW   Jan30   0:09 [lockd]
root       876  0.0  0.0     0    0 ?        SW   Jan30   0:00 [rpciod]
root       877  0.1  0.0     0    0 ?        DW   Jan30   6:39 [nfsd]
root       878  0.1  0.0     0    0 ?        DW   Jan30   6:43 [nfsd]
root       879  0.1  0.0     0    0 ?        DW   Jan30   6:31 [nfsd]
root       880  0.1  0.0     0    0 ?        DW   Jan30   7:07 [nfsd]
root       881  0.1  0.0     0    0 ?        DW   Jan30   7:05 [nfsd]
root       889  0.9  3.0 33508 31952 ?       S    Jan30  55:55 rpc.mountd
root       905  0.0  0.0  6468  952 ?        S    Jan30   0:09 sendmail: accepting connections
smmsp      914  0.0  0.0  6284  876 ?        S    Jan30   0:00 sendmail: Queue runner@01:00:00 for /var/spool/clientmqueue
root       924  0.0  0.0  4596  496 ?        S    Jan30   0:00 /usr/sbin/nsrexecd
root       925  0.0  0.0  4604  680 ?        S    Jan30   0:00 /usr/sbin/nsrexecd
root       933  0.0  0.0  1372  356 ?        S    Jan30   0:01 gpm -t ps/2 -m /dev/mouse
root       942  0.0  0.0  2936  464 ?        S    Jan30   0:00 crond
root       951  0.0  0.0  7524  608 ?        S    Jan30   0:00 smbd -D
root       955  0.0  0.0  2668  836 ?        S    Jan30   0:12 nmbd -D
daemon     973  0.0  0.0  1324  392 ?        S    Jan30   0:00 /usr/sbin/atd
root       982  0.0  0.0  1328  352 ttyS0    S    Jan30   0:00 /sbin/agetty ttyS0 38400 vt100
root       983  0.0  0.0  1316  324 tty1     S    Jan30   0:00 /sbin/mingetty tty1
root       984  0.0  0.0  1316  324 tty2     S    Jan30   0:00 /sbin/mingetty tty2
root       985  0.0  0.0  1316  324 tty3     S    Jan30   0:00 /sbin/mingetty tty3
root       986  0.0  0.0  1316  324 tty4     S    Jan30   0:00 /sbin/mingetty tty4
root      1155  0.0  0.5 11192 5352 ?        S    Jan30   0:01 smbd -D
root      1860  0.0  0.1 10936 1968 ?        S    Jan31   0:00 smbd -D
root      2266  0.0  0.5 10912 5192 ?        S    Jan31   0:00 smbd -D
root      2293  0.0  0.2 11208 2096 ?        S    Jan31   0:01 smbd -D
root      2323  0.0  0.0  8120  720 ?        S    Jan31   0:07 /usr/sbin/sshd
root      2325  0.0  0.0  5888  484 pts/0    S    Jan31   0:00 -bash
root      2365  0.0  0.1  5624 1664 pts/0    S    Jan31   0:27 /usr/bin/perl -w /usr/local/sbin/throughput eth0
root      2366  0.0  0.1  8332 1460 ?        S    Jan31   0:40 /usr/sbin/sshd
root      2368  0.0  0.1  5888 1188 pts/1    S    Jan31   0:00 -bash
root      2414  0.0  0.1 11228 1888 ?        S    Jan31   0:00 smbd -D
root      2635  0.0  0.4 10940 4424 ?        S    Jan31   0:00 smbd -D
root      2804  0.0  0.3 10752 3216 ?        S    Jan31   0:02 smbd -D
root      2811  0.0  0.0 11196  816 ?        S    Jan31   0:00 smbd -D
root      3978  0.0  0.5 10948 5448 ?        S    Feb01   0:00 smbd -D
root      4173  0.0  0.1 10900 1636 ?        S    Feb01   0:00 smbd -D
root     13947  0.0  0.6 10948 6576 ?        S    07:29   0:00 smbd -D
root     13951  0.0  0.6 10948 6260 ?        S    07:34   0:00 smbd -D
xxxxxx   14247  0.0  0.5 10948 5868 ?        D    13:03   0:00 smbd -D
xxxxxx   14354  0.0  0.4 10912 4660 ?        D    14:20   0:00 smbd -D
root     14358  0.0  0.4 10908 4520 ?        S    14:22   0:00 smbd -D
root     14359  0.0  0.4 10908 4524 ?        S    14:22   0:00 smbd -D
root     14360  0.0  0.4 10908 4528 ?        S    14:22   0:00 smbd -D
root     14362  0.0  0.4 10908 4548 ?        S    14:22   0:00 smbd -D
root     14528  0.0  0.2  8372 2384 ?        S    15:58   0:00 /usr/sbin/sshd
root     14530  0.0  0.1  6152 1892 pts/2    S    15:58   0:00 -bash
root     14596  0.2  0.0  3860 1032 pts/1    S    16:06   0:20 top
root     16225  0.0  0.2  8300 2360 ?        S    18:15   0:00 /usr/sbin/sshd
xxxxxx   16227  0.0  0.5 10912 5472 ?        D    18:15   0:00 smbd -D
root     16228  0.0  0.1  5888 1588 pts/3    S    18:15   0:00 -bash
root     16271  0.1  0.5 10944 5484 ?        S    18:16   0:00 smbd -D
root     16278  0.0  0.0  2560  596 pts/3    R    18:17   0:00 ps auxw
-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
