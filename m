Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263782AbTGHPrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 11:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTGHPrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 11:47:31 -0400
Received: from ev2.cpe.orbis.net ([209.173.192.122]:25738 "EHLO srv.foo21.com")
	by vger.kernel.org with ESMTP id S263782AbTGHPrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 11:47:31 -0400
Date: Tue, 8 Jul 2003 11:02:06 -0500
From: Eric Varsanyi <e0216@foo21.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: epoll vs stdin/stdout
Message-ID: <20030708160206.GP9328@srv.foo21.com>
References: <20030707154823.GA8696@srv.foo21.com> <Pine.LNX.4.55.0307071153270.4704@bigblue.dev.mcafeelabs.com> <20030707194736.GF9328@srv.foo21.com> <Pine.LNX.4.55.0307071511550.4704@bigblue.dev.mcafeelabs.com> <Pine.LNX.4.55.0307071624550.4704@bigblue.dev.mcafeelabs.com> <20030708154636.GM9328@srv.foo21.com> <Pine.LNX.4.55.0307080840400.4544@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0307080840400.4544@bigblue.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 08:42:29AM -0700, Davide Libenzi wrote:
> It is not that events are delivered per-fd. If 3 and 4 refer to the same
> file* and you register both 3 and 4 with EPOLLIN, you'll get two events if
> an EPOLLIN happen. One for 3 and one for 4.

Agreed 100%, this is roughly what would happen with select() as well which      
IMO is good (not surprising behaviour) for event loop writers: it would         
return with both bits set. The EEXIST we were getting before this patch         
would be analogous to select() returning an error if you set 2 bits that        
where for fd's sharing an object (even across read/write bit vectors).          
                                                                                
One could argue at the logic of having 2 fd's get read events on a              
shared underlying object, but one read and the other write certainly            
makes sense as discussed earlier.                                               
                                                                                
Thanks again,                                                                   
-Eric Varsanyi                                                                  
