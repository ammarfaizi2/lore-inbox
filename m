Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTHSJ2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 05:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHSJ2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 05:28:34 -0400
Received: from aneto.able.es ([212.97.163.22]:15594 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263597AbTHSJ2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 05:28:33 -0400
Date: Tue, 19 Aug 2003 11:28:31 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: "J.A. Magallon" <jamagallon@able.es>, vda@port.imtp.ilyichevsk.odessa.ua,
       russo.lutions@verizon.net, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030819092831.GA9424@werewolf.able.es>
References: <3F41AA15.1020802@verizon.net> <200308190533.h7J5XoL06419@Port.imtp.ilyichevsk.odessa.ua> <20030818232024.20c16d1f.akpm@osdl.org> <20030819090541.GA9038@werewolf.able.es> <20030819021617.392f24f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030819021617.392f24f4.akpm@osdl.org>; from akpm@osdl.org on Tue, Aug 19, 2003 at 11:16:17 +0200
X-Mailer: Balsa 2.0.13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 08.19, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> >  > It was not.  Instead we have fadvise.  So it would be appropriate to
change
> > 
> >  Does this work in 2.4 ?
> >  If not, any patch flying around ?
> 
> No.  It would be fairly messy to implement in 2.4 because 2.4 does not have
> the per-inode radix trees for pagecache.  The implementation would need to
> walk every page attached to the inode just to shoot down a single page. 
> And all of it underneath the global pagecache lock.
> 
> But it is certainly possible.
> 

So could O_STREAMING be included in 2.4, and let people do things like

#if 2.4
	fcntl(...O_STREAMING...)
#else
	posix_fadvise()
#endif

Or, if fadvise just fails with error code in 2.4, 
	if (fadvise()<0)
		fcntl(O_STREAMING)

Or even:
	fadvise()
	fcntl(O_STREAMING):
and let whatever succeed...

Or is it too dirt ?

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-rc2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
