Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267790AbRG3Uah>; Mon, 30 Jul 2001 16:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267806AbRG3Ua1>; Mon, 30 Jul 2001 16:30:27 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:22532 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S267790AbRG3UaT>; Mon, 30 Jul 2001 16:30:19 -0400
Message-ID: <3B65C3D4.FF8EB12D@namesys.com>
Date: Tue, 31 Jul 2001 00:30:12 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Christoph Hellwig <hch@ns.caldera.de>
CC: Matthew Gardiner <kiwiunixman@yahoo.co.nz>,
        kernel <linux-kernel@vger.kernel.org>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <200107281645.f6SGjA620666@ns.caldera.de> <3B653211.FD28320@namesys.com> <20010730210644.A5488@caldera.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Christoph Hellwig wrote:
> 
> On Mon, Jul 30, 2001 at 02:08:17PM +0400, Hans Reiser wrote:
> > Christoph Hellwig wrote:
> > >
> >
> > > Reiserfs as implemented in the 2.4.2-based kernel of OpenLinux 3.1 is
> > > everything but stable and has a lot of issues (e.g. NFS-exporting doesn't
> > > work).  That is the reason why it is a) marked experimental and is completly
> > > unsupported (and that is written _big_ _fat_ in manuals and similar stuff)
> > > and b) has debugging enabled to have the additional sanity checks that are
> > > under this option and give addtional hints if reiserfs fails again.
> >
> > The debugging won't prevent a single crash, it will only print a diagnostic that
> > might help to understand why it crashed.
> 
> I don't know when you took a look at you code the last time, but when
> I did some time before the COL 3.1 release, there were lots of places
> in the reiserfs code where functions assumed that they have valid
> arguments when compiled without debugging and did the check explicitly
> when compiled with.  Given the state the reiserfs code is in I really
> prefer to see this option turned on.

But there is not one where they recover from invalid arguments without a panic
(unless I failed to notice something), so it gets you nothing except a message
that we the developers will find more informative when trying to find what made
it crash.  We check invalid arguments at entry to reiserfs, and for those we
error gracefully.  (We also have some checks for garbage blocks having been
read, and we have made some efforts to error gracefully from those.) 

Hans
