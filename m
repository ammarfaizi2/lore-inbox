Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285137AbRLWHzb>; Sun, 23 Dec 2001 02:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285143AbRLWHzM>; Sun, 23 Dec 2001 02:55:12 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:17425 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S285137AbRLWHzD>; Sun, 23 Dec 2001 02:55:03 -0500
Message-ID: <3C258D76.BE259944@zip.com.au>
Date: Sat, 22 Dec 2001 23:53:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Daniel Stodden <stodden@in.tum.de>, linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
In-Reply-To: <87d71s7u6e.fsf@bitch.localnet> <Pine.LNX.4.10.10112222312030.8976-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> Daniel,
> 
> Would it be great if Linux did not have such a lame design to handle the
> these problems?  Just imaging if we had a properly formed
> FS/BLOCK/MAIN-LOOP/LOW_LEVEL model; whereas, an error of this nature in a
> write to media failure could be passed back up the pathway to the FS and
> request the FS to re-issue the storing of data to a new location.
> 
> To bad the global design lacks this ablitity and I suspect that nobody
> gives a damn, or even worse ever thought of this idea.
> 
> Now the importance of model is not to promote the use of dying media, but
> to be able to secure the content in buffer-cache, from app.-space, or
> user-space to the media and flag the UID(0) that we are in deep DOO-DOO
> and you better start backing up the content now.

For the filesystems with which I am familiar, this feature would
be quite difficult to implement.  Quite difficult indeed.  And given
that it only provides recovery for write errors, its value seems
questionable.

Much easier would be for those applications which really care about
data integrity to fsync() the file before closing it.  If either of those
calls returns an error, the *application* should take some form of
action to preserve the data.   MTAs do this, for example.

That being said, our propagation of I/O errors is a bit wobbly in places
(and the loop device hides write IO errors completely).  But that's a
separate issue.

On this one, I would be more interested in the opinion of sophisticated
*users* of linux rather than kernel developers, btw.  Whether this is
a valuable feature.


> I am just waiting to rip somebody's lunch who disagrees with me on the
> importance of data-recovery and relocation upon media failures.  Any
> points claiming it is not important because the predictive nature of
> device failure is unknown, should maybe ask an expert in the industry to
> get you the answer.  So lets have some fun and light off a really good
> flame war!
> 

umm... Daniel's error was on a read.  The data is not, by definition,
in memory.   It's gone.


What percentage of disk errors occur on writes, as opposed to reads?
If errors-on-writes preponderate then maybe you're on to something.
But I don't think they do?
