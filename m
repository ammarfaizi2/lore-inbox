Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262704AbVD2OPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVD2OPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 10:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262702AbVD2OPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 10:15:22 -0400
Received: from kanga.kvack.org ([66.96.29.28]:13191 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S262697AbVD2OPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 10:15:03 -0400
Date: Fri, 29 Apr 2005 10:14:37 -0400
From: Benjamin LaHaise <bcrl@kvack.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] unify semaphore implementations
Message-ID: <20050429141437.GA24617@kvack.org>
References: <20050428182926.GC16545@kvack.org> <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17009.33633.378204.859486@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:44:17AM +1000, Paul Mackerras wrote:
> You have made semaphores bigger and slower on the architectures that
> have load-linked/store-conditional instructions, which is at least
> ppc, ppc64, sparc64 and alpha.  Did you take the trouble to understand
> the ppc semaphore implementation?

The ppc implementation does have some good ideas that are worth using.  
It's hard to know which of the 23 versions were worth using, but I'm 
getting a picture where at least 2 variants are need.  The atomic ops 
variant should use the single counter as ppc does (why did nobody port 
that to x86?).  A spinlock version is needed at least by parisc.

> What changes do you want to make to the semaphore functionality?

There are at least two users who need asynchronous semaphore/mutex 
operations: aio_write (which needs to acquire i_sem), and nfs.  
Changing 23 different architectures and verifying that they are 
correct is next to impossible, so it makes sense to have at least 
some unification take place.

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
