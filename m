Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTJaUre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 15:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263545AbTJaUre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 15:47:34 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:3554 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S263544AbTJaUr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 15:47:29 -0500
Message-ID: <3FA2CA5E.3050308@namesys.com>
Date: Fri, 31 Oct 2003 23:47:26 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com> <20031030174809.GA10209@thunk.org> <3FA16545.6070704@namesys.com> <20031030203146.GA10653@thunk.org> <3FA211D3.2020008@namesys.com> <20031031193016.GA1546@thunk.org>
In-Reply-To: <20031031193016.GA1546@thunk.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Fri, Oct 31, 2003 at 10:40:03AM +0300, Hans Reiser wrote:
>  
>
>>Special cases of general theorems are not more powerful than the general 
>>theorems, they are simply special cases.   You can design a language 
>>that has the power of both relational algebra and boolean algebra.
>>    
>>
>
>Just because you can reduce everything to a turing machine doesn't
>mean that the best way to implement a filesystem is with an infinitely
>long tape which can only contain zero's and one's.
>
Beautifully poetic.:)

>  There are plenty
>of optimizations which means that you can quickly and with minimal
>overhead do searches based on structured data, which is far, far more
>difficult to do if you are doing unstructured searches. 
>
Which is why you should feel free to perform relational algebra on data 
that happens to have a table structure.

A general purpose filesystem should match rather than mold the structure 
of the data.  If the data happens to be tabular, go for it, use tuple 
structures in your queries, but if you can devise semantics that allow 
you to use what structure is there and known to you, and does not 
require you to use structure when it is not appropriate, that is much 
more powerful.

I can't get US bank accounts for my programmers working for me.  Why?  
Because every US bank without exception uses social security numbers as 
a primary key.  A person without a social security number cannot be 
coped with.  This is a weakness directly due to molding rather than 
matching structure in data.

> (In fact, in
>some cases, if you don't have structured data to distinguish between
>the author and the subject, you have to do the equivalent of natural
>language processing if you are trying to do via an unstructured search
>to find all papers written *about* a famous author, while not getting
>false hits that were *written* by that same famous author.  Doing this
>requires structured, not unstructured data.)
>  
>
So use structure when it is there and you know it, and use a model that 
allows you to use structure when it is there and you know it, but don't 
use a model that requires that you mold the data into a table structure.

With library systems that use structured card catalogs, sometimes it is 
annoying that you cannot find all papers associated with an author, both 
the ones by him and about him, without having to say author/authorname 
OR subject/authorname.  It cuts both ways.....

>  
>
>>>No, but it means that doing searches on formatted text is very
>>>difficult,
>>>
>>>      
>>>
>>When you say formatted text, do you mean fonts and stuff, or do you mean 
>>object storage models.  Object storage models should generally be 
>>replaced with files and directories. 
>>    
>>
>
>I mean fonts and stuff.  Stripping out fonts, tables, etc. for doing
>generalized, unstructured text search, clearly needs to be done in
>userspace.  Actually, I think we both agree on this point.  The poing
>of disagreement is whether the searches utilizing such indexes should
>be done in the kernel as part of the intrinsic part of the filesystem,
>or in userspace.  I believe that we need to draw a very firm line
>between what you call "primary keys", which uniquely identify a file,
>and generalized searches.  You believe the two should be unified.
>  
>
In reiser4, objectids uniquely identify a file, and all pathnames can be 
renamed.  Long ago I used to think that one should be able to find a 
file by its objectid, but I lost that argument, and deserved to lose it.

