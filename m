Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261927AbTDANQX>; Tue, 1 Apr 2003 08:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261941AbTDANQW>; Tue, 1 Apr 2003 08:16:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:2054 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261927AbTDANQW>; Tue, 1 Apr 2003 08:16:22 -0500
Date: Tue, 1 Apr 2003 14:27:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Peter Oberparleiter <Peter.Oberparleiter@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partition check order in fs/partition/check.c?
Message-ID: <20030401142743.C30470@flint.arm.linux.org.uk>
Mail-Followup-To: Peter Oberparleiter <Peter.Oberparleiter@gmx.de>,
	linux-kernel@vger.kernel.org
References: <200304010934.h319Y5TR270722@d06relay02.portsmouth.uk.ibm.com> <20030401113503.A30470@flint.arm.linux.org.uk> <200304011316.h31DFwTR039380@d06relay02.portsmouth.uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200304011316.h31DFwTR039380@d06relay02.portsmouth.uk.ibm.com>; from Peter.Oberparleiter@gmx.de on Tue, Apr 01, 2003 at 03:14:56PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 03:14:56PM +0200, Peter Oberparleiter wrote:
> Hm, what do you think of these additional checks:
> 
> 1. Check for overlap of partitions

That's something which should be done for any partitioning method imho.
I have heard of some situations where, on x86 machines, the DOS and
ext2 filesystems overlapped, but somehow managed to keep working for
a considerable period of time.  Then when it all goes wrong, the user
blamed Linux for screwing their DOS/Windows partition.

This might be an acceptable way out of this problem.

> 2. Check for number of recognized partitions (i.e. size != 0) > 0 

If the checksum seems to be correct and you mis-parse an x86 bios
partition table as powertec, chances are that you'll have a non-zero
size word somewhere in that sector.

> 3. Check for struct ptec_partition.unused1, unused2, unused5 == 0
> (assuming they default to zero)

Unfortunately they don't default to zero.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

