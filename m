Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269049AbUIHJVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269049AbUIHJVX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269043AbUIHJVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:21:23 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:44815 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269049AbUIHJUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:20:13 -0400
Message-ID: <413ECFD8.1040808@hist.no>
Date: Wed, 08 Sep 2004 11:24:40 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
CC: Oliver Hunt <oliverhunt@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com> <413829DF.8010305@hist.no> <20040905134428.GN26560@thundrix.ch>
In-Reply-To: <20040905134428.GN26560@thundrix.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

>Salut,
>
>On Fri, Sep 03, 2004 at 10:22:55AM +0200, Helge Hafting wrote:
>  
>
>>Requiring another syscall to open forks other than the primary
>>breaks _all_ existing software because it obviously don't use that
>>syscall yet.  And then it doesn't provide any advantages over the
>>file-as-plain-directory way. . .
>>    
>>
>
>Actually...
>
>We might tune the sys_open()  call to take an additional argument (the
>stream ID),  and introduce a compatibility interface  into *libc which
>chooses strid=0 by default if the plain old open call is being used.
>  
>
But this isn't necessary, as I pointed out above.
There is no _need_ for a new kind of open(), so
why make one in libc?

If you can open a fork/substream/whatever by issuing
open("filename/forkname", ...
then the old-fashioned open() works with multi-fork files too.
An tools based on "open() something, then work with
the resulting file descriptor" will work _unchanged_
with such a multi-fork fs.

Tools that rely on "stat" or directory traversals might need
some updating to work perfectly with such a fs, but not something
that just opens by name.

Helge Hafting


