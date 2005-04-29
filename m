Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262982AbVD2VQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVD2VQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262998AbVD2VOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:14:18 -0400
Received: from pat.uio.no ([129.240.130.16]:49317 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262982AbVD2VNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:13:35 -0400
Subject: Re: which ioctls matter across filesystems
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Robert Love <rml@novell.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1114807648.6682.153.camel@betsy>
References: <42728964.8000501@austin.rr.com>
	 <1114804426.12692.49.camel@lade.trondhjem.org>
	 <1114805033.6682.150.camel@betsy>
	 <1114807360.12692.77.camel@lade.trondhjem.org>
	 <1114807648.6682.153.camel@betsy>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 17:13:19 -0400
Message-Id: <1114809199.12692.96.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.7, required 12,
	autolearn=disabled, AWL 1.30, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fr den 29.04.2005 Klokka 16:47 (-0400) skreiv Robert Love:
> On Fri, 2005-04-29 at 16:42 -0400, Trond Myklebust wrote:
> 
> > The problem is that having the server call back a bunch of clients every
> > time a file changes does not really scale too well. The current
> > dnotify-like proposal therefore specifies that notification is not
> > synchronous (i.e. there may be a delay of several seconds), and that the
> > server may want to group several notifications into a single callback.
> 
> Yah, so what I am asking is why not use inotify for the user-side
> component of this system?

> Wouldn't the deferring and coalescing of events occur on the server
> side?  So the server-side stuff would be whatever you need--your own
> code using whatever protocol you wanted--but the client-side interface
> would be over inotify.

Sure. We're not talking about inventing new user interfaces here. Just
how best to support the existing ones.

> Even if not, I'd be willing to make changes to inotify to accommodate
> NFS's needs.

I think what the IETF NFS working group rather needs right now is an
advocate that is willing to stand up and demonstrate why protocol
support for inotify-style callbacks would be a more scalable solution
than a solution based on a combination of GETATTR polling and read
delegations (essentially the same thing as CIFS' op-locks) for
directories.

The current research (see
http://www3.ietf.org/proceedings/05mar/slides/nfsv4-4/sld1.htm) which
has uses real-life on-the-wire traffic actually leans more towards the
GETATTR solution. That research was based on a set of anonymous tcpdump
traces taken at Harvard University, though, so it reflects the traffic
in a typical university environment. It may be that other use-cases
exist that favour the inotify callbacks case.
If so, now is the time to step forward and say so...

Cheers,
   Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

