Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbTDONlD (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 09:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbTDONlD 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 09:41:03 -0400
Received: from watch.techsource.com ([209.208.48.130]:26040 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261378AbTDONlC 
	(for <rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 09:41:02 -0400
Message-ID: <3E9C1208.7070801@techsource.com>
Date: Tue, 15 Apr 2003 10:07:04 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert White <rwhite@casabyte.com>
CC: Riley Williams <Riley@williams.name>,
       Linux Kernel List <Linux-Kernel@vger.kernel.org>
Subject: Re: kernel support for non-English user messages
References: <PEEPIDHAKMCGHDBJLHKGKEIFCHAA.rwhite@casabyte.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robert White wrote:

>Message codes would be *VERY BAD* anyway.  As soon as you start that, then
>you need a numbering authority and all that nonsense.
>
>However, it should be "reasonably easy" to preprocess (in the gcc -E sense)
>all the files in a kernel directory and the gather up nearly all the
>prototype strings.  (you would still have the occasional person who wrote
>"char Message[] = "INode: %d invalid"; printk(Message,number);" instead of
>having the string in place as just "printk("INode: %d invalid",number);" and
>the later is easier to collect up 8-)
>
>The thing is "INode: %d invalid", as a string is easy to decompose into a
>regular expression because it is mostly-constant and the non-constant parts
>are represented with constant markers.  There are a small number of
>degenerate cases [e.g. printk("Filename %s invalid: %s","Filename","invalid:
>whitespace character")] that might need to be tweaked but nothing is
>perfect.
>
>So "the magic tool" collects these imprint strings and builds a list of all
>the strings (for the translator), a recognizer-table (perhaps hashes against
>the constant leader word of each message and a regex for the message) that
>points to the also-built hash/key into the table of all of the known
>strings.
>  
>

I'm working on this right now.  My plan is as follows:

- Use a C parser which takes .c or .i files and searches for the format 
parameter to every printk call.
- Provide that information to both a preprocessor and the printk function.
- Pipe every .c or .i file through an intermediate preprocessor before 
or after going to cpp but before the compiler.
- Do automatic string replacement.

Right now, I'm hovering somewhere around 40% compression on the text. 
 When I have better results, I will write up a full report and post it 
on lkml.

And, BTW, I will ONLY be supporting English.  As far as I am concerned, 
the internationalization is an concluded issue.  There's no benefit to 
it, and Linus won't accept it into mainline anyhow.


