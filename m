Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266026AbUAEXhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266020AbUAEXhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:37:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:59265 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266026AbUAEXhC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:37:02 -0500
Date: Mon, 5 Jan 2004 15:36:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Diego Calleja <grundig@teleline.es>, Robert.L.Harris@rdlg.net,
       vherva@niksula.hut.fi, ihaquer@isec.pl, cliph@isec.pl,
       linux-kernel@vger.kernel.org
Subject: Re: mremap() bug IMHO not in 2.2
In-Reply-To: <20040105225508.GM2093@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0401051532510.5737@home.osdl.org>
References: <20040105145421.GC2247@rdlg.net> <Pine.LNX.4.58L.0401051323520.1188@logos.cnet>
 <20040105181053.6560e1e3.grundig@teleline.es> <20040105182607.GB2093@pasky.ji.cz>
 <20040105225508.GM2093@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Jan 2004, Petr Baudis wrote:
> 
> Actually, after looking at the code again, I'm now quite convinced 2.2
> has not this particular vulnerability. In order for the exploit to work,
> you'd need mremap() to relocate you.

Can somebody tell me (in private) what the exploit is in the first place?

The thing is, I can see the VM getting confused and creating a zero-sized 
vma, and I agree that it shouldn't do that. The fix is trivial. But I 
don't see where the claimed privilege escalation comes from. A zero-sized 
vma isn't ever going to be _useful_, since nothing will actually find it.

So yes, it creates some confusion in the VM layer, but it all seems 
benign. It's clearly a bug, but where does the security problem come in?

		Linus
