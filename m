Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129598AbRCWSaA>; Fri, 23 Mar 2001 13:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129618AbRCWS3m>; Fri, 23 Mar 2001 13:29:42 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:25828 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129529AbRCWS3W>;
	Fri, 23 Mar 2001 13:29:22 -0500
Date: Fri, 23 Mar 2001 13:28:38 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Matthew Wilcox <matthew@wil.cx>
cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] sane access to per-fs metadata (was Re: [PATCH]
 Documentation/ioctl-number.txt)
In-Reply-To: <20010323171613.H5491@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.GSO.4.21.0103231323140.9490-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Mar 2001, Matthew Wilcox wrote:

> On Fri, Mar 23, 2001 at 09:56:47AM -0700, Bryan Henderson wrote:
> > There's a lot of cool simplicity in this, both in implementation and 
> > application, but it leaves something to be desired in functionality.  This 
> > is partly because the price you pay for being able to use existing, 
> > well-worn Unix interfaces is the ancient limitations of those interfaces 
> > -- like the inability to return adequate error information.
> 
> hmm... open("defrag-error") first, then read from it if it fails?

Or just do
(echo $cmd; read reply) <file >&0
and make write() queue a reply. Yup, on the struct file used for write().

You _will_ need serialization for operations themselves, but for getting
replies... Not really.

> > With ioctl, I can easily match a response of any kind to a request.  I can 
> > even return an English text message if I want to be friendly.

So you can with read(). You know, the function that is intended to be used for
reading stuff into user-supplied buffer...

