Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269144AbRGaBXo>; Mon, 30 Jul 2001 21:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269141AbRGaBXe>; Mon, 30 Jul 2001 21:23:34 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:57093 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267465AbRGaBXZ>; Mon, 30 Jul 2001 21:23:25 -0400
Date: Mon, 30 Jul 2001 22:23:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.4
In-Reply-To: <20010731032104.O2650@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33L.0107302219340.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, 31 Jul 2001, Matti Aarnio wrote:
> On Thu, Jul 26, 2001 at 03:51:35PM +0000, Linus Torvalds wrote:

> > Use fsync() on the directory.
> >
> > Logical, isn't it?
>
>   No.  I don't see why I should opendir() a directory, fsync()
> that handle, and closedir() the handle.

And it wouldn't even be enough.  Who guarantees you that
the parent directory of this directory has been written
to disk and we won't lose the entry pointing to this
directory on a crash ?

> I would definitely prefer:
>
>        lsync(dirpath)

Nice idea.  Of course, fsync(file) also has the obligation
to make sure all the metadata of the file is written to
disk. Lots of people seem to be convinced this also includes
the metadata needed to _reach_ the file all the way from the
root of the filesystem...

> I didn't check if POSIX folks have thought of that.

Nice addition.  Easier to use than fsync() - no need to
open the file - and probably easier to implement in the
kernel because this way we'll be handing the whole path
to the kernel, whereas fsync() would have the dubious
task of finding out how this file can be traced all the
way down from the root of the filesystem.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

