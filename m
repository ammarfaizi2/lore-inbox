Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSK0Us5>; Wed, 27 Nov 2002 15:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264798AbSK0Us4>; Wed, 27 Nov 2002 15:48:56 -0500
Received: from pc-62-31-66-70-ed.blueyonder.co.uk ([62.31.66.70]:21126 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S264797AbSK0Usx>; Wed, 27 Nov 2002 15:48:53 -0500
Date: Wed, 27 Nov 2002 20:55:54 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
Message-ID: <20021127205554.J2948@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com> <shsptsrd761.fsf@charged.uio.no> <1038387522.31021.188.camel@ixodes.goop.org> <20021127150053.A2948@redhat.com> <15845.10815.450247.316196@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15845.10815.450247.316196@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Nov 27, 2002 at 09:25:35PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 27, 2002 at 09:25:35PM +0100, Trond Myklebust wrote:
> >>>>> " " == Stephen C Tweedie <sct@redhat.com> writes:
>      > So I suspect that this is a root a client problem --- the
>      > client has repeated a READDIR despite being told that the
>      > previous reply was EOF
 
> I disagree. As far as the client is concerned, it has just been asked
> to read the entry that corresponds to that particular cookie.

No, it hasn't --- at least not unless there has been a seekdir in
between.  If the client has already been told that we're at EOF, then
it's wrong to go back to the server again for more data. 

Having said that, the server is clearly in error in sending a
duplicate cookie in the first place, and if it did so we'd never get
into such a state.

> If
> glibc issued a new readdir request (which is what I suspect has
> happened here), the NFS client has no idea what the previous reply
> was

Well, glibc will *always* issue another readdir, because the only way
we can ever tell glibc that we're at EOF on the directory is when we
eventually return 0 from getdents.  The question about client
behaviour is, if we've already been told that the stream is at EOF,
should the client simply discard that info and keep reading
regardless, or should it cache the EOF status?

> IOW: A cookie should *always* be unique. There are no exceptions to
> this rule.

Agreed.

--Stephen
