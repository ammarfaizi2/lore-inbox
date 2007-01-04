Return-Path: <linux-kernel-owner+w=401wt.eu-S1030261AbXADXR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030261AbXADXR5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030262AbXADXR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:17:57 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35332 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030261AbXADXR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:17:56 -0500
Date: Thu, 4 Jan 2007 15:17:44 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Mitchell Blank Jr <mitch@sfgoth.com>, Al Viro <viro@ftp.linux.org.uk>,
       Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted
 bad_inode_ops return values
In-Reply-To: <20070104150651.5bafddfc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701041514470.3661@woody.osdl.org>
References: <20070104105430.1de994a7.akpm@osdl.org>
 <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk>
 <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk>
 <20070104215206.GZ17561@ftp.linux.org.uk> <20070104223856.GA79126@gaz.sfgoth.com>
 <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org> <20070104150651.5bafddfc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Andrew Morton wrote:
> 
> That's what I currently have queued.  It increases bad_inode.o text from 
> 200-odd bytes to 700-odd :(

Then I think we're ok. We do care about bytes, but we care more about 
bytes that actually ever hit the icache or dcache, and this will 
effectively do neither.

> <looks at sys_ni_syscall>

That one should be ok. System calls by definition have the same return 
type, since they all have the same call site. So that one really does fit 
the "argument types differ, but the return type is the same" case. 

		Linus
