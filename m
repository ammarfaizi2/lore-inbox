Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263253AbVGAG4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbVGAG4K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 02:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263254AbVGAG4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 02:56:10 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:8710 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S263253AbVGAG4D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 02:56:03 -0400
Message-ID: <42C4E903.4070206@slaphack.com>
Date: Fri, 01 Jul 2005 01:56:03 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Kevin Bowen <kevin@ucsd.edu>, Hubert Chan <hubert@uhoreg.ca>,
       Hans Reiser <reiser@namesys.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200507010328.j613SV3h004647@laptop11.inf.utfsm.cl>
In-Reply-To: <200507010328.j613SV3h004647@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> Kevin Bowen <kevin@ucsd.edu> wrote:

[...]

>>                                                            The desire
>>amongst users for ubiquitous metadata is very real - the current wave of
>>"desktop search" products and technologies demonstrates this - 
> 
> 
> Just like each previous claim "this /must/ be the next cool technology!",
> also called later the "dotcom crash"...

Have you used this technology?

For that matter, some of these claims have been true.  The Internet, 
despite the dotcom crash, is now a requirement -- few people would use 
an OS with no networking support on a desktop PC.  Same goes for GUIs. 
Both of these technologies had to have at least some amount of kernel 
support, both were once weird and experimental, and both are now in 
demand by users and likely to be for some time.

If we're right, and searching is the next best thing, then it would be a 
good idea to get started now.  If we're wrong, what's the harm?

(Assuming /meta, of course.  I accept that the issues with 
file-as-directory may never be solved to the point where we can do it at 
the kernel's FS/VFS level.)

>>                                                          Google Desktop
>>Search et al allow for querying on metadata, but actually *acting* on
>>the results of those queries requires that they be exposed via first
>>class primitives which can be manipulated with arbitrary tools, not via
>>some proprietary userland api which only one tool ever actually
>>implements. 
> 
> 
> Could you please explain in plain english? The only part I get out is
> "propietary API", and I don't see anybody advocating such here.

I don't understand it much, but I think the point being made is that 
while desktop searches may be able to search metadata (not sure how they 
do this -- their own plugins or just full-text searching?), they cannot 
write to said metadata.  To change metadata on a file, one currently 
needs to use a proprietary userland api which is only implemented by one 
tool.

So, for instance, if I want to grab all mp3s with Artist "Paul 
Oakenfold" and change the genre to "techno" (can you do that?), I can 
use Beagle's search tool to find all mp3s by Oakenfold, but to change 
the genre, I have to use some separate tool to manipulate id3 tags, 
which may or may not exist in an easily scriptable form.

I know there's a decent tool for id3 tags, but there's so many kinds of 
metadata and so many tools out there that the user can't possibly 
memorize them all.  This is why I use the zipfile example, despite its 
flaws.

Now, the "arbitrary tools" bit is about how one could do this kind of 
thing with file-as-dir or /meta.  With file-as-dir, it might be as 
simple as:

$ for i in `magical-find-tool artist='Paul Oakenfold'`; do echo 'techno' 
 > "$i/.../genre"; done

Or even

$ echo 'techno' > /.../search/artist='Paul Oakenfold'/*/.../genre

It doesn't get too much more complicated for /meta, which has a nice 
side effect of not killing things like tar and generally not messing 
with POSIX.

One could also use vim, emacs, or whatever else to edit this metadata, 
instead of being limited to one program.  This is especially nice 
considering you might have to look up which one program to use.

>>As to the case of system-wide shared files, there is already a mechanism
>>to prevent users from inappropriately annotating files that don't belong
>>to them: file permissions.
> 
> 
> And who says that a normal user isn't allowed to annotate each and every
> file with its purpose or something else? I can very well imagine a system
> in which users (say students in a Linux class) want to do so... on a shared
> machine. Or users having a shared MP3 or photograph or ... collection, with
> individual notes on each. Or even developers wanting to annotate source
> code files with their comments, but leave them read-only (or have them
> under SCM).

File-as-dir is actually pretty nice for this, I think.  Since the 
annotations appear as files, if the app supports it, the users can each 
store individual annotations, world-readable, but only user-writable.

With something like Gnome-VFS, I doubt there's even a mechanism whereby 
such annotations can be shared to begin with.

But this is just a thought experiment atm, don't pick it apart too 
brutally...
