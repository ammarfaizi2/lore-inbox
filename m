Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264322AbTLEV3H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTLEV3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 16:29:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:6807 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264322AbTLEV3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 16:29:00 -0500
Date: Fri, 5 Dec 2003 13:21:37 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Jason Walker" <jason_walker@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unable to address 1GB RAM in 2.4.19 or later, part 2
Message-Id: <20031205132137.5a30001a.rddunlap@osdl.org>
In-Reply-To: <20031205164425.PYUC1942.imf22aec.mail.bellsouth.net@debian>
References: <20031205164425.PYUC1942.imf22aec.mail.bellsouth.net@debian>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Dec 2003 11:44:43 -0500 "Jason Walker" <jason_walker@bellsouth.net> wrote:

| leaving mem= off doesnt fix it. Looks like 2.4.18 doesnt even try to map it. As
| before, I have attached the entire dmesg's to this email


In the version of this below (from 2.4.18, dated 04 Dec 2003),
it says "128MB HIGHMEM available", but this log excerpt doesn't
show that, and looking at the attached log files also does not
show that.  Why the differences?

Also, both logs are reporting the same amount of memory found,
and neither one reports 1 GB.  What kernel finds 1 GB?

E.g.:
Memory: 13940k/16384k available (1020k kernel code, 2056k reserved, 273k data, 280k init, 0k highmem)


And on a highmem-enabled 1-GB system, only the top 128 MB is considered
as "highmem" by the kernel's implementation, so that part seems as
expected.


| ==> dmesg-2.4.18-4GB-nomem <==
| Linux version 2.4.18-4GB (root@mcp) (gcc version 2.95.4 20011002 (Debian
| prerelease)) #3 SMP Mon Apr 7 05:29:01 EDT 2003
| BIOS-provided physical RAM map:
|  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
|  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
| found SMP MP-table at 000f4ff0
| hm, page 000f4000 reserved twice.
| hm, page 000f5000 reserved twice.
| hm, page 000fb000 reserved twice.
| hm, page 000fc000 reserved twice.
| On node 0 totalpages: 4096
| 
| ==> dmesg-2.4.23-4GB-nomem <==
| Linux version 2.4.23-4GB (root@mcp) (gcc version 2.95.4 20011002 (Debian
| prerelease)) #1 SMP Wed Dec 3 10:28:26 EST 2003
| BIOS-provided physical RAM map:
|  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
|  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
| 0MB HIGHMEM available.
| 16MB LOWMEM available.
| found SMP MP-table at 000f4ff0
| hm, page 000f4000 reserved twice.
| hm, page 000f5000 reserved twice.
| hm, page 000fb000 reserved twice.
| 
| 
| 
| --- Forwarded Message ---
|  From: "Jason Walker" <jason_walker@bellsouth.net>
|  To: linux-kernel@vger.kernel.org
|  Sent: Thu, 04 Dec 2003 13:10:31 -0500
|  Subject: Unable to address 1GB RAM in 2.4.19 or later
| 
| I have run into an issue where I cannot address all of my 1GB of RAM. 2.4.18
| was the last kernel that can address all 1GB. All kernels since then appear to
| only be able to address 16mb of ram if I use the 4GB himem kernel option. Here
| is a snip of the dmesg on the working 2.4.18 and broken 2.4.23 kernels:
| 
| 
| ==> dmesg-2.4.18-4GB <==
| Linux version 2.4.18-4GB (root@mcp) (gcc version 2.95.4 20011002 (Debian
| prerelease)) #3 SMP Mon Apr 7 05:29:01 EDT 2003
| BIOS-provided physical RAM map:
|  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
|  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
| 128MB HIGHMEM available.
| found SMP MP-table at 000f4ff0
| hm, page 000f4000 reserved twice.
| hm, page 000f5000 reserved twice.
| hm, page 000fb000 reserved twice.
| hm, page 000fc000 reserved twice.
| 
| ==> dmesg-2.4.23-4GB <==
| Linux version 2.4.23-4GB (root@mcp) (gcc version 2.95.4 20011002 (Debian
| prerelease)) #1 SMP Wed Dec 3 10:28:26 EST 2003
| BIOS-provided physical RAM map:
|  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
|  BIOS-88: 0000000000100000 - 0000000001000000 (usable)
| user-defined physical RAM map:
|  user: 0000000000000000 - 000000000009f000 (usable)
|  user: 0000000000100000 - 0000000001000000 (usable)
| 0MB HIGHMEM available.
| 16MB LOWMEM available.
| found SMP MP-table at 000f4ff0
| 
| What concerns me about these is that even in the 2.4.18 kernel it only reports
| 128MB HIGHMEM in the dmesg, even though it does see all 1GB when booted (free
| confirms this). I am thinking 2.4.18 isnt detecting something properly either,
| but is only a problem in 2.4.19 and later.
| Both are SMP kernels. The hardware is a Compaq Proliant 5000R, quad pentium pro
| 200mhz (256k cache models).
| Any thoughts on this? Is there any other information needed to address this
| issue? Please let me know what I can do to assist in correcting this bug.


--
~Randy
MOTD:  Always include version info.
