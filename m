Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129103AbQJ0RBb>; Fri, 27 Oct 2000 13:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129152AbQJ0RBV>; Fri, 27 Oct 2000 13:01:21 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:33542 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129103AbQJ0RBP>; Fri, 27 Oct 2000 13:01:15 -0400
Date: Fri, 27 Oct 2000 10:57:54 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NCPFS flags all files executable on NetWare Volumes wit
Message-ID: <20001027105754.C5628@vger.timpanogas.org>
In-Reply-To: <B24306C66FF@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <B24306C66FF@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Fri, Oct 27, 2000 at 03:00:31PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 03:00:31PM +0000, Petr Vandrovec wrote:
> On 27 Oct 00 at 0:16, Jeff V. Merkey wrote:
> > I noticed NCPFS is flagging all the files on a native NetWare volume as
> > executable and chmod -x does not work, even if the NetWare server has 
> > the NFS namespace loaded.  I looked at you code in more detail, and I 
> > did not see support their for the NFS/Unix namespace.  
> 
> > Is this in a newer version, or has it not been implemented yet?  I was
> > testing with MARS and Native NetWare this evening and saw this.  If the 
> > NFS namespace is loaded, you should be able to get to it and access and 
> > set all these bits in the file system namespace directory records.
> > 
> > Do you need any info from me to get this working, or is there another
> > version where I can get this for Ute-Linux?
> 
> Hi Jeff,
>   ncpfs does not support NFS fields, as access through namespace functions
> is hopelessly broken (modify ns specific info has swapped some bits
> in mask which data update and which not), and it also adds some (100%)
> overhead on directory/inode lookups, as you must ask twice - first for
> non-NFS info, and second for NFS specific...
> 
>   There exists patch from Ben Harris <bjh21@cus.cam.ac.uk>, which adds
> this feature to 2.2.16 kernel and 2.2.0.17 ncpfs. You can download
> it from ftp://platan.vc.cvut.cz/pub/linux/ncpfs/ncp{1,2}.pat. ncp1.pat
> is kernel patch (including email headers; cut them if applying), ncp2.pat
> is patch for 2.2.0.17 ncpfs userspace - it adds mount option "nfsextras".
> (I apologize to Ben - I promised to integrate it into ncpfs, and into
> 2.4 kernel, but...)
> 
>   Except that, you can make all files non-executable by using
> "filemode=0644" mount option. Or you can use "extras,symlinks", in which
> case (NFS namespace incompatible) hidden/shareable/transactional attributes
> are used to signal executability of file...
> 
>   If you have some document which describes what each NFS specific field 
> does - currently ncpfs names them "name", "mode", "gid", "nlinks", "rdev",
> "link", "created", "uid", "acsflag" and "myflag" - if I remember correctly,
> it is how Unixware 2.0 nuc.h names them. And I did not found any information
> about layout of NFS huge info, which is used for hardlinks :-(
> 
>   Also, as NCP 87,8 kills almost every NW server I know, if used namespace
> is NFS, I'm a bit sceptic about usability of NCP 87,* on NFS namespace.
> 
>   In 1998 and 1999 I tried to ask Novell for documentation of NCP 95,*
> (Netware Unix Client), but it was refused and ignored, so... here we are.
>                                                 Best regards,
>                                                         Petr Vandrovec
>                                                         vandrove@vc.cvut.cz


Petr,

I've got the info you need including the layout of the NFS namspace 
records.  For a start, grab NWFS and look at the NFS structure in 
NWDIR.H.  The fields you have to provide are there.  There are some 
funky ones in this structure.  You are correct regarding the NCP 
extensions to support this.  They are about 12 years old, BTW and are 
not even supported any longer (no one has worked on this at Novell 
since about 1994).  

I will put together a complete description today (will take a couple 
of hours) and post to the list on the implementation of of the NFS
namespace over the wire.  Hardlinks use a root DirNo handle that 
must point back to the DOS namespace record that owns the FAT chain
and this is probably the only nasty thing to deal with here.

I'll get started immediately.

:-)

Jeff




>                                                         
> P.S.: Jeff, if you want, there is ncpfs/MaRS/LinWare specific list,
> linware@sh.cvut.cz. Subscribe: "subscribe linware" to "listserv@sh.cvut.cz".
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
