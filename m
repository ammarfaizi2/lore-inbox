Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbTJaHkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 02:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263082AbTJaHkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 02:40:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:35011 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263081AbTJaHkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 02:40:05 -0500
Message-ID: <3FA211D3.2020008@namesys.com>
Date: Fri, 31 Oct 2003 10:40:03 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Things that Longhorn seems to be doing right
References: <3F9F7F66.9060008@namesys.com> <20031029224230.GA32463@codepoet.org> <20031030015212.GD8689@thunk.org> <3FA0C631.6030905@namesys.com> <20031030174809.GA10209@thunk.org> <3FA16545.6070704@namesys.com> <20031030203146.GA10653@thunk.org>
In-Reply-To: <20031030203146.GA10653@thunk.org>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:

>On Thu, Oct 30, 2003 at 10:23:49PM +0300, Hans Reiser wrote:
>  
>
>>>Your assumption here is that the only thing that people search and
>>>index on is semi-structed data.
>>>
>>>      
>>>
>>No, my assumption is that structured data is a special case of 
>>semi-structured data, and should be modeled that way.
>>    
>>
>
>There are much more powerful ways of handling structured data (as
>opposed to generalized text searches). 
>
Special cases of general theorems are not more powerful than the general 
theorems, they are simply special cases.   You can design a language 
that has the power of both relational algebra and boolean algebra.

> What WinFS is specifically
>addressing is searching and selected based on structured data.  
>
>  
>
>>>In addition, even for text-based files, in the future, files will very
>>>likely not be straight ASCII, but some kind of rich text based format
>>>with formatting, unicode, etc.
>>>
>>>      
>>>
>>Formatting does not make text table structured.
>>    
>>
>
>No, but it means that doing searches on formatted text is very
>difficult,
>
When you say formatted text, do you mean fonts and stuff, or do you mean 
object storage models.  Object storage models should generally be 
replaced with files and directories. 

Are you saying that auto-indexers should not parse the formatted text, 
index the document, and allow users to find the document, with the 
auto-indexer running in user space, but the indexes being traversed by 
the filesystem namespace resolver?  The kernel does not need to 
understand how to parse a document, it just needs to support queries 
that use the indexes created by an auto-indexer that does understand it.


> and should be done in userspace, not kernel space.
>
>  
>
>>You are missing my argument.  I am saying that the indexes and name 
>>space belong in the kernel, not that the auto-indexer belongs in the kernel.
>>    
>>
>
>Searching and name spaces are different things.  Fundamentally I
>disagree with your belief that they are the same thing (and yes I've
>read your whitepaper on the namesys web page).  You can do much, much
>more powerful select statements than makes sense to do via the
>directory abstraction.  (Think about arbitrary select statements,
>possibly with subselect statements.  That's what Microsoft is
>promising in WinFS.  Do you really want to support an opendir system
>call where its argument is an arbitrary SQL select statement?
>
No, I hate SQL.  I want to allow people to use Reiser6 queries to find 
things.;-)

>  I
>didn't think so.)
>
>There is a very, very big difference between a pathname, which is
>guaranteed to be refer to a single unique file, such as might be used
>in a Makefile.  This is what most people consider a real namespace.
>  
>
You mean, it is what most people consider a primary key.  Or at least I 
hope you mean that, because the whole point of all those articles (in 
what, the 80's was it? ) that strove to coin the name "namespace" was 
that filesystems and databases and search engines and so on are all 
namespaces. and they strove to imply that unifying them was possible and 
desirable.

>When addressing people, a passport number, or a driver's license
>number, or a social security number, are all examples of a namespace.
>Each one of these is guaranteed to return either no result, or a
>single specific person.  
>
>In contrast, consider searching for someone who is male, between 30
>and 40, is named Tom, and lived in Libertyville, Illinois sometime
>between 1960 and 1970, and is married to someone named Mary who was
>born in California.  This might return several people, and most people
>would **NOT** consider the space of all queries about people to be a
>"name space". 
>
Oh god, did you read the literature?

> Searches are not names.  They do not uniquely identify
>people or objects, which is a fundamental requirement of a name.
>  
>
You mean like Theodore?  Are you saying that Theodore is not a name 
because it does not uniquely identify you?

>We can create a filesystem with a directory indexed by social security
>number, and another directory with hard links that indexes people's
>records by driver's ID.  That makes sense.  But putting in sufficient
>indexes so that the above query of looking for somone named Tom who is
>married to someone named Mary (and this is an example where an query
>optimizer would be needed) is simple, pure insanity.
>  
>
I bet it will be less code than balanced trees were.

>  
>
>>uh, all the time, if there is a namespace that lets him.  How often do 
>>you use google?  How often do you memorize the primary key of an object 
>>in a relational database, and use only that versus how often do you do a 
>>richer query?
>>    
>>
>
>I use google dozens of times a day.  I type commands to bash hundreds
>of times a day.  Does that mean that bash command line parsing should
>be in the kernel?  Of course not!
>
>The bottom line is that for something that happens dozens or even
>hundreds of times a day, that's an argument that it *shouldn't* be
>done in the kernel.  Compare and contrast that with handling incoming
>network packets, which can happen millions of times per hour.
>  
>
Actually the relevant measure is, not how often do you use it, but how 
often would it context switch if it was not in the kernel.  Users rarely 
use the networking code directly.

Naming is used by programs a lot.  Enhace naming, and the programs will 
used enhanced naming a lot.

-- 
Hans


