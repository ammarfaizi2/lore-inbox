Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTEaHIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264183AbTEaHIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:08:25 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:24823 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S264182AbTEaHIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:08:24 -0400
Date: Sat, 31 May 2003 08:24:00 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Russell King <rmk@arm.linux.org.uk>
cc: Jun Sun <jsun@mvista.com>, <linux-kernel@vger.kernel.org>,
       Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Properly implement flush_dcache_page in 2.4?  (Or is it   
 possible?)
In-Reply-To: <20030531001458.H9419@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0305310822200.1461-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 May 2003, Russell King wrote:
> 
> I don't see a reason to worry about privately mapped pages on the i_mmap
> list since they are private, and therefore shouldn't be updated with
> modifications to other mappings, which I'd have thought would include
> writes to the file (although I'm not so sure atm.)

Be not so sure.  vmas on the private i_mmap list can still contain
shared pages, which should see writes to the file; but of course their
already-COWed private pages won't see subsequent writes to the file.

Hugh


