Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263336AbVGANVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbVGANVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbVGANVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:21:35 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:7996 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263336AbVGANVY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:21:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LxuJIYTc04YprxgaEMnMUg4SW/DfONwL4qoWSxBDFGldEgbsVMnUWZYVhnKBgDv0tDlJ6wRWwrozXC7I8ppS0Ka6NhaabfAQqaDNVKs2HlTdLDS5dGDMqj3KK/GDNhLVzgTxnWDjzCjmJIRs7zDV1cXw1HLobhkzjNKAqIHiZL0=
Message-ID: <a4e6962a050701062136435471@mail.gmail.com>
Date: Fri, 1 Jul 2005 08:21:23 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: FUSE merging?
Cc: akpm@osdl.org, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	 <20050630124622.7c041c0b.akpm@osdl.org>
	 <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	 <20050630235059.0b7be3de.akpm@osdl.org>
	 <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	 <20050701001439.63987939.akpm@osdl.org>
	 <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <20050701010229.4214f04e.akpm@osdl.org>
	 <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/05, Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > v9fs has a user-level server too.  Maybe it has been used in FUSE-like
> > scenarios more than NFS.

We've really only dabbled with v9fs and user-level file services,
mostly through interacting with Plan 9 From User Space applications
(http://www.plan9.us)  However, there are people actively improving
this area of functionality including providing an SDK to allow easy
creation of synthetic file systems.  That being said, there are many
aspects of v9fs which have been written/re-written with the express
purpose of providing support for such synthetics.

> 
> I think the p9 protocol is suffering from trying to be too generic.
> The FUSE kernel interface is probably slightly tied to the linux VFS,
> and would present problems if trying to port to other *NIX or god
> forbid some other OS family altogether.
> 

I don't know where 9P "suffers" from being too generic, it's just
well-designed and has done a good job of keeping things simple --
something that the plethora of over designed, bloated interfaces of
today could learn from.

> 
> > Plus NFS and v9fs work across the network...
> 
> Yes.  I consider that a drawback.  FUSE does data transfer very
> efficiently (single copy), without the heavy network infrastructure
> being in the way.
> 

I'll grant you this is something v9fs-2.0 suffers from, but its
something we are actively addressing in v9fs-2.1.  We're working more
towards the implementation that is present in the Plan 9 kernel, where
the core efficiently multiplexes the requests either directly to local
servers (in Plan 9's case via function call APIs) or encapsulates them
for shipping across the network.  The 9P interface is used for both,
it just has different embodiments depending on underlying transport.

That being said, I imagine the time spent context switching in and out
of the kernel dominates performance.  With a proper mux there is no
reason why v9fs can't be made as efficient as FUSE - and that's what
we intend to demonstrate in v9fs-2.1.  Plus, with v9fs you get the
benefit of being able to export your synthetic file systems over the
network with no additional copies.

Further, when you create an infrastructure which is meant to work over
a network, you take fewer things for granted -- which ultimately leads
to a more robust system capable of dealing with many of these
problems.

          -eric
