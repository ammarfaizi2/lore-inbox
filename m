Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSEQHg1>; Fri, 17 May 2002 03:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315452AbSEQHg0>; Fri, 17 May 2002 03:36:26 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:24592 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315431AbSEQHgZ>;
	Fri, 17 May 2002 03:36:25 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205170736.g4H7aNj281162@saturn.cs.uml.edu>
Subject: Re: Htree directory index for Ext2, updated
To: phillips@bonn-fries.net (Daniel Phillips)
Date: Fri, 17 May 2002 03:36:23 -0400 (EDT)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), linux-kernel@vger.kernel.org
In-Reply-To: <E178a8G-00005D-00@starship> from "Daniel Phillips" at May 17, 2002 07:18:23 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips writes:
> On Friday 17 May 2002 06:22, Albert D. Cahalan wrote:
>> Daniel Phillips writes:

>>> After learning to my horror that gnu patch will,
>>> if a patch was made to be applied with option -p0,
>>> sometimes apply patches to your 'clean' tree
>>> (the one with the ---'s) instead of the target
>>> tree (the one with the +++'s) I decided to switch
>>> to -p1, and that is how this patch is to be applied.
>>
>> The worst thing is that gnu patch will make
>> this decision on a per-file basis, so you
>> can't then back out the changes with -R.
>>
>> Do like this:
>>
>> diff -Naurd old new
>>
>> IMPORTANT: the directory names should have
>> the same number of characters in them.
>
> Why is that?

File selection uses a really crazy algorithm.
If you set POSIXLY_CORRECT in your environment,
it gets a bit better, but you don't get the
rejection files then. As a patch creator, you
should not assume that POSIXLY_CORRECT is
set or not.

----------- the insanity -------------

Ignoring RCS/ClearCase/SCCS, the algorithm is
claimed to be:

patch takes an ordered list of candidate file names
...
old, new, index   [index is from "Index:" line]
...
If some of the named files exist, patch selects
the first name if conforming to POSIX, and the
"best" [*] name otherwise.
...
If no named files exist ... some names are given,
patch is not conforming to POSIX, and the patch
appears to create a file, patch selects the "best" [*]
name requiring the creation of the fewest directories.
...
else ask the user

The "best" name:

patch first takes all the names with the fewest path
name components; of those, it then takes all the
names with the shortest basename; of those, it then
takes all the shortest names; finally, it takes the
first remaining name.

Given this complexity, do you trust the man page?
Follow my advice if you want to play it safe.

---------------------------------------

>> Do not try something like:
>>
>> diff -Naurd bad idea
>> diff -Naurd doomed 2fail
>>
>> Don't use "linux" for a name. Don't use
>> anything Linus might use. Pick your own
>> equal-length directory names, and don't
>> distribute tarballs containing them.
>> This prevents source-destroying disasters.
>
> I think you're saying that patch is broken by design.
> And what's the standard argument for not fixing it?

Half of the badness is POSIX mandated. As for
the other half... well, you should produce
patches that work with the existing tools.
Since good patches work with the existing
tools, there is no need to fix anything. :-/

Note who wrote patch. Note who wrote perl.
Any questions? (such behavior is nice for
a UI, for example a web browser URL parser,
but not for automated tools)
