Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129736AbRCGAIJ>; Tue, 6 Mar 2001 19:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRCGAHt>; Tue, 6 Mar 2001 19:07:49 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:33553 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129733AbRCGAHl>; Tue, 6 Mar 2001 19:07:41 -0500
Date: Tue, 6 Mar 2001 19:22:04 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch][rfc][rft] vm throughput 2.4.2-ac4
In-Reply-To: <Pine.LNX.4.33.0103020610230.1297-100000@mikeg.weiden.de>
Message-ID: <Pine.LNX.4.21.0103061917221.852-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Mar 2001, Mike Galbraith wrote:

> On Thu, 1 Mar 2001, Rik van Riel wrote:
> 
> > > > The merging at the elevator level only works if the requests sent to
> > > > it are right next to each other on disk. This means that randomly
> > > > sending stuff to disk really DOES DESTROY PERFORMANCE and there's
> > > > nothing the elevator could ever hope to do about that.
> > >
> > > True to some (very real) extent because of the limited buffering
> > > of requests.  However, I can not find any useful information
> > > that the vm is using to guarantee the IT does not destroy
> > > performance by your own definition.
> >
> > Indeed. IMHO we should fix this by putting explicit IO
> > clustering in the ->writepage() functions.
> 
> I notice there's a patch sitting in my mailbox.. think I'll go read
> it and think (grunt grunt;) about this issue some more.

Mike, 

One important information which is not being considered by
page_launder() now the dirty buffers watermark. 

In general, it should not try to avoid writing dirty pages if we're above
the dirty buffers watermark.

