Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287163AbSAGVdC>; Mon, 7 Jan 2002 16:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287161AbSAGVcx>; Mon, 7 Jan 2002 16:32:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42252 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287155AbSAGVco>;
	Mon, 7 Jan 2002 16:32:44 -0500
Message-ID: <3C3A13F8.33BABD62@mandrakesoft.com>
Date: Mon, 07 Jan 2002 16:32:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18pre1 i686)
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

Having the VFS allocate objects by passing in object sizes in structs is
ugly to the extreme.  So I have similar objections as Al here.

The API change as I have implemented things is more flexible.  Having
the fs perform the kmem cache allocation for its inodes is much more
clean than your version IMHO, and one of the big reasons why I did
things this way.  If you dislike the size of ext2_alloc_inode some of
that code can probably go into a helper macro/function.


> Also, having the inode point at itself is a little, hmm, 'what's wrong with
> this picture', don't you think?

I am very much interested in a better solution...  I could not figure
out how to get a private pointer from a struct inode*, without using a
nasty OFFSET_OF macro or a pointer to self as I implemented.

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
