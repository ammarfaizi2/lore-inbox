Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWDCDrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWDCDrj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 23:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWDCDrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 23:47:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:21395 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964832AbWDCDri (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 23:47:38 -0400
From: Neil Brown <neilb@suse.de>
To: Marc Eshel <eshel@almaden.ibm.com>
Date: Mon, 3 Apr 2006 13:45:49 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17456.39533.920110.831056@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] knfsd: Correct reserved reply space for read requests.
In-Reply-To: message from Marc Eshel on Sunday April 2
References: <17456.30621.579579.483287@cse.unsw.edu.au>
	<OF8E2FDC8A.57540B9E-ON88257145.0010DA43-88257145.0012B720@us.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday April 2, eshel@almaden.ibm.com wrote:
> nfs-admin@lists.sourceforge.net wrote on 04/02/2006 06:17:17 PM:
> 
> > On Thursday March 30, eshel@almaden.ibm.com wrote:
> > > Hi Neil
> > > Can we use this opportunity to change NFSSVC_MAXBLKSIZE from 32K to 
> 64K to 
> > > match RPCSVC_MAXPAYLOAD. It makes real difference in I/O performance 
> (we 
> > > will still be saving half the space we used to allocate :).
> > > Thanks, Marc. 
> > 
> > Maybe... but why not 128K ??
>  
> Yes, It would be nice to be able to match the Linux client side that can 
> go to 1MB. 
> 
> > There is certainly room to increase NFSSVC_MAXBLKSIZE, but I feel that
> > it needs to be done together with a more detailed look at consequences
> > in the network layer, particularly TCP window sizes.  I wouldn't mind
> > making a CONFIG_ tunable without that detailed look, but making it a
> > fixed change I feel less comfortable about.
> 
> Like you said it will need match more work to do it right and also not 
> waste space for all RPC request to which the maximum possible size is 
> allocated up front. But until than way not take advantage of this minor 
> change that can give us significant performance improvement. I run with 
> NFSSVC_MAXBLKSIZE set to 64K (the only change I made) and saw 10%-15% 
> improvement for NFS reads. Is there anyone out there that is looking at 
> making this improvement ?

It was a fairly soft reservation of space, and we never actually tried
to use it all.
I don't see a clear problem with just making the change you mention,
but until I have thought through the implications (or until someone
else has and convinces me) I don't feel comfortable making the change.

It's on my todo list, but that doesn't promise a lot :-(
If someone else wants to try to convince me it is safe, and mention
tcp window sizes a couple of time, I'll probably be happy with it.

NeilBrown
