Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268669AbUIGVdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268669AbUIGVdK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268663AbUIGVbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:31:46 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:59594 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S268669AbUIGV3q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:29:46 -0400
Date: Tue, 7 Sep 2004 23:29:35 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <2010165891.20040907232935@tnonline.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Hans Reiser <reiser@namesys.com>, Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>, Tonnerre <tonnerre@thundrix.ch>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@lst.de>, <linux-fsdevel@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <200409072102.i87L2K4u005503@laptop11.inf.utfsm.cl>
References: Message from Hans Reiser <reiser@namesys.com>    of "Tue, 07 Sep
 2004 12:14:44 MST." <413E08A4.9020005@namesys.com>
 <200409072102.i87L2K4u005503@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> Hans Reiser <reiser@namesys.com> said:
>> Horst von Brand wrote:
>> >Hans Reiser <reiser@namesys.com> said:
>> >>Horst von Brand wrote:
>> >>>Spam <spam@tnonline.net> said:
>> >>>>Christer Weinigel <christer@weinigel.se> said:

> [...]

>> >>>>>2. How do we want to expose named streams?
>> >>>>>  One suggestion is file-as-directory in some form.

>> >>>Which is broken, as it forbids hard links to files.

>> >>No, it forbids hard links to the directory aspect of the file-directory
>> >>duality.

>> >How do you distinguish a "hard link to the directory personality" from
>> >"hard link to the file personality"?

>> Put in (undoubtedly overly) simple terms, if you can do it to a file you
>> can do it to the file personality, but if you currently can only do it
>> to a directory and get an error from attempting it to a file then in the
>> new scheme doing it to the hard link only gives the same error.

> Let me sort this out: If it can't be done POSIXly to a directory, it can't
> be done in Reiser4 to a file (which really is a directory too). So there
> can be exactly _one_ hard link to a file. Way borken.

  But you can make a hard link to a file in reiser4, and you can
  access the metadata in both. I did this test:
  echo "moooo" > test
  ln test moo
  chmod +x moo test
  echo "0700" > test/metas/rwx
  dir moo test
      -rwx------  2 root root 10 Sep  7 23:17 moo*
      -rwx------  2 root root 10 Sep  7 23:17 test*
      
  echo "0777" > test/metas/rwx
  dir moo test
      -rwxrwxrwx  2 root root 10 Sep  7 23:17 moo*
      -rwxrwxrwx  2 root root 10 Sep  7 23:17 test*
      
  rm moo test
  mkdir test
  ln test moo
      ln: `test': hard link not allowed for directory

  If this is the intended behaviour I do not know, but it shows that
  hard links works as normal.

  You can also do linking to meta-data:

  echo moo > moo
  ln -s moo/metas/rwx test
  dir
      -rwxrwxrwx   1 root    root      0 Sep  7 23:24 moo*
      lrwxrwxrwx   1 root    root     13 Sep  7 23:25 test -> moo/metas/rwx
  echo 0700 > test
  dir moo
      -rwx------   1 root    root      0 Sep  7 23:24 moo*

      
>> Or, we can ask Alexander to help us use his deadlock detection algorithm
>> and try to do things right....

> Good luck with that one. I'd suspect if it can be made to work, it will
> have _huge_ overhead, so much that it is useless. I'd love to be proven
> wrong, but I won't hold my breath.



