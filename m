Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265830AbRGSSGz>; Thu, 19 Jul 2001 14:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbRGSSGo>; Thu, 19 Jul 2001 14:06:44 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:38153 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S265830AbRGSSGh>; Thu, 19 Jul 2001 14:06:37 -0400
Message-ID: <3B5720B2.A4D97ECF@namesys.com>
Date: Thu, 19 Jul 2001 22:02:26 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Chris Mason <mason@suse.com>, Andi Kleen <ak@suse.de>,
        Craig Soules <soules@happyplace.pdl.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <177360000.995464676@tiny> <shsg0btnobs.fsf@charged.uio.no>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Trond Myklebust wrote:
> 
> >>>>> " " == Chris Mason <mason@suse.com> writes:
> 
>      > Well, returning the last filename won't do much for filesystems
>      > that don't have any directory indexes, but that's besides the
>      > point.  Could nfsv4 be better than it is?  probably.  Can we
>      > change older NFS protocols to have a linux specific hack that
>      > makes them more filesystem (or at least reiserfs) friendly?
>      > probably.
> 
> NFSv2 and v3 have a fixed format for readdir calls. There's bugger all
> you can do to change this without making the resulting protocol
> incompatible with NFS.
> 
> If you don't want Reiserfs to be NFS compatible, then fine, but I
> personally don't want to see hacks to the NFS v2/v3 code that rely on
> 'hidden knowledge' of the filesystem on the server.
> 
> Cheers,
>   Trond
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

The current code does rely on hidden knowledge of the filesytem on the server, and refuses to
operate with any FS that does not describe a position in a directory as an offset or hash that fits
into 32 or 64 bits.

But be calm, I am not planning on fixing this myself anytime in the next year, we have an ugly and
hideous hack deployed in ReiserFS that works, for now I am just saying the folks who designed NFS
did a bad job and resolutely continue doing a bad job, and if someone wanted to fix it, they could
fix cookies to use filenames instead of byte offsets for those filesytems able to better use
filenames than byte offsets to describe a position within a directory, and for those clients and
servers who are both smart enough to understand filenames instead of cookies (able to understand the
cookie monster protocol).

Hans
