Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313533AbSDPPjH>; Tue, 16 Apr 2002 11:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313619AbSDPPjG>; Tue, 16 Apr 2002 11:39:06 -0400
Received: from waste.org ([209.173.204.2]:27317 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S313533AbSDPPjF>;
	Tue, 16 Apr 2002 11:39:05 -0400
Date: Tue, 16 Apr 2002 10:37:53 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Andi Kleen <ak@suse.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        "David S. Miller" <davem@redhat.com>, <taka@valinux.co.jp>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zerocopy NFS updated
In-Reply-To: <20020416001749.GY23513@matchmail.com>
Message-ID: <Pine.LNX.4.44.0204161032300.3933-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Apr 2002, Mike Fedyk wrote:

> On Thu, Apr 11, 2002 at 03:16:16PM +0200, Andi Kleen wrote:
> > On Thu, Apr 11, 2002 at 04:00:37PM -0200, Denis Vlasenko wrote:
> > > On 11 April 2002 09:36, David S. Miller wrote:
> > > > No, you must block truncate operations on the file until the client
> > > > ACK's the nfsd read request if you wish to use sendfile() with
> > > > nfsd.
> > >
> > > Which shouldn't be a big performance problem unless I am unaware
> > > of some real-life applications doing heavy truncates.
> >
> > Every unlink does a truncate. There are applications that delete files
> > a lot.
>
> Is this true at the filesystem level or only in memory?  If so, I could
> immagine that it would make it much harder to undelete a file when you don't
> even know how big it was (file set to 0 size)...
>
> Why is this required?  Could someone say quickly (as I'm sure it's probably
> quite complex) or point me to some references?

Truncate is used to return the formerly used blocks to the free pool. It
is possible (and preferable) to avoid flushing out the modified file
metadata (inode and indirect blocks) for the deleted file, but
recoverability of deleted files has never been high on the priority list.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

