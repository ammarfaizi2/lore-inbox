Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275117AbRJJJLA>; Wed, 10 Oct 2001 05:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275120AbRJJJKu>; Wed, 10 Oct 2001 05:10:50 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:20489 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S275117AbRJJJKp>; Wed, 10 Oct 2001 05:10:45 -0400
Message-ID: <3BC41086.6EB2056D@idb.hist.no>
Date: Wed, 10 Oct 2001 11:10:30 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.11-pre5 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Nikita Danilov <Nikita@Namesys.COM>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel size, kcore fun
In-Reply-To: <163112682879.20011009161634@port.imtp.ilyichevsk.odessa.ua> <15298.64405.809099.635670@beta.reiserfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> Haha, I got several pieces of your mail message while doing this.
> (/proc/kcore is unique file, because grep of *any* string on it would
> succeeded).

I tried 
strings /proc/kcore | grep any_weird_string_tsst_testtesttest
I expected it to hit a few times - the command line buffer,
the parameter to grep - but I got 7 screenfulls.

Then I understood - this hits the xterm scrollback buffer
too, which makes for some nice recursion.
Doing the same with output to a file hits the cache and
got some repetitions out of that.  And then there's
internal buffers of strings and grep.

This reminded me of the commodore 64 game "fort apocalypse",
where your fly a helicopter around in caves.  I patched the
machine code once so I could fly through walls.  The game simply
loads memory into screen memory depending on coordinates.
So I got an interesting look at how code and state variables
look when interpreted as "terrain".   I could identify
the variables holding x and y coordinates by looking at how
they changed when I moved in the two directions. 

Then I came upon a very weird area, where everything
moved around in big jumps, changing in weird ways.  After a while,
I figured out that I was looking at screen memory, having it
reloaded into itself with a different mapping.  Crazy.

Finally - being able to press the fire button and fire
upon pieces of code and variables is the ultimate in
madman debugging and single-click crashes. :-)

Helge Hafting
