Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280599AbRKFVob>; Tue, 6 Nov 2001 16:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280587AbRKFVn5>; Tue, 6 Nov 2001 16:43:57 -0500
Received: from sweetums.bluetronic.net ([66.57.88.6]:14231 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S280597AbRKFVnh>; Tue, 6 Nov 2001 16:43:37 -0500
Date: Tue, 6 Nov 2001 16:43:30 -0500 (EST)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
In-Reply-To: <Pine.LNX.4.30.0111062157050.25683-100000@mustard.heime.net>
Message-ID: <Pine.GSO.4.33.0111061611080.17287-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2001, Roy Sigurd Karlsbakk wrote:
>What about adding a separate choice in the kernel config to allow for
>/hproc (or something) human readable /proc file system?

Just think about it for a minute.

There are three ways to address "/proc":
 - 100% binary interface
  * human interaction doesn't belong in the kernel - period.
 - optimally formated text
  * not designed for humans, but in human format ("text")
 - human readable
  * thus the entire OS is reduced to "cat" and "echo"

Providing more than one interface/format means code duplication.  It doesn't
matter how much is actually compiled.  Someone has to write it.  Others have
to maintain it.  Suddenly a change in one place becomes a change in dozens
of places.

Personally, I vote for a 100% binary interface. (no surprise there.)  It
makes things in kernel land so much cleaner, faster, and smaller.  Yes,
it increases the demands on userland to some degree.  However, printf/scanf
is one hell of a lot more wasteful than a simple mov.

For my worst case scenerio, answer this:
  How do you tell how many processors are in a Linux box?

The kernel already knows this, but it isn't exposed to userland.  So, one
must resort to ass-backward, stupid shit like counting entries in
/proc/cpuinfo.  And to make things even worse, the format is different for
every arch! (I've been bitching about this for four (4) years.)

And for those misguided people who think processing text is faster than
binary, you're idiots.  The values start out as binary, get converted to
text, copied to the user, and then converted back to binary.  How the hell
is that faster than copying the original binary value? (Answer: it isn't.)

And those who *will* complain that binary structures are hard to work with,
(you're idiots too :-)) a struct is far easier to deal with than text
processing, esp. for anyone who knows what they are doing.  Yes, changes
to the struct do tend to break applications, but the same thing happens
to text based inputs as well.  Perhaps some of you will remember the stink
that arose when the layout of /proc/meminfo changed (and broke, basically,
everything.)

--Ricky


