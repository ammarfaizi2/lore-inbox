Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRDWXKF>; Mon, 23 Apr 2001 19:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132571AbRDWXJE>; Mon, 23 Apr 2001 19:09:04 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:35726 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132551AbRDWXIA>;
	Mon, 23 Apr 2001 19:08:00 -0400
Date: Mon, 23 Apr 2001 19:07:54 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <200104232249.f3NMnI126351@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0104231852520.4968-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Apr 2001, Richard Gooch wrote:

> - keep a separate VFSinode and FSinode slab cache

Yup.

> - allocate an enlarged VFSinode that contains the FSinode at the end,
>   with the generic pointer in the VFSinode part pointing to FSinode
>   part.

Please, don't. It would help with bloat only if you allocated these
beasts separately for each fs and then you end up with _many_ allocators
that can generate pointer to struct inode. 

"One type - one allocator" is a good rule - violating it turns into major
PITA couple of years down the road 9 times out of 10.

