Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbRATRvD>; Sat, 20 Jan 2001 12:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130877AbRATRuw>; Sat, 20 Jan 2001 12:50:52 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:15114 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130842AbRATRuc>; Sat, 20 Jan 2001 12:50:32 -0500
Date: Sat, 20 Jan 2001 14:00:24 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Hellwig <hch@caldera.de>
cc: Rajagopal Ananthanarayanan <ananth@sgi.com>,
        Rik van Riel <riel@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic IO write clustering
In-Reply-To: <20010120184506.A21943@caldera.de>
Message-ID: <Pine.LNX.4.21.0101201358340.6593-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Jan 2001, Christoph Hellwig wrote:

> On Sat, Jan 20, 2001 at 01:24:40PM -0200, Marcelo Tosatti wrote:
> > In case the metadata was not already cached before ->cluster() (in this
> > case there is no disk IO at all), ->cluster() will cache it avoiding
> > further disk accesses by writepage (or writepages()).
> 
> True.  But you have to go through ext2_get_branch (under the big kernel
> lock) - if we can do only one logical->physical block translations,
> why doing it multiple times?

You dont. If the metadata is cached and uptodate there is no need to call
get_block().


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
