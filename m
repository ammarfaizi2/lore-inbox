Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272915AbTHEWB1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272916AbTHEWB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:01:27 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:25618 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S272915AbTHEWBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:01:25 -0400
Date: Wed, 6 Aug 2003 00:08:31 +0200
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030805220831.GA893@hh.idb.hist.no>
References: <20030804141548.5060b9db.skraw@ithnet.com> <03080409334500.03650@tabby> <20030804170506.11426617.skraw@ithnet.com> <03080416092800.04444@tabby> <20030805003210.2c7f75f6.skraw@ithnet.com> <3F2FA862.2070401@aitel.hist.no> <20030805150351.5b81adfe.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805150351.5b81adfe.skraw@ithnet.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 03:03:51PM +0200, Stephan von Krawczynski wrote:
> On Tue, 05 Aug 2003 14:51:46 +0200
> Helge Hafting <helgehaf@aitel.hist.no> wrote:
> 
> > Even more fun is when you have a directory loop like this:
> > 
> > mkdir A
> > cd A
> > mkdir B
> > cd B
> > make hard link C back to A
> > 
> > cd ../..
> > rmdir A
> > 
> > You now removed A from your home directory, but the
> > directory itself did not disappear because it had
> > another hard link from C in B.
> 
> How about a truly simple idea: 
> 
> rmdir A says "directory in use" and is rejected
> 
Then anybody can prevent you from removing your obsolete directories
by creating links to them.  Existing hard link don't have
such problems.


> Which means you simply cannot remove the first directory entry before not all
> other links to it are removed. This implies only two things: 
> 1) you have to know who was first.

This requires fs modifications.  I.e. a new fs 

> 2) you have to be able to find out where the links are.
This is trivial but io intensive -  by searching the entire directory 
tree.  Doable in userspace, a nastry DOS opportunity if in the kernel.

Another option is to store pointers to all directory entries
in the inode, but that means much more complicated "mv", "rmdir"
and "mkdir".  Remember, it shouldn't merely "work" but also scale
well on io-intensive SMP machines.  Complicated operations tend
to need more locking in case several processes (on different
processors) try to modify the same directory simultaneously.


> 
> Both sound solvable.
> 
Anything is possible, but in this case - why bother?
Do you have a specific use in mind, or is it
just a "cool" thing?  People have thought about directory
links long before linux, tried it, and found other solutions
for their tasks. 

Helge Hafting

