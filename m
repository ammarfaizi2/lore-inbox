Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261509AbTCGLNq>; Fri, 7 Mar 2003 06:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261512AbTCGLNp>; Fri, 7 Mar 2003 06:13:45 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38056 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S261509AbTCGLNo>; Fri, 7 Mar 2003 06:13:44 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15976.33121.376178.675759@laputa.namesys.com>
Date: Fri, 7 Mar 2003 14:24:17 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Dawson Engler <engler@csl.stanford.edu>
Cc: akpm@digeo.com (Andrew Morton), linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] potential deadlocks
In-Reply-To: <200303040752.h247qOx20275@csl.stanford.edu>
References: <15971.9271.619893.597694@laputa.namesys.com>
	<200303040752.h247qOx20275@csl.stanford.edu>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-Emacs-Acronym: Excellent Manuals Are Clearly Suppressed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler writes:
 > > Andrew Morton writes:

[...]

Sorry for delay.

 > 
 > Do you mean calls to copy_*_user and kmalloc(GFP_WAIT) or did you have
 > something else in mind as well?

Yes. Imagine thread that tries to allocate memory with __GFP_FS while
keeping some file system locks. Now try_to_free_pages() calls
->writepage() method that tries to acquire the same lock. See, for
examples, comment before fs/ext3/inode.c:ext3_writepage(), or in
fs/dcache.c:shrink_dcache_memory().

 > 
 > > We have (incomplete) description of kernel lock ordering, which is
 > > centered around reiser4 locks, but also includes some core kernel stuff.
 > > 
 > > It is available at 
 > > 
 > > http://www.namesys.com/v4/lock-ordering.dot  --- source for Bell-Labs' dot(1)
 > > http://www.namesys.com/v4/lock-ordering.ps   --- postscript output, produced from the .dot source
 > 
 > Wonderful; thanks!
 > 

I would be glad to receive additions and corrections for this diagram.

 > 
 > 
 > 

Nikita.
