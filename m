Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbVIIRgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbVIIRgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVIIRgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:36:11 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:48352 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030284AbVIIRgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:36:09 -0400
Message-ID: <4321C806.60404@namesys.com>
Date: Fri, 09 Sep 2005 10:36:06 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: List of things requested by lkml for reiser4 inclusion (to review)
References: <200509091817.39726.zam@namesys.com>
In-Reply-To: <200509091817.39726.zam@namesys.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We haven't been sending much email out, but we have been working away. 
We just finished the VFS work, and will send a patch out on Monday.  
akpm asked for a bullet list of things suggested on lkml as issues for
inclusion. 

There are some things that I would like akpm to confirm represent the
official opinion/consensus as opposed to just someone posting an opinion
and perhaps not being right.  I assure you that all points made by
commenters were considered carefully, and I thank all of them for their
time.

If we lose every remaining point of this list, we can generate a patch
in a few days, because the VFS work was the only substantive (in coding
hours) task, and it is done.  Do I remember right that the submission
deadline is a week from Monday for 2.6.14 inclusion?

This is supposed to be a bullet list, so I don't list here the line by
line minor code improvements sent to us, most of which were
incorporated, but let me take a moment to thanks those who donated them.

Hans

1. pseudo files or "...." files

   disabled.  It remains a point of (extraordinary) contention as to whether it can be fixed, we want to keep the code around until we can devote proper resources into proving it can be (or until we fail to prove it can be and remove it).  We don't want to delay the rest of the code for that proof, but we still think it can be done (by several different ways of which we need to select one and make it work.)  Let us postpone contention on this until the existence of a patch that cannot crash makes contention purposeful, shall we?


2. dependency on 4k stack turned off

   removed as requested

3. remove conditional variable code, use wait queues instead.

   not done.  There are times when reduced functionality aids debugging.  kcond is (literally) textbook code.
   We don't care enough to fight much for it, but akpm, what is your opinion?  Will remove if akpm asks us to.

4. remove reiser4_drop_inode

   done.

5. remove undesired abstraction layer right below reiser4 VFS hooks.

   done.  This was a big job just completed.  

6. remove type safe lists and type safe hash queues.

   not done, it is not clear that the person asking for this represents a unified consensus of lkml.  Other persons instead asked that it just be moved out of reiser4 code into the generic kernel code, which implies they did not object to it.  There are many who like being type safe.  Akpm, what do you yourself think?

7. remove fs/reiser4/lib.h:/div64_32.

   is being replaced by the linux one.

8.  Remove all assertions because they clutter the code and make it hard to read

    We think this person was not an experienced security specialist, and that what we do is considered by professional code auditors to be laudable practice.  We can supply an emacs macro that makes them greyed out.  I myself found the assertions to be distracting at first (though functional and especially necessary for a DARPA funded project), and then after time got used to them, and now I understand that it was just my inexperience that caused the discomfort.  I now have a more sophisticated subconscious that is not discomforted or distracted by them.  People debugging find them very useful.  Defense branches tear their hair out at how difficult it is to get the commercial software they use coded this way, and I think they are right to be frustrated.  Linux kernel folks, those DoD guys actually know quite a few things about security, maybe its ok that they taught me something and the code reflects that?  We will conform on this if requested to by akpm, but somehow I doubt he will quite honestly.  akpm?





