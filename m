Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264612AbSJRJiP>; Fri, 18 Oct 2002 05:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264615AbSJRJiP>; Fri, 18 Oct 2002 05:38:15 -0400
Received: from ns.suse.de ([213.95.15.193]:41482 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264612AbSJRJiO>;
	Fri, 18 Oct 2002 05:38:14 -0400
Date: Fri, 18 Oct 2002 11:44:14 +0200
From: Andi Kleen <ak@suse.de>
To: Crispin Cowan <crispin@wirex.com>
Cc: Andi Kleen <ak@suse.de>, hch@infradead.org, greg@kroah.com,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-security-module@wirex.com, davem@redhat.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018114414.A31774@wotan.suse.de>
References: <20021017201030.GA384@kroah.com.suse.lists.linux.kernel> <20021017211223.A8095@infradead.org.suse.lists.linux.kernel> <3DAFB260.5000206@wirex.com.suse.lists.linux.kernel> <20021018.000738.05626464.davem@redhat.com.suse.lists.linux.kernel> <3DAFC6E7.9000302@wirex.com.suse.lists.linux.kernel> <p73wuognlox.fsf@oldwotan.suse.de> <3DAFD61F.8090607@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DAFD61F.8090607@wirex.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 02:36:31AM -0700, Crispin Cowan wrote:
> So: does it help to specify that the sys_security arguments be (say) 
> "unsigned int"?  Then you can just zero-pad them, or truncate them.

Yes that works fine.

But the problem is when people pass pointers to structures and
copy_*_user them later. And they near always do. Structures need to be 
converted when they contain pointers or long long (on x86-64/ia64 long 
long has different alignment than ia32 long long)

> 
> And even if the 32bit emulation layer doesn't perfectly translate the 
> sys_security arguments: that just breaks LSM modules. It would not 
> surprise me that something like an application trying to talk to a 
> security module might not cleanly port from 32 to 64 bits. By carefully 

The application does not need to be ported. That's the whole point
of the emulation layer. Just the in kernel stuff needs to be.

> stating the assumptions (clean data types) most of these problems should 
> be addressed.

You can specify clean data types. But it's very likely that eventually
someone fucks up and adds something that needs to be translated
(at least it's very likely with such an 'designed to be extensible'
interface like you have) 

And then having a basic design that makes translation impossible would
be unfortunate.

-Andi
