Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265025AbTFTXP1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 19:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTFTXP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 19:15:26 -0400
Received: from air-2.osdl.org ([65.172.181.6]:54975 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265025AbTFTXPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 19:15:06 -0400
Subject: Re: 2.5.72: wall-clock time advancing too rapidly?
From: Andy Pfiffer <andyp@osdl.org>
To: Andreas Haumer <andreas@xss.co.at>
Cc: john stultz <johnstul@us.ibm.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3EF32223.6000207@xss.co.at>
References: <1056039012.3879.5.camel@andyp.pdx.osdl.net>
	 <1056058206.18644.532.camel@w-jstultz2.beaverton.ibm.com>
	 <3EF32223.6000207@xss.co.at>
Content-Type: text/plain
Organization: 
Message-Id: <1056151705.1162.114.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2003 16:28:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-20 at 08:02, Andreas Haumer wrote:
> john stultz wrote:
> > On Thu, 2003-06-19 at 09:10, Andy Pfiffer wrote:

> >>By "racing ahead rapidly", I mean this:
> >>
> >>	% date ; sleep 60 ; date
> >>	Thu Jun 19 09:04:29 PDT 2003
> >>	Thu Jun 19 09:05:29 PDT 2003
> >>	%
> >>
> >>returns in 35 seconds (measured with my eyeballs and cheap wristwatch).
> >>

> > Well, variants on a theme. Can I get more hardware info? Is this a
> > laptop? Are we running w/ Speed Step?
> >
> I had this symptom recently on an Asus PR-DLS533 mainboard
> (ServerWorks GCLE chipset) with linux-2.4.21 and found out
> it happens only if I had BIOS "USB legacy support" enabled.
> As soon as I disabled this BIOS option, the phenomenon
> disappeard.

Update:

1) USB legacy support setting in the BIOS had no effect on the problem.
2) adding "clock=pit" (as suggested elsewhere) worked around the
problem.

So, does this fit the symptoms of:
http://bugme.osdl.org/show_bug.cgi?id=827

The system is not a laptop, and SpeedStep related issues should not be
messing things up here.

% cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 0.000
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov 
pat pse36 mmx fxsr sse
bogomips        : 794.62

% lspci
00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04)
00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
00:09.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev
04)
01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)



