Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264839AbSKUV3H>; Thu, 21 Nov 2002 16:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264848AbSKUV2z>; Thu, 21 Nov 2002 16:28:55 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:40182 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S264839AbSKUV2v>; Thu, 21 Nov 2002 16:28:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Doug Ledford <dledford@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: RFC - new raid superblock layout for md driver
Date: Thu, 21 Nov 2002 14:53:23 -0600
X-Mailer: KMail [version 1.2]
Cc: Steven Dake <sdake@mvista.com>, Joel Becker <Joel.Becker@oracle.com>,
       Neil Brown <neilb@cse.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-raid@vger.kernel.org
References: <15835.2798.613940.614361@notabene.cse.unsw.edu.au> <1037914176.9122.2.camel@irongate.swansea.linux.org.uk> <20021121212251.GI14063@redhat.com>
In-Reply-To: <20021121212251.GI14063@redhat.com>
MIME-Version: 1.0
Message-Id: <02112114532304.06518@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 November 2002 15:22, Doug Ledford wrote:
> On Thu, Nov 21, 2002 at 09:29:36PM +0000, Alan Cox wrote:
> > On Thu, 2002-11-21 at 19:57, Steven Dake wrote:
> > > Doug,
> > >
> > > EVMS integrates all of this stuff together into one cohesive peice of
> > > technology.
> > >
> > > But I agree, LVM should be modified to support RAID 1 and RAID 5, or MD
> > > should be modified to support volume management.  Since RAID 1 and RAID
> > > 5 are easier to implement, LVM is probably the best place to put all
> > > this stuff.
> >
> > User space issue. Its about the tools view not about the kernel drivers.
>
> Not entirely true.  You could do everything in user space except online
> resize of raid0/4/5 arrays, that requires specific support in the md
> modules and it begs for integration between LVM and MD since the MD is
> what has to resize the underlying device yet it's the LVM that usually
> handles filesystem resizing.

LVM doesn't handle the filesystem resizing, the filesystem tools do. The only 
thing you need is something in user-space to ensure the correct ordering. For 
an expand, the MD device must be expanded first. When that is complete, 
resizefs is called to expand the filesystem.

MD currently doesn't allow resize of RAID 0, 4 or 5, because expanding 
striped devices is way ugly. If it was determined to be possible, the MD 
driver may need additional support to allow online resize. But it is just as 
easy to add this support to MD rather than have to merge MD and DM.

-- 
Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
