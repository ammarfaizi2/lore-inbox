Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132585AbRDQULe>; Tue, 17 Apr 2001 16:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132590AbRDQULY>; Tue, 17 Apr 2001 16:11:24 -0400
Received: from bastard.inflicted.net ([216.10.33.10]:53005 "EHLO
	bastard.inflicted.net") by vger.kernel.org with ESMTP
	id <S132585AbRDQULO>; Tue, 17 Apr 2001 16:11:14 -0400
From: Jesse S Sipprell <jss@inflicted.net>
Date: Tue, 17 Apr 2001 16:10:36 -0400
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        proftpd-devel@proftpd.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417161036.A21620@bastard.inflicted.net>
In-Reply-To: <20010417170206.C2589096@informatics.muni.cz> <E14pXxg-0002cI-00@the-village.bc.nu> <20010417181524.E2589096@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010417181524.E2589096@informatics.muni.cz>; from kas@informatics.muni.cz on Tue, Apr 17, 2001 at 06:15:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 06:15:24PM +0200, Jan Kasprzak wrote:
> Alan Cox wrote:
> : > : but once a fixed BIOS is out for your board that would be a good first step.
> : > : If it still does it then, its worth digging for kernel naughties
> : > : 
> : > 	I don't think I have 686b southbridge. I have 686 (without "b"):
> : 
> : Ok. What revision of 3c90x card do you have ?
> : 
> PCI: Found IRQ 11 for device 00:0c.0
> 3c59x.c:LK1.1.13 27 Jan 2001  Donald Becker and others. http://www.scyld.com/network/vortex.html
> See Documentation/networking/vortex.txt
> eth0: 3Com PCI 3c905C Tornado at 0xa000,  00:50:da:06:95:21, IRQ 11
>   product code 5957 rev 00.13 date 07-17-99
>   8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
>   MII transceiver found at address 24, status 782d.
>   Enabling bus-master transmits and whole-frame receives.
> eth0: scatter/gather enabled. h/w checksums enabled
> 
> 	Some more progress: I now downgraded to proftpd without sendfile().
> The CPU usage is now nearly 100% (with ~170 FTP users; with sendfile()
> it was under 50% with >320 FTP users). But nevertheless, the downloaded
> images now seem to be OK.

After cursory examination of proftpd, it appears that there is a misuse of the
sendfile() call under Linux, which may be responsible for the corruption.  The
code was originally based on BSD semantics.  Under Linux, the offset argument
is not being used correctly to determine how much data has been sent in the
case of EINTR.

A patch will be coming out soon, as it is a fairly trivial fix.

-- 
"In the event of a failure, the system can be configured to automatically
restart itself.  This feature of Windows NT Server provides maximum system
up-time."  -- Reliability and Fault Tolerance in Windows NT Server, MSC
