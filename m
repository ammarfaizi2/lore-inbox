Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSFSWuz>; Wed, 19 Jun 2002 18:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSFSWuy>; Wed, 19 Jun 2002 18:50:54 -0400
Received: from [213.23.20.58] ([213.23.20.58]:37273 "EHLO starship")
	by vger.kernel.org with ESMTP id <S318044AbSFSWuy>;
	Wed, 19 Jun 2002 18:50:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Christopher Li <chrisl@gnuchina.org>,
       "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Date: Thu, 20 Jun 2002 00:49:57 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       <ext2-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17KoGz-0000y5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 19:03, Christopher Li wrote:
> On Wed, 19 Jun 2002, Stephen C. Tweedie wrote:
> > On Tue, Jun 18, 2002 at 06:18:49PM -0400, Alexander Viro wrote:
> >  
> > > IOW, making sure that empty blocks in the end of directory get freed
> > > is a matter of 10-20 lines.  If you want such patch - just tell, it's
> > > half an hour of work...
> > 
> > It's certainly easier at the tail, but with htree we may have
> > genuinely enormous directories and being able to hole-punch arbitrary
> > coalesced blocks could be a huge win.  Also, doing the coalescing
>
> I would can contribute on that. I am thinking about it anyway.
> Daniel might already has some code there.

I don't have code, but let me remind you of this post:

   http://marc.theaimsgroup.com/?l=ext2-devel&m=102132142032096&w=2

A sketch of the coalescing design is at the end.  I'll formalize that.
One issue Stephen touched on that I hadn't settled at the time, is how
to handle deleted blocks.  My inclination is to copy the last block of
the directory into the vacated block as opposed to leaving a hole in
the file.  The slight extra cost doesn't seem to be worth worrying
about, and it's guaranteed to leave the directory in a compact state
when emptied.

The two competing approaches are the hole-punch idea - which I didn't
consider before - and keeping a list of free blocks somehow.  I think
it's best to err on the side of simplicity this time: the copy-down-last
strategy eliminates the need to search for a free block when the
directory needs to be expanded again, 

-- 
Daniel
