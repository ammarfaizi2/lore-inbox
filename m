Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbUDBCN0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUDBCN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:13:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:9370
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263553AbUDBCNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:13:24 -0500
Date: Fri, 2 Apr 2004 04:13:23 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402021323.GP18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040402011804.GL18585@dualathlon.random> <20040401173014.Z22989@build.pdx.osdl.net> <20040402013547.GM18585@dualathlon.random> <20040401180441.B22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401180441.B22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 06:04:41PM -0800, Chris Wright wrote:
> * Andrea Arcangeli (andrea@suse.de) wrote:
> > what you missed is that after you locked_vm -= you don't free anything,
> > you only unmap them from the address space which means nothing in terms
> > of amount if pinned ram.
> 
> doesn't it free the huge page right there?  each page gets
> huge_page_released, right?

that has nothing to do with freeing the page, that's just releasing 1
refcount, because you dropped the pte mapping, the page is still there
healthy in the pagecache ready for somebody else to shmat. If you were
right then a shmdt+shmat would corrupt the SGA.

Your patch breaks local security and it's trivial to DoS a machine with
it applied as far as I can tell.
