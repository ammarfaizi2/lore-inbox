Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269436AbUIILSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269436AbUIILSd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 07:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269437AbUIILSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 07:18:33 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:56845 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269436AbUIILSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 07:18:04 -0400
Message-ID: <41403CFA.7000206@hist.no>
Date: Thu, 09 Sep 2004 13:22:34 +0200
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
References: <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com> <413829DF.8010305@hist.no> <20040905134428.GN26560@thundrix.ch> <413ECFD8.1040808@hist.no> <20040908160228.GC2726@thundrix.ch>
In-Reply-To: <20040908160228.GC2726@thundrix.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

>Salut,
>
>On Wed, Sep 08, 2004 at 11:24:40AM +0200, Helge Hafting wrote:
>  
>
>>If you can open a fork/substream/whatever by issuing
>>open("filename/forkname", ...
>>then the old-fashioned open() works with multi-fork files too.
>>An tools based on "open() something, then work with
>>the resulting file descriptor" will work _unchanged_
>>with such a multi-fork fs.
>>    
>>
>
>In my version they'd run unchanged as well.
>
>And  BTW,  I wasn't  talking  about introducing  a  new  open at  libc
>level.  I was  talking about  modifying the  open system  call  in the
>kernel and having libc provide compatibility for the old call.
>
>Since  I'm not  sure  how much  breakage it  takes  to make  a file  a
>directory.
>
I believe most of the changes necessary for supporting file-as-dir
will be in the internal workings of filesystems, not so much in
the interfaces.  I don't think it is necessary to change the
open system call, because opening a file in a subdirectory
or a named substream is the same thing.

The _uses_ people have suggested for file-as-dir (complex file attributes
and different views of the data) tends to be different from what
a directory usually does, but the implementation doesn't have to be.
There's no need to add extra interfaces or restrictions.  File-as-dir that
really is a directory, so that it may contain a whole tree is more flexible.
And the underlying fs can use existing directory code instead of
something extra.

So the only change needed for the open system call is that it will
suddenly succeed in the open("filename/forkname") case that
used to complain about an invalid path because "filename"  isn't a 
directory.
"stat" may have to change though, so it can identify a file-as-dir.

Helge Hafting




