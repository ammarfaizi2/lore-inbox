Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289806AbSA2Sfc>; Tue, 29 Jan 2002 13:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289812AbSA2SfX>; Tue, 29 Jan 2002 13:35:23 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:39689 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S289806AbSA2SfJ>; Tue, 29 Jan 2002 13:35:09 -0500
Date: Tue, 29 Jan 2002 16:34:55 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Hugh Dickins <hugh@veritas.com>
Cc: Xeno <xeno@overture.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4: NFS client kmapping across I/O
In-Reply-To: <Pine.LNX.4.21.0201291701510.1367-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33L.0201291631140.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Hugh Dickins wrote:
> On Mon, 28 Jan 2002, Xeno wrote:
> >
> > Now I also have time to mention the other NFS client issue we ran into
> > recently, I have not found mention of it on the mailing lists.  The NFS
> > client is kmapping pages for the duration of reads from and writes to
> > the server.  This creates a scaling limitation, especially under
>
> You're right that kmap users should avoid holding them for very long,
> I'd certainly not discourage anyone from pursuing that effort.

Things like this would be fixed by having a kmap variant
which maps the pages into process-private space, kind of
like kmap_atomic(), but into a (4 MB sized?) part of
address space which is only visible within this process.

This would mean that each process can have a few MB of
kmap()d pages ... should be nice for things like having
copy_{to,from}_user "cache" the hot pages while keeping
longer term mappings from filling the global pool.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

