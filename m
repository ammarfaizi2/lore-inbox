Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTEaHjc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTEaHjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:39:32 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3078 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264189AbTEaHjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:39:31 -0400
Date: Sat, 31 May 2003 08:52:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it possible?)
Message-ID: <20030531085248.A19071@flint.arm.linux.org.uk>
Mail-Followup-To: Hugh Dickins <hugh@veritas.com>,
	Jun Sun <jsun@mvista.com>, linux-kernel@vger.kernel.org,
	Ralf Baechle <ralf@linux-mips.org>
References: <20030531001458.H9419@flint.arm.linux.org.uk> <Pine.LNX.4.44.0305310822200.1461-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0305310822200.1461-100000@localhost.localdomain>; from hugh@veritas.com on Sat, May 31, 2003 at 08:24:00AM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 31, 2003 at 08:24:00AM +0100, Hugh Dickins wrote:
> On Sat, 31 May 2003, Russell King wrote:
> > 
> > I don't see a reason to worry about privately mapped pages on the i_mmap
> > list since they are private, and therefore shouldn't be updated with
> > modifications to other mappings, which I'd have thought would include
> > writes to the file (although I'm not so sure atm.)
> 
> Be not so sure.  vmas on the private i_mmap list can still contain
> shared pages, which should see writes to the file; but of course their
> already-COWed private pages won't see subsequent writes to the file.

Hmm, looking at the posix spec (do we follow POSIX for mmap?) the
behaviour of MAP_PRIVATE mappings when the underlying file is modified
is unspecified.

I guess missing the cache handling for such mappings fits the POSIX
spec, and is equally as yucky as the current behaviour on CPUs which
don't require these flushes.

(unless someone tells me that POSIX is on drugs, I'm not going to be
that bothered about the MAP_PRIVATE case.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

