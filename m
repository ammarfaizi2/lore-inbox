Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbUCASiR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbUCASiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:38:17 -0500
Received: from [66.46.92.2] ([66.46.92.2]:907 "EHLO ns1.superclick.com")
	by vger.kernel.org with ESMTP id S261399AbUCASiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:38:10 -0500
Subject: Re: Ibm Serveraid Problem with 2.4.25
From: Enrico Demarin <enricod@videotron.ca>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chuck Lever <cel@citi.umich.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0403011505150.5314-100000@dmt.cyclades>
References: <Pine.LNX.4.44.0403011505150.5314-100000@dmt.cyclades>
Content-Type: text/plain
Message-Id: <1078166466.4444.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 01 Mar 2004 13:41:06 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Add mpt fusion driver to the list, it exhibits the problem as well.

- Enrico

On Mon, 2004-03-01 at 13:23, Marcelo Tosatti wrote:
> On Mon, 1 Mar 2004, Chuck Lever wrote:
> 
> > hi marcelo-
> > 
> > your "fix" will break readahead again for NFS.  with the ">=" as you
> > propose, the read ahead code will never be able to read the last page of
> > the file as a coalesced read, it will always be a separate 4KB read.
> > 
> > the problem is not the readahead code, it is the driver code that tries
> > to read beyond the end of the device.  my change merely exposed this
> > misbehavior.
> > 
> > so there is a broken assumption somewhere about how the index of the last
> > page of a file/device is computed.  i think it is a problem when the file
> > ends exactly on a page boundary.
> >
> > alain, if you don't use the NFS client, marcelo's fix should work just
> > fine for you.  but i believe that in general it is incorrect.
> 
> Okey, most drivers do no exhibit this problem indeed.
> 
> We should try to fix the problematic drivers, then.
> 
> If we can't do it easily and in a straightforward manner, I'm afraid we
> will have to undo your change because even if the "read end beyond of
> device" accesses are harmless (are they really harmless?), they must
> fixed.
> 
> Agreed?
> 
> I'll take a look at them later today, but I'm no expert, so help is very
> appreciated.
> 
> We know that these have problems:
> 
> - Promise ATA
> - ips (serveraid)
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

