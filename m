Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbSJDOce>; Fri, 4 Oct 2002 10:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSJDOcd>; Fri, 4 Oct 2002 10:32:33 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:9726 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S261826AbSJDObh>; Fri, 4 Oct 2002 10:31:37 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 4 Oct 2002 08:34:02 -0600
To: Christoph Hellwig <hch@infradead.org>, Mark Peloquin <peloquin@us.ibm.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 2/4: evms.h
Message-ID: <20021004143402.GR3000@clusterfs.com>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mark Peloquin <peloquin@us.ibm.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
References: <OF25D731E3.0E245DDC-ON85256C47.00645AA7@pok.ibm.com> <20021004151442.B30635@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004151442.B30635@infradead.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 04, 2002  15:14 +0100, Christoph Hellwig wrote:
> > the IOCTL entry point is used to send to volumes.
> > the DIRECT_IOCTL entry point is used for point-
> > to-point ioctls between corresponding user space
> > and kernel space plugins.
> 
> Do the ioctl directly to the device node of the lower layer plugin instead.

Not possible - EVMS doesn't export the lower-level device nodes at all.
That is one of the benefits - you can take 1000 drives and stack them
and raid and LVM them all you want, and you don't consume 1000*layers
device nodes.

> > >> +/**
> > >> + * convenience macros to use plugin's fops entry points
> > >> + **/
> > >> +#define DISCOVER(node, list) ((plugin)->fops->discover(list))
> > >> +#define END_DISCOVER(node, list) ((plugin)->fops->end_discover(list))
> > >> +#define DELETE(node) ((node)->plugin->fops->delete(node))
> > >> +#define SUBMIT_IO(node, bio) ((node)->plugin->fops->submit_io(node,
> > bio))
> > >> +#define INIT_IO(node, rw_flag, start_sec, num_secs, buf_addr) >((node)
> > ->plugin->fops->init_io(node, rw_flag, start_sec, num_secs, buf_addr))
> > >> +#define IOCTL(node, inode, file, cmd, arg)    ((node)
> > ->plugin->fops->ioctl(node, >inode, file, cmd, arg))
> > >> +#define DIRECT_IOCTL(plugin, inode, file, cmd, arg)   >((plugin)
> > ->fops->direct_ioctl(inode, file, cmd, arg))
> > 
> > > Do you really need those wrapper?
> > 
> > No the wrappers aren't really needed. However they do make the
> > code a great deal more readable.
> > 
> > > They just obsfucate the code
> > 
> > The same argument could be made about *all* macros then.
> > Its simply a tradeoff between readability and potential
> > hiding.
> 
> CodingStyle is one big flamewar.  As no other operations vector
> in the linux kernel uses such wrappers the syle police seems to
> be on my side in this case :)

Um, how about EXT3_I() and EXT3_SB(), or almost any filesystem in
2.5 which hides inode->u.generic_ip->foo_inode_info->blah?  Given
that you want to keep lines < 80 chars where possible having short
names to access common methods is a big win, IMHO.

Are you telling me XFS doesn't have some awful abstractions in it too?
VOP_GETATTR(), ugh.  So, yes it's nice to have useful criticism, but
no need to pick every space and tab to death.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

