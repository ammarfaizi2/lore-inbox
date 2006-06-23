Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932893AbWFWGpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbWFWGpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932894AbWFWGpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:45:03 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:59142 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S932893AbWFWGpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:45:01 -0400
Date: Fri, 23 Jun 2006 14:43:59 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
In-Reply-To: <20060622213050.fc753e91.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606231434480.15807@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060620233941.49ba2223.akpm@osdl.org> <Pine.LNX.4.64.0606231159540.2904@raven.themaw.net>
 <20060622213050.fc753e91.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 5, autolearn=not spam)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006, Andrew Morton wrote:

> On Fri, 23 Jun 2006 12:14:09 +0800 (WST)
> Ian Kent <raven@themaw.net> wrote:
> 
> > > 
> > > Also, did you consider broadening the ->d_revalidate() semantics?  It
> > > appears that all implementations return 0 or 1.  You could teach the VFS to
> > > also recognise and act upon a -ve return value, and do this trickery within
> > > the autofs d_revalidate(), perhaps?
> > > 
> > 
> > Yep and I've now done this.
> > I think this is in fact the only way to do it.
> 
> Below is the combined patch for reviewing purposes.
> 
> Removing that __always_inline saves 30-odd bytes.  I suspect that removing
> it would be a performance loss in this case.  But I'll make it just
> `inline' because __always_inline is peculiar, and people will wonder what's
> special about this function.
> 

Thanks Andrew.
The combined diff is exactly what I'm trying to achieve.

I marked the function __always_inline because several other functions 
that appear to be frequently called from this code path are also declared 
this way. Hopefully someone with more experience of this area of the VFS 
will recommend the best choice.

Ian

