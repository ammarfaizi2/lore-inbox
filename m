Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129674AbRCCTOh>; Sat, 3 Mar 2001 14:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbRCCTO1>; Sat, 3 Mar 2001 14:14:27 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:16650 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129674AbRCCTOU>;
	Sat, 3 Mar 2001 14:14:20 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103031914.f23JEIa85558@saturn.cs.uml.edu>
Subject: Re: simple question about patches
To: davidge@jazzfree.com
Date: Sat, 3 Mar 2001 14:14:18 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, alan@redhat.com
In-Reply-To: <Pine.LNX.4.21.0103031812550.1447-100000@roku.redroom.com> from "davidge@jazzfree.com" at Mar 03, 2001 06:18:39 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David G\363mez writes:

> Hi, i've got a newbie question about patches:
> Are the pre* patches ( and i guess also the ac* ones) applied against the
> last release of the kernel or against the previous patch? I mean, when
> 2.4.3pre2 will come out, i need to get also the pre1 patch?

Really, I wouldn't bother anymore. 

[stuff for patch creators below -- please read]

Long ago, pre* and ac* patches were rare. Patches went from one
kernel version to the next. You could hope to read a whole patch
line-by-line before the next one came out. Patches always applied
easily with the (pre-POSIX?) patch command. Version numbers made
perfect sense, starting with the 1.0 release. Modems were 14.4 kB/s.

Now you need to back out patches sometimes. New kernel versions
are rare enough that you might as well grab a tarball as needed.

Pre-patches go like this:

200 kB         (great: read the patch)
200 kB + 200 kB of old stuff you already read   (ugh, read 1/2 of it)
200 kB + 400 kB of old stuff you already read   (too boring)
...
200 kB + 1.2 MB of old stuff you already read   (forget it!)

Then comes the 1.4 MB patch and, well, that is just too big to read.

So you just want to apply a patch. Well, good luck. The patch command
has changed over the years. It has some ugly heuristics it uses to
find the most destructive way to misinterpret your command. Typically
it will patch a few files correctly (to ensure a half-way applied mess)
before deciding to create new files in a directory above or below the
one you want. (this is Red Hat though... they broke "sort" and "ps"
as well, so maybe "patch" still works like it used to on Slackware)

With bzip2 compression and a crummy old 33 kB/s modem, downloading a
whole new kernel isn't too horrid. With today's jumbo patches you
don't save much by getting them, and they are a pain to use anyway.

BTW, if anyone wants to make a reliable patch, read the man page!
Get the old and new directory names to be the same length, so that
POSIX and non-POSIX patch commands are more likely to behave the same.
Something like this:  "diff -Naur old new" where "old" and "new" are
the actual directory names. Kernel version numbers make nice names
if you pad them out to the same length: "2.4.09" and "2.4.10".

I'll end with a quote from the man page. Read it if you make patches!
Gee, looks like Linux being used as an example of what NOT to do.

----------------

       If the recipient is supposed to use the -pN option, do not
       send output that looks like this:

          diff -Naur v2.0.29/prog/README prog/README
          --- v2.0.29/prog/README   Mon Mar 10 15:13:12 1997
          +++ prog/README   Mon Mar 17 14:58:22 1997

       because the two  file  names  have  different  numbers  of
       slashes,  and  different  versions  of patch interpret the
       file names differently.  To avoid confusion,  send  output
       that looks like this instead:

          diff -Naur v2.0.29/prog/README v2.0.30/prog/README
          --- v2.0.29/prog/README   Mon Mar 10 15:13:12 1997
          +++ v2.0.30/prog/README   Mon Mar 17 14:58:22 1997

       Avoid  sending patches that compare backup file names like
       README.orig, since this might confuse patch into  patching
       a  backup  file  instead  of the real file.  Instead, send
       patches that compare the same base file names in different
       directories, e.g. old/README and new/README.

--------------------

Please drop individual humans from the Cc: list if you respond.
