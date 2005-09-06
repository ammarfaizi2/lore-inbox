Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbVIFD7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbVIFD7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 23:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIFD7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 23:59:46 -0400
Received: from smtp.istop.com ([66.11.167.126]:7145 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S932290AbVIFD7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 23:59:46 -0400
From: Daniel Phillips <phillips@istop.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: GFS, what's remaining
Date: Tue, 6 Sep 2005 00:02:40 -0400
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Lars Marowsky-Bree <lmb@suse.de>,
       Andi Kleen <ak@suse.de>, linux clustering <linux-cluster@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509052057.23807.phillips@istop.com> <200509052103.20519.dtor_core@ameritech.net>
In-Reply-To: <200509052103.20519.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509060002.40823.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 22:03, Dmitry Torokhov wrote:
> On Monday 05 September 2005 19:57, Daniel Phillips wrote:
> > On Monday 05 September 2005 12:18, Dmitry Torokhov wrote:
> > > On Monday 05 September 2005 10:49, Daniel Phillips wrote:
> > > > On Monday 05 September 2005 10:14, Lars Marowsky-Bree wrote:
> > > > > On 2005-09-03T01:57:31, Daniel Phillips <phillips@istop.com> wrote:
> > > > > > The only current users of dlms are cluster filesystems.  There
> > > > > > are zero users of the userspace dlm api.
> > > > >
> > > > > That is incorrect...
> > > >
> > > > Application users Lars, sorry if I did not make that clear.  The
> > > > issue is whether we need to export an all-singing-all-dancing dlm api
> > > > from kernel to userspace today, or whether we can afford to take the
> > > > necessary time to get it right while application writers take their
> > > > time to have a good think about whether they even need it.
> > >
> > > If Linux fully supported OpenVMS DLM semantics we could start thinking
> > > asbout moving our application onto a Linux box because our alpha server
> > > is aging.
> > >
> > > That's just my user application writer $0.02.
> >
> > What stops you from trying it with the patch?  That kind of feedback
> > would be worth way more than $0.02.
>
> We do not have such plans at the moment and I prefer spending my free
> time on tinkering with kernel, not rewriting some in-house application.
> Besides, DLM is not the only thing that does not have a drop-in
> replacement in Linux.
>
> You just said you did not know if there are any potential users for the
> full DLM and I said there are some.

I did not say "potential", I said there are zero dlm applications at the 
moment.  Nobody has picked up the prototype (g)dlm api, used it in an 
application and said "gee this works great, look what it does".

I also claim that most developers who think that using a dlm for application 
synchronization would be really cool are probably wrong.  Use sockets for 
synchronization exactly as for a single-node, multi-tasking application and 
you will end up with less code, more obviously correct code, probably more 
efficient and... you get an optimal, single-node version for free.

And I also claim that there is precious little reason to have a full-featured 
dlm in-kernel.  Being in-kernel has no benefit for a userspace application.  
But being in-kernel does add kernel bloat, because there will be extra 
features lathered on that are not needed by the only in-kernel user, the 
cluster filesystem.

In the case of your port, you'd be better off hacking up a userspace library 
to provide OpenVMS dlm semantics exactly, not almost.

By the way, you said "alpha server" not "alpha servers", was that just a slip?  
Because if you don't have a cluster then why are you using a dlm?

Regards,

Daniel
