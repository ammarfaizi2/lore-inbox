Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269417AbUICI1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269417AbUICI1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269394AbUICI0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:26:42 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:9223 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269390AbUICISl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:18:41 -0400
Message-ID: <413829DF.8010305@hist.no>
Date: Fri, 03 Sep 2004 10:22:55 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Hunt <oliverhunt@gmail.com>
CC: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com>
In-Reply-To: <4699bb7b0409020245250922f9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Hunt wrote:

>>Depends on how the forks eventually get implemented.
>>With the file-as-directory concept, all you need is to
>>look at the file's directory part to see what is there.  (The forks,
>>implemented as files in a subdirectory.)  It is done the same way
>>as for an ordinary directory, so nothing "new".
>>
>>    
>>
>This still doesn't solve the problem of how we distinguish between a
>multi-fork file
>and a directory, for those old programs(ie. almost all that currently
>exist), to be able to access meaningful data we would need to either
>return just the primary fork, a serialized version of all forks in the
>file, or make the file look more or less identical to a directory.
>  
>
If they open "filename" then they get what you calls the primary fork.
If they open "filename/someforkname" then they get some other fork, using
exactly the same mechanism as when they opens "directoryname/somefilename"
And if you want to use the old tools to look at some forks, just do a
$ cd filename
It will work if "filename" happens to be a file-as-dir thing, then do
$ ls
And you'll see the forks by name.  Because the "forks" are merely
plain files in a subdirectory. 

The only new thing needed is the ability for something to be both
file and directory at the same time.  Some tools will need
a update - usually only because they blindly assume that a directory
isn't a file too, or that a file can't be a directory too.  Remove the 
mistaken
assumption and things will work because the underlying system
calls (chdir or open) _will_ work.



>The first option could cause problems when transfering files between
>different filesystems,
>the second results in programs getting metadata they can't handle, and
>the third option results in few of the advantages over, well,
>directories...  
>
Few advantages over directories perhaps, but other implementatins
don't have more advantages over directories than this one. 
Requiring another syscall to open forks other than the primary
breaks _all_ existing software because it obviously don't use that
syscall yet.  And then it doesn't provide any advantages over the
file-as-plain-directory way. . .

>And even those applications that could handle the fork
>information nicely would need to fs type to find out whether they were
>handling a directory or a multi-forked file...
>
>  
>
The distinction might not be important.  A directory can be seen
as a multi-stream file without the main stream.  And there's always
"stat" which should be able to tell what you're looking at.

>As I say I like the idea, but I can't see anyway of implementing it in
>a way that is useful without first putting considerable effort into at
>least the VFS if not all the actual fs drivers.
>  
>
Sure, implementing it well will take effort, wich is why it is important
to find a good way of doing it so the effort won't be wasted.

Helge Hafting
