Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUIGSs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUIGSs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 14:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268502AbUIGSiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 14:38:13 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:15593 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268505AbUIGSeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 14:34:22 -0400
Message-ID: <413DFF33.9090607@namesys.com>
Date: Tue, 07 Sep 2004 11:34:27 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain>	<413D4C18.6090501@slaphack.com> <m3d60yjnt7.fsf@zoo.weinigel.se>
In-Reply-To: <m3d60yjnt7.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christer Weinigel wrote:

>David Masover <ninja@slaphack.com> writes:
>
>  
>
>>|>Second, there are quite a few things which I might want to do, which can
>>|>be done with this interface and without patching programs,
>>| Such as?
>>They've been mentioned.
>>    
>>
>
>  
>
>>| Haven't seen any that made sense to me, sorry.
>>Sorry if they don't make sense to you, but I don't feel like discussing
>>them now.  Either you get it or you don't, either you agree or you
>>don't.  Read the archives.
>>    
>>
>
>Great argument.  Not.  There has been so much shit thrown around here
>so that it's impossible to keep track of all examples.
>
>Could you please try summarize a few of the arguments that you find
>especially compelling?  This thread has gotten very confused since
>there are a bunch of different subjects all being intermixed here.
>
>What are we discussing?
>
>1. Do we want support for named streams?
>
>   I belive the answer is yes, since both NTFS and HFS (that's the
>   MacOS filesystem, isn't it?) supports streams we want Linux to
>   support this if possible.
>
>   Anyone disagreeing?
>  
>
No, we want files and directories that can do what streams can do.  This 
means files that are also directories, plugins that aggregate the 
contents of a directory, files that inherit stat data, maybe I forget 
something ---- it is on my website.

Streams themselves are a bad idea because they are a filesystem inside 
of a file which is double the overhead, and they fragment the namespace.

>4. What belongs in the generic VFS, what belongs in Reiser4?
>
>   Some things reiser4 do, such as files-as-directories need changes
>   to the VFS because it breaks assumptions that the VFS makes
>   (i.e. a deadlock or an oops when doing a hard link out of one).
>
>   Some other things reiser4 can do would be better if they were in
>   the VFS since other filesystems might want to support the same
>   functionality. 
>  
>
It is always better to lead by example.  These ideas are too new for the 
other fs developers, they need 5 years to get used to them.  Reiser4 
should create something that works, and let others follow when they will.

>   Or Linux may not support some of the things reiserfs at all.
>
>5. What belongs in the kernel, what belongs in userspace?
>  
>
This is the wrong question.  The right question is, what belongs in a 
unified namespace?  Then having answered that, the extent to which it is 
easier to have all aspects of name resolution together in one body of 
code is an implementation detail that can change and evolve with time.  
A rapidly evolving namespace is easier to modify if it is all one body 
of code.  Furthermore, the people doing the work should really be left 
to decide such implementation details themselves because they are more 
expert on their code than anyone else. 

Hans

