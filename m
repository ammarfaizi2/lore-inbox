Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbUBECsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 21:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266431AbUBECsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 21:48:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:14802 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266428AbUBECry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 21:47:54 -0500
Date: Wed, 4 Feb 2004 18:47:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Keith Mannthey <kmannth@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: [Bugme-new] [Bug 2019] New: Bug from the mm subsystem involving
 X  (fwd)
In-Reply-To: <1075948401.13163.19077.camel@dyn318004bld.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0402041844100.2086@home.osdl.org>
References: <51080000.1075936626@flay> <Pine.LNX.4.58.0402041539470.2086@home.osdl.org>
 <60330000.1075939958@flay> <64260000.1075941399@flay>
 <Pine.LNX.4.58.0402041639420.2086@home.osdl.org> <20040204165620.3d608798.akpm@osdl.org>
 <Pine.LNX.4.58.0402041719300.2086@home.osdl.org>
 <1075946211.13163.18962.camel@dyn318004bld.beaverton.ibm.com> 
 <Pine.LNX.4.58.0402041800320.2086@home.osdl.org>
 <1075948401.13163.19077.camel@dyn318004bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Feb 2004, Keith Mannthey wrote:
> 
> I tried Andrews VM_IO patch earlier today but it didn't fix the
> problem.  

Yeah, that patch is not actually converting the pfn_valid() users to only
trust VM_IO, it only does a few special cases (notably the follow_pages()  
thing, which wasn't the issue here).

So the patch would have to be expanded to cover _all_ of the page table
following functions. It probably isn't that much, just looking for code
that checks for PageReserved() will pinpoint the needed users pretty well.

So I think the VM_IO approach could fix this, but it would need to be 
fleshed out more. In the meantime, fixing pfn_valid() is definitely the 
right thing to do.

			Linus
