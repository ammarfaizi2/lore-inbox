Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287404AbSAGXqh>; Mon, 7 Jan 2002 18:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287408AbSAGXq2>; Mon, 7 Jan 2002 18:46:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25363 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287400AbSAGXqM>;
	Mon, 7 Jan 2002 18:46:12 -0500
Message-ID: <3C3A3341.F9025058@mandrakesoft.com>
Date: Mon, 07 Jan 2002 18:46:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: torvalds@transmeta.com, viro@math.psu.edu, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: PATCH 2.5.2.9: ext2 unbork fs.h (part 1/7)
In-Reply-To: <20020107132121.241311F6A@gtf.org> <E16NcLw-0001R9-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On January 7, 2002 04:19 pm, Daniel Phillips wrote:
> >   - You are dreferencing a pointer, and have two allocations for every
> >     inode instead of one.
> 
> Oh no, you only have one allocator, and you have the filesystem do it, with
> per-sb methods.  Why is this better than having the VFS do it?  Does this
> imply you might have different sized inodes with different mounts of the same
> filesystem?
> 
> The per-fs cost with my variant is: 4-8 bytes per filesystem, period.  No
> methods needed, and the object management code doesn't get replicated through
> all the filesystems.

I greatly prefer function pointers to [possibly] generic obj management
code, to storing object sizes.  Some filesystem is inevitably going to
want to do something even more clever with inode allocation.  My method
gives developers the freedom to experiement with inode alloc to their
heart's desires, without affecting any other filesystem.


> Also, having the inode point at itself is a little, hmm, 'what's wrong with
> this picture', don't you think?

gone in the updated patch :)

-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
