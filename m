Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289281AbSAVUvH>; Tue, 22 Jan 2002 15:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288121AbSAVUu5>; Tue, 22 Jan 2002 15:50:57 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:1292 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289281AbSAVUum>;
	Tue, 22 Jan 2002 15:50:42 -0500
Date: Tue, 22 Jan 2002 18:50:21 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@zip.com.au>, Andreas Dilger <adilger@turbolabs.com>,
        Chris Mason <mason@suse.com>, Shawn Starr <spstarr@sh0n.net>,
        <linux-kernel@vger.kernel.org>, <ext2-devel@lists.sourceforge.net>
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <3C4DC966.8060004@namesys.com>
Message-ID: <Pine.LNX.4.33L.0201221830130.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Hans Reiser wrote:

> So the problem is that there is no coherently architected VM-to-FS
> interface that has been articulated, and we need one.

Absolutely agreed.  One of the main design elements for such an
interface would be doing all filesystem things in the filesystem
and all VM things in the VM so we don't get frankenstein monsters
on either side of the fence.

> So far we can identify that we need something to pressure the FS, and
> something to ask for a particular page.
>
> It might be desirable to pressure the FS more than one page aging at a
> time for reasons of performance as Rik pointed out.

> Any other design considerations?

One of the things we really want to do in the VM is pre-clean
data and just reclaim clean pages later on.

This means it would be easiest/best if the filesystem took
care of _just_ writing out data and if freeing the data later
on would be left to the VM.

I understand this is not always possible due to stuff like
metadata repacking, but I guess we can ignore this case for
now since the metadata is hopefully small and won't unbalance
the VM.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

