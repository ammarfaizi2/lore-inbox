Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268094AbUIJFXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268094AbUIJFXE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 01:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268126AbUIJFXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 01:23:03 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:2267 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S268094AbUIJFW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 01:22:58 -0400
Message-ID: <41413A2B.9020405@namesys.com>
Date: Thu, 09 Sep 2004 22:22:51 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Jamie Lokier <jamie@shareable.org>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
Subject: Re: silent semantic changes with reiser4
References: <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org> <412DA40B.5040806@namesys.com> <20040826140500.GA29965@fs.tum.de> <20040826150202.GE5733@mail.shareable.org> <41410DE7.3090100@techsource.com>
In-Reply-To: <41410DE7.3090100@techsource.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A friend asked me a question, and because he is very bright it reminded 
me that I have not done a good job of reviewing the history of the 
design's evolution.

He asked me, why not just access a filename's size as filename/size?

So, the original idea was to access metafiles as just files within a 
directory, and it actually remains that way. However, I first decided to 
make the standard unix metafiles less intrusive on the namespace. So 
that led to calling it filename/..size and filename/..owner, etc. In 
this scheme, the use of '..' was just a style convention for metafiles, 
and not a requirement in anyway.

This was actually pretty decent as a design, but then a user on the 
mailing list suggested replacing the '..' prefix with a subdirectory 
prefix. I forget who suggested this and what the prefix was exactly. So 
we then created a '..metas' subdirectory, and this had the advantage 
that one could ls it to see all the builtins supported by a given 
plugin. This is not an important advantage, and I encourage others to 
critique it.

So, instead of filename/size we have filename/..metas/size. The only 
thing gained by this is that 'size' has a rarer name of '..metas/size'. 
The use of the '..metas/' prefix is purely a non-mandated style 
convention. File plugins that dislike it are free to violate the 
convention. There is no deep semantic to it, just a cowardly aversion to 
intruding on current namespace usage with something as common as 'size'. 
It has the significant disadvantage of being a longer name than 'size' 
or '..size'. I could be talked out of it.

Hans
