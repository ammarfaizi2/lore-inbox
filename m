Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTGBSwI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTGBSwH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:52:07 -0400
Received: from [208.199.87.79] ([208.199.87.79]:219 "EHLO amboise.dolphin")
	by vger.kernel.org with ESMTP id S264394AbTGBSv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:51:59 -0400
Date: Wed, 2 Jul 2003 12:06:23 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Spelling fixes
Message-ID: <Pine.LNX.4.44.0307021136350.16729-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch is large so I put it at the following URL. It was made
against a clean 2.5.73 tree:
http://fgouget.free.fr/tmp/linux-2.5.73.diff

Here is the history of this patch. I am a Wine developer and I noticed
that some spelling errors seem to come back over and over. From time to
time I was doing a global grep in the Wine sources for a specific
spelling error and sending a patch with the corresponding fixes. But
that obviously is not very efficient.

So recently I wrote a small script that greps for a bunch of common
spelling errors. This works much better:
 * whenever I find a new type of spelling error I just add it to the
   script
 * I can re-run the script from time to time and recheck for all past
   spelling errors on the new sources
 * fixes are made by hand because I don't trust a script to do that kind
   of changes
 * because the script specifically checks for spelling errors, it has a
   very low false positive rate, unlike (I suspect) dictionary-based
   approaches that flag anything that's not in the dictionary (variable
   names, techical terms, etc.)
 * it's independent from the actual project so it works just as well on
   the Linux sources and even web sites

So while I initially developped the script for the Wine sources, I also
tested it with the Linux and Mozilla sources and enriched it with
common typos found there.

So now I'm submitting the resulting Linux patch for review and possible
inclusion. I'd appreciate suggestions as to what the best approach would
be for that. I'm thinking of sending it to the Linux Kernel Trivial
Patch Monkey, possibly after splitting it a bit.

And finally, here is the script I used. Feel free to use it on any
material you want and to modify it as you like. Let me know if
you are interested in this script or have suggestions for improvement.

(please CC me in replies)

--- cut here ---
#!/bin/sh

mygrep()
{
    dir="$1"
    shift
    find "$dir" -follow -name CVS -prune -o -name linklint -prune -o \( ! -name '*~' -a ! -name '.#*' -a ! -name '*.diff' -a ! -name '*.gif' -a ! -name '*.jpg' -a ! -name '*.o' -a ! -name '*.png' -a ! -name '*.so' \) -type f -print0 | xargs -0 grep "$@"
}

if [ "$1" != "" ]
then
    dir="$1"
    shift
else
    dir="."
fi

mygrep "$dir" "$@" -E -i "(icaly\\W|(less|more) then|necces|necesar|non  *existing|procces|reciev)" | egrep -v "ChangeLog(.OLD)?"
mygrep "$dir" "$@" -E -i -w "(acc?eptible|adress?|appartments?|arithmatic|automaticly|careful[ly]|cateogor(y|ies)|comands?|(in|un)?compatab(le|ility|ilities)|(dis)?continous(ly)?|debug(ing|ed|er)|dependan(cy|cies|t)|depand(a|e)n(cy|cies|t)|effecien(t|cy)|existan(t|ce)|extentions?|grammer|happends?|(un)?impliment(ation|ed|er|ing)?|(un)?marshal(ed|ing)|oportunit(y|ies)|paramaters?|privi?lages?|refer(ing|ed)|seperat(e(d|s)?|ing|ions?|ors?)|subscribtions?|successfull|succesful(ly)?|sucess?ful(ly)?|(un)?suport(able|ed|er|ing|ive|ively)?|thier|wierd|(over|re)?writen)"
--- cut here ---

-- 
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
The nice thing about meditation is that it makes doing nothing quite respectable
                                  -- Paul Dean

