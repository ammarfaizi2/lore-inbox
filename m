Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUIBJqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUIBJqZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIBJpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:45:52 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:23388 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268056AbUIBJpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:45:45 -0400
Message-ID: <4699bb7b0409020245250922f9@mail.gmail.com>
Date: Thu, 2 Sep 2004 21:45:44 +1200
From: Oliver Hunt <oliverhunt@gmail.com>
Reply-To: Oliver Hunt <oliverhunt@gmail.com>
To: Helge Hafting <helge.hafting@hist.no>
Subject: Re: The argument for fs assistance in handling archives
Cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <4136E756.8020105@hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Depends on how the forks eventually get implemented.
> With the file-as-directory concept, all you need is to
> look at the file's directory part to see what is there.  (The forks,
> implemented as files in a subdirectory.)  It is done the same way
> as for an ordinary directory, so nothing "new".
> 
This still doesn't solve the problem of how we distinguish between a
multi-fork file
and a directory, for those old programs(ie. almost all that currently
exist), to be able to access meaningful data we would need to either
return just the primary fork, a serialized version of all forks in the
file, or make the file look more or less identical to a directory.

The first option could cause problems when transfering files between
different filesystems,
the second results in programs getting metadata they can't handle, and
the third option results in few of the advantages over, well,
directories...  And even those applications that could handle the fork
information nicely would need to fs type to find out whether they were
handling a directory or a multi-forked file...

As I say I like the idea, but I can't see anyway of implementing it in
a way that is useful without first putting considerable effort into at
least the VFS if not all the actual fs drivers.

--Oliver Hunt
