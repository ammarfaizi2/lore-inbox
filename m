Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132557AbRDWXQg>; Mon, 23 Apr 2001 19:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132555AbRDWXPd>; Mon, 23 Apr 2001 19:15:33 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:8670 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S132537AbRDWXNv>; Mon, 23 Apr 2001 19:13:51 -0400
Date: Mon, 23 Apr 2001 17:13:48 -0600
Message-Id: <200104232313.f3NNDmc26838@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <Pine.GSO.4.21.0104231852520.4968-100000@weyl.math.psu.edu>
In-Reply-To: <200104232249.f3NMnI126351@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0104231852520.4968-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 23 Apr 2001, Richard Gooch wrote:
> 
> > - keep a separate VFSinode and FSinode slab cache
> 
> Yup.
> 
> > - allocate an enlarged VFSinode that contains the FSinode at the end,
> >   with the generic pointer in the VFSinode part pointing to FSinode
> >   part.
> 
> Please, don't. It would help with bloat only if you allocated these
> beasts separately for each fs and then you end up with _many_ allocators
> that can generate pointer to struct inode. 
> 
> "One type - one allocator" is a good rule - violating it turns into
> major PITA couple of years down the road 9 times out of 10.

Agreed. The better option is the separate VFSinode and FSinode caches.
The enlarged inode scheme is also ugly, like the unions. It's just
less bloated :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
