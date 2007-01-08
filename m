Return-Path: <linux-kernel-owner+w=401wt.eu-S1750858AbXAHXud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbXAHXud (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbXAHXuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:50:32 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52988 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbXAHXub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:50:31 -0500
Date: Mon, 8 Jan 2007 18:45:30 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070108234530.GD1269@filer.fsl.cs.sunysb.edu>
References: <20070108111852.ee156a90.akpm@osdl.org> <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu> <20070108230018.GB3756@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108230018.GB3756@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 05:00:18PM -0600, Michael Halcrow wrote:
> On Mon, Jan 08, 2007 at 03:51:31PM -0500, Erez Zadok wrote:
> > BTW, this is a problem with all stackable file systems, including
> > ecryptfs.  To be fair, our Unionfs users have come up against this
> > problem, usually for the first time they use Unionfs :-).
> 
> I suspect that the only reason why this has not yet surfaced as a
> major issue in eCryptfs is because nobody is bothering to manipulate
> the eCryptfs-encrypted lower files. The only code out there right now
> that can make sense of the files is in the eCryptfs kernel module.
 
Yeah, you got lucky :)
 
> > Detecting such processes may not be easy.  What to do with them,
> > once detected, is also unclear.  We welcome suggestions.
> 
> My first instinct is to say that stacked filesystem should not even
> begin to open the file if it is already opened by something other than
> the stacked filesystem (-EPERM with a message in the syslog about the
> problem).

That seems a rather bit too drastic, no?

> In the case when a stacked filesystem wants to open a file
> that is already opened by something other than the stacked filesystem,
> the stacked filesystem loses. Once the process closes the file, the
> process is hitherto prevented from accessing the file again (via the
> before-mentioned mechanism of hiding the lower namespace).
 
I'd much prefer to somehow link the related pages and invalidate other
"copies" (even after transformations such as encryption). Limiting when
files can be open just sounds nasty.
 
> Unionfs and eCryptfs share almost exactly the same namespace
> issues. Unionfs happens to be impacted by them more than eCryptfs
> because of the differences in how people actually access the files
> under the two filesystems.
 
Yep.
 
> > Jeff, I don't think it's acceptable to OOPS.
> 
> For now, stacked filesystems just need to stay on their toes. There
> are several places where assumptions need to be checked.

I think those places can eliminated by modifying the VFS a bit. Heck, it
might even make the NFS folks' lives easier :)

Josef "Jeff" Sipek.

-- 
Bad pun of the week: The formula 1 control computer suffered from a race
condition
