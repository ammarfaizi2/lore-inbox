Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136593AbREIQ3b>; Wed, 9 May 2001 12:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136589AbREIQ3U>; Wed, 9 May 2001 12:29:20 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:17131 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S136588AbREIQ3L>; Wed, 9 May 2001 12:29:11 -0400
Message-ID: <3AF97062.42465A53@austin.ibm.com>
Date: Wed, 09 May 2001 11:29:22 -0500
From: "Andrew M. Theurer" <atheurer@austin.ibm.com>
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Linux 2.4 Scalability, Samba, and Netbench
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am evaluating Linux 2.4 SMP scalability, using Netbench(r) as a
workload with Samba, and I wanted to get some feedback on results so
far.  I would appreciate comments and any suggestions for improving
scalability on this workload.

The environment consists of an Intel Profusion based SMP with 8 x 700
Mhz Xeon, 1 Mb L2, 14+ GB ram, ServeRAID, 8 Intel ethernet cards (IBM
Netfinity 8500R).  There are 16 500 Mhz PII, 128 MB clients running
Windows NT.  I tested for uniprocessor, 2-way, and 4-way SMP
configurations.  Future plans including testing 8-way performance when
more test clients are available.  Netbench(r) 7.01 was used with the
enterprise disk suite test.  The test was modified to use 2 engines per
client, and the range of test clients was changed from 1-60 to 8-16 
(for 2P & 4P) and 4-12 (for uniprocessor).

My initial results for linux 2.4.0, ext2 are as follows:

		[UP]	[2P]	[4P]
	08	149
	12	199
	16	227	236	260
# Eng	20	193	272	317	Mbps
	24	223	283	369
	28		285	396
	32		285	405

Same test, but with IRQ to processor affinity for 2P & 4P on the 8
ethernet cards:
		  	[2P]	[4P]
	16		231	259
# Eng	20		278	297
	24		293	320	Mbps
	28		297	365
	32		299	399*
	*Still investigating; we had some cpu idle time
	 on the 4P/32 engines, but not on test configuration
	 with out IRQ aff.

And for linux 2.4.3 with reiserfs:
		[UP]	[2P]	[4P]
	08	130
	12	190
	16	203	210	231
# Eng	20	190	235	279
	24	200	249	319	Mbps
	28		239	360
	32		251	335

Same, but with IRQ affinity for 2P & 4P on the 8 ethernet cards:
			[2P]	[4P]
	16		224	236
# Eng	20		220	308
	24		252	331	Mbps
	28		269	375
	32		267	382

 --All results in Mbps, using Netbench(r) 7.0.1 and Samba 2.0.7
 --Netbench(r) is available at http://www.netbench.com

I would like to help improve SMP scalability on this workload.  If you
have questions or comments about the above results, or if you are
conducting similar tests, please send email to
lse-tech@lists.sourceforge.net.  I have some ideas on my next steps,
but would like to discuss first.

Regards,

Andrew Theurer
