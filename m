Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTJ3TXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 14:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbTJ3TXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 14:23:55 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:19637 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262601AbTJ3TXv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 14:23:51 -0500
Message-ID: <3FA16545.6070704@namesys.com>
Date: Thu, 30 Oct 2003 22:23:49 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com> <20031030174809.GA10209@thunk.org>
In-Reply-To: <20031030174809.GA10209@thunk.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Thu, Oct 30, 2003 at 11:05:05AM +0300, Hans Reiser wrote:
>  
>
>>What a performance nightmare.  Updating a user space database every time 
>>a file changes --- let's move to a micro-kernel architecture for all of 
>>the kernel the same day.....;-)
>>    
>>
>
>Nope, the user space database only needs to change when the file
>metadata changes.
>  
>
Do you mean like it does with every file create?

>  
>
>>Not to mention that SQL is utterly unsuited for semi-structured data 
>>queries (what people store in filesystems is semi-structured data), and 
>>would only be effective for those fields that you require every file to 
>>have.
>>    
>>
>
>Your assumption here is that the only thing that people search and
>index on is semi-structed data.
>
No, my assumption is that structured data is a special case of 
semi-structured data, and should be modeled that way.

>
>In addition, even for text-based files, in the future, files will very
>likely not be straight ASCII, but some kind of rich text based format
>with formatting, unicode, etc.
>
Formatting does not make text table structured.

>  And even general, unstructured
>text-based indexing is hard enough that putting that into the kernel
>is just as bad as putting an SQL optimizer into the kernel.
>
Well, since I don't think that SQL belongs in the filesystem, and I 
think that text indexing should be done by users choosing how to index 
their text, including choosing whether to use an automatic indexer or do 
it by hand, and I think that the automatic indexer probably belongs in 
user space (I could be wrong, but I would at least choose to do version 
1 of such a thing in user space, perhaps using a language other than C), 
I have to say that we are agreeing here.  Surely it is an accident, but 
oh well.;-)

>  That I
>would claim would have to be done in userspace, as part of the
>overhead when OpenOffice saves the file.  (Note that some of the
>Linux-based office suites store files as gzip'ed XML files, which
>again argues that putting it in the kernel is insane --- why should we
>compress the file, only to have the kernel uncompress it and then
>re-parse the XML just so they can index it?  Much better to have
>OpenOffice do the indexing while it has the uncompressed, parsed out
>text tree in memory.  And if the indexes need to be updated in
>userspace, then life is much, much, much simpler if the lookups are
>also done in userspace --- especially when complex SQL query
>optimizations may be required.)
>  
>
Well I agree.

You are missing my argument.  I am saying that the indexes and name 
space belong in the kernel, not that the auto-indexer belongs in the kernel.

>  
>
>>How about you send him a patch that removes all of that networking stuff 
>>from the kernel and puts it into user space where it belongs.;-)  There 
>>was this Windows user on Slashdot some time ago who claimed that it 
>>wasn't just the browser that should be unbundled from the kernel, the 
>>whole networking stack was unfairly bundled and locked out the companies 
>>that used to provide DOS with networking stacks (the user didn't have in 
>>mind patching the windows kernel and recompiling, he really thought it 
>>should all be in user space).  Your kind of fellow.....
>>    
>>
>
>Networking has definite performance requirements on a per-packet basis
>which requires that it be in the kernel.  Given that indexing happens
>rarely (i.e., only when a file is saved), the same arguments simply
>don't apply.  If you consider how often a user is going to ask the
>question, "Give me a list of all photographs taken between June 10,
>1993 and July 24, 1996 which contains Mary Schmidt as a subject and
>whose resolution is at least 150 dpi",
>
uh, all the time, if there is a namespace that lets him.  How often do 
you use google?  How often do you memorize the primary key of an object 
in a relational database, and use only that versus how often do you do a 
richer query?

> it definitely demonstrates why
>this doesn't need to be in the kernel.
>
>If you consider the amount of data that needs to be shovelled back and
>forth between the kernel's network device driver to a userspace
>networking stack and then back down into the kernel to the socket
>layer when processing a TCP connection over a 10 gigabyte Ethernet
>link, it's clear why it has to be in the kernel. 
>
> When you consider
>how much data needs to be referenced when doing indexing, and in fact
>that it may exist in uncompressed form only in the userspace
>application, you'll see why it indeed it's better to do it in userspace.
>
>The bottom line is that if a case can be made that some portion of the
>functionality required by WinFS needs to be in the kernel, and in the
>filesystem layer specifically, I'm all in favor of it.  But it has to
>be justified.  To date, I haven't seen a justification for why the
>database processing aspect of things needs to be in the kernel.
>
>						- Ted
>
>
>  
>
In general, arguments over whether functionality belongs in the kernel 
or a userspace library are not as easy as you tend to suggest.  I think 
you are a bit inclined to assume that what Unix does today is the right 
thing for 2006.  The kernel is going to grow at probably roughly the 
same rate that computer horsepower grows, and the 30 year trend of 
putting more and more into the kernel will continue.

Most filesystem namespace functionality belongs in the kernel because 
subnames tend to invoke the functionality of other subnames when one 
creates a richly compounding filesystem name space.  There are however 
exceptions to this.  I would put directory lookup in the kernel.  I 
would put vicinity set intersection in the kernel.  I would put set 
difference in the kernel.  I would put set union in the kernel.  I would 
put inheritance in the kernel.  I would generally continue to put namei 
in the kernel.  Maybe macro expansion belongs in user space libraries, I 
haven't thought enough about it to say.  Probably the main reason I 
don't want the auto-indexer in the kernel is irrational: I don't want to 
design it, I want to see a lot of experiments, and I think the 
psychological barriers to entry are lower for user space experiments.  
Other valid reasons might be that string processing tools are richer in 
user space, and sys_reiser4() will provide efficient batch operations 
that will overcome most of the pain of context switches to the kernel 
for each index update.

-- 
Hans