>  
>
>>Are you saying that auto-indexers should not parse the formatted text, 
>>index the document, and allow users to find the document, with the 
>>auto-indexer running in user space, but the indexes being traversed by 
>>the filesystem namespace resolver?  The kernel does not need to 
>>understand how to parse a document, it just needs to support queries 
>>that use the indexes created by an auto-indexer that does understand it.
>>    
>>
>
>I believe that there is a big difference between, "I want the file
>named /home/tytso/src/e2fsprogs/e2fsck/e2fsck.c", and "I remember
>vaguely that 5 years ago, I read a paper about the effects of high-fat
>diets on akida's, where the first name of the author was Tom".  The
>first is a filename lookup.  The second is a search.  I would like
>better search tools for files in a filesystem, no doubt.  But I would
>never, ever put a search that might return an ambiguous number of
>responses (that might change over time as more files are added to the
>filesystem) in a Makefile as a source file.  
>  
>
Suppose you want to only recompile files that have been changed since 
the last recompile.....  that will return an ambiguous number of 
responses.....

Suppose you want to only recompile files that are in a particular 
directory, and you don't know how many that is before performing the query?

Suppose you want to recompile all files that have been used in the last 
year and were compiled by the distro for a 386 rather than by you for 
your AMD 64?

>You are conflating these two concepts, pointing out that filename path
>resolution happens a lot, and so therefore generalized searches should
>also be done in the kernel.  What I am saying is that generalized
>searches where the user needs to look at the returned set of files,
>and then apply human intelligence to see which of the returned set of
>files was the one they were looking 
>
why do you assume they are looking for one of the set instead of the 
whole set?

>for is a FUNDAMENTALLY DIFFERENT
>OPERATION from a filename lookup via a primary key.  The latter should
>be done in the kernel, as is the case to day.  The former should by no
>means be in the kernel, and should be done in userspace, preferably
>with a graphical interface lookup so the user can look at the returned
>files, look at the context in which the search parameters appear, and
>select the ones which actually is the document they were looking for.
>  
>
Prompting the user for search refinement does indeed deserve a context 
switch to user space.

>Sure, Google has the concept of the "I'm feeling lucky" button.  But
>there is a fundamental difference between a URL, and saying, "Type
>'Akida fat diet' into Google and hit "I'm feeling lucky".  The latter
>is something that you would never put into hypertext document as a
>link, because it changes over time, and what works today might not
>work tomorrow.
>
Getting different results each day is sometimes desirable in a query.

>  That is the difference between a name (a URL), and a
>search string (what you type into Google).
>
>  
>
>>>In contrast, consider searching for someone who is male, between 30
>>>and 40, is named Tom, and lived in Libertyville, Illinois sometime
>>>between 1960 and 1970, and is married to someone named Mary who was
>>>born in California.  This might return several people, and most people
>>>would **NOT** consider the space of all queries about people to be a
>>>"name space". 
>>>
>>>      
>>>
>>Oh god, did you read the literature?
>>    
>>
>
>Is this the same literature as the ones which said that Microkernels
>were the way, the truth and the light?  Is this the same literature as
>the stuff written by the Professor Tennenbaum, who said he would have
>given Linus a failing grade if he submitted Linux as a project?  There
>are plenty of things in the Literature that I consider to be pure
>stuff and nonsense, and people who claim that searches and "name
>spaces" to be identical fall into that category as far as I'm
>concerned....
>  
>
If you make a statement about what most people consider a name space to 
be, you should be consistent with the literature that created the term.

If you want to make a statement about what name spaces SHOULD be, that 
is different, yes?

>
>
>  
>
>>Naming is used by programs a lot.  Enhace naming, and the programs will 
>>used enhanced naming a lot.
>>    
>>
>
>Searching and Naming are not the same thing.  Period.
>
>						- Ted
>  
>
Makefiles will use enhanced naming a lot when it is there for them to 
conveniently employ.  Many other programs will as well.

I am going to avoid directly responding to "Searching and Naming are not 
the same thing. Period." because there are articles in the literature on 
the different objectives of naming, and on why X different categories of 
name space usage (The first article had 5 different ones, one was 
navigating, and I forget the others.  A later article had more.  The 
articles are worth reading.) are deeply different, and these articles 
have truth to them.

If you say that user refinement of searches belongs in user space, we 
agree.  If you say that names resolve to single objects and never should 
resolve to sets of objects, we disagree.

-- 
Hans


