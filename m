Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287111AbSAPSl4>; Wed, 16 Jan 2002 13:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286127AbSAPSlr>; Wed, 16 Jan 2002 13:41:47 -0500
Received: from [66.89.142.2] ([66.89.142.2]:61486 "EHLO starship.berlin")
	by vger.kernel.org with ESMTP id <S286262AbSAPSll>;
	Wed, 16 Jan 2002 13:41:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: initramfs buffer spec -- second draft
Date: Tue, 15 Jan 2002 07:54:52 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16QV35-0000mZ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2002 09:39 pm, Alexander Viro wrote:
> On 13 Jan 2002, Eric W. Biederman wrote:
> 
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> > 
> > > This is an update to the initramfs buffer format spec I posted
> > > earlier.  The changes are as follows:
> > 
> > Comments.  Endian issues are not specified, is the data little, big
> > or vax endian?
> 
> Data is what you put into files, byte-by-byte.  Headers are ASCII.

In a perfect world we would settle of one of big or little-endian and 
byte-swap as appropriate, as we do with, e.g., Ext2 filesystems.  However it 
seems that cpio in its current form has no concept of byte-swapping.  Cpio(1) 
can neither generate nor decode a cpio file in the 'foreign' byte sex.  So if 
we are determined to use cpio as it stands, then we are stuck with the goofy 
ASCII encoding, does that sum up the situation?

Too bad about that, otherwise cpio seems quite reasonable.

I just can't get over those ascii encoding though, and I can't shake the 
feeling that relying on never having a file named TRAILER!!! is strange.  
It's gratuitous pollution of the namespace.

What was the reason for going with cpio again - so we can use standard tools? 
How hard would it be to fix cpio to get rid of the warts?  What would we 
break?  Is the problem that we would have to, ugh, go into user space or, 
eww, cooperate with non-kernel developers?

--
Daniel

