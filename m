Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWDCD2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWDCD2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 23:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWDCD2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 23:28:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51375 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751291AbWDCD2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 23:28:46 -0400
In-Reply-To: <17456.30621.579579.483287@cse.unsw.edu.au>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfs-admin@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] knfsd: Correct reserved reply space for read requests.
MIME-Version: 1.0
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OF8E2FDC8A.57540B9E-ON88257145.0010DA43-88257145.0012B720@us.ibm.com>
From: Marc Eshel <eshel@almaden.ibm.com>
Date: Sun, 2 Apr 2006 20:28:33 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0.1HF18 | February 28, 2006) at
 04/02/2006 23:28:43,
	Serialize complete at 04/02/2006 23:28:43
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nfs-admin@lists.sourceforge.net wrote on 04/02/2006 06:17:17 PM:

> On Thursday March 30, eshel@almaden.ibm.com wrote:
> > Hi Neil
> > Can we use this opportunity to change NFSSVC_MAXBLKSIZE from 32K to 
64K to 
> > match RPCSVC_MAXPAYLOAD. It makes real difference in I/O performance 
(we 
> > will still be saving half the space we used to allocate :).
> > Thanks, Marc. 
> 
> Maybe... but why not 128K ??
 
Yes, It would be nice to be able to match the Linux client side that can 
go to 1MB. 

> There is certainly room to increase NFSSVC_MAXBLKSIZE, but I feel that
> it needs to be done together with a more detailed look at consequences
> in the network layer, particularly TCP window sizes.  I wouldn't mind
> making a CONFIG_ tunable without that detailed look, but making it a
> fixed change I feel less comfortable about.

Like you said it will need match more work to do it right and also not 
waste space for all RPC request to which the maximum possible size is 
allocated up front. But until than way not take advantage of this minor 
change that can give us significant performance improvement. I run with 
NFSSVC_MAXBLKSIZE set to 64K (the only change I made) and saw 10%-15% 
improvement for NFS reads. Is there anyone out there that is looking at 
making this improvement ?

Marc.

> 
> NeilBrown
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting 
language
> that extends applications into web and mobile media. Attend the live 
webcast
> and join the prime developer group breaking into this new coding 
territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs

