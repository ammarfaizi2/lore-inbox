Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286765AbRL1HHT>; Fri, 28 Dec 2001 02:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286768AbRL1HG7>; Fri, 28 Dec 2001 02:06:59 -0500
Received: from adsl-63-199-104-197.dsl.lsan03.pacbell.net ([63.199.104.197]:13573
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S286765AbRL1HGv>; Fri, 28 Dec 2001 02:06:51 -0500
From: "Phil Oester" <kernel@theoesters.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.17 still croaks under heavy load
Date: Thu, 27 Dec 2001 23:06:50 -0800
Message-ID: <001101c18f6e$38b40160$6400a8c0@philxp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have a webserver running Zope (specifically the ZEO db) which dies every
few days with no messages in syslog.  Locks up so tight a powercycle is
required to recover.  System has 1gb RAM, 2xSMP, kernel configured with
4gb highmem.  

Since the kernel doesn't provide any info in syslog when it dies, I just
ran a vmstat 30 to a file and waited for the next untimely demise.
Here's what happened when it died last time.  Note the sudden surge in
disk activity (bi) 

   procs                      memory    swap          io     system
cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us
sy  id
 0  1  0  33312  10356   5252 696940   0   0    20     1 1649  1603   6
2  92
 0  1  0  33312  10352   5236 696564   0   0    26     3 1593  1548   3
2  94
 0  1  0  33312  10276   5236 696600   0   0     9     1 1639  1596   5
2  92
 0  2  0  33312  16932   5236 694304   0   0    11     3 1702  1709   7
4  89
 0  1  0  33312  12644   5236 698784   0   0    10     2 1560  1513   3
2  95
 0  1  0  33312  10456   5236 700600   0   0    14     3 1487  1443   6
2  93
 0  1  0  33504  10452   5236 700652   0   1     3     1 1806  1785   5
2  92
 0  1  0  33504  10468   5236 699992   0   0     5     3 2118  2116   6
3  91
 0  1  0  33692  10484   5232 699312   0   5     1     8 3146  3215   7
5  88
 1  0  0  33692  10544   5232 698832   0   1     0     3 3377  3457  10
5  85
 1  0  0  33692  10468   5232 697804   0   3     2     3 3636  3721   8
5  87
 1  0  0  33692  10420   5232 697876   0   2     2     4 1662  1609  35
3  63
 1  0  0  33692   9540   5232 698940   0   0     7     1  752   624  46
2  52
 1  0  0  33692   9592   5232 698900   0   1     6     4  397   372  50
1  49
 1  0  0  33692   9504   5232 698980   0   0     2     1  136   284  49
1  49
 1  0  0  33692   9492   5292 698992   0   3   741     4  215   467  50
1  49
 1  0  0  34000  12624   5296 695936   0   6   547    10  236   408  49
1  49
 1  0  0  34000  21912   5300 678984   1   0   499     6 1992  2112  55
7  38
 1  0  0  34000   9976   5300 693104   0   0   517    13  320   413  49
1  49
 1  0  0  34000  11916   5300 691128   1   0   561     3  289   413  53
1  46
 1  0  0  34000  10172   5296 692100   0   0   497     5  288   374  49
1  49
 1  0  0  34000  22012   5296 680216   0   0   556     1  309   421  50
1  49
 1  0  0  34000   9544   5296 692804   0   0   584     3  306   433  50
1  49
 1  0  0  34000  10816   5296 696748   0   0   469     1  414   522  51
3  46
<death>

I'd be more than willing to collect any other data required here, just
let me know what would be of assistance.  Note though that I only have
remote access to this box, so getting magic sysrq info could be
difficult/impossible (tho I do have console access if that helps).

Thanks,

Phil Oester

