Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129921AbQJ0NDU>; Fri, 27 Oct 2000 09:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130403AbQJ0NDK>; Fri, 27 Oct 2000 09:03:10 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:8722 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129921AbQJ0NDA>;
	Fri, 27 Oct 2000 09:03:00 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Date: Fri, 27 Oct 2000 15:00:31 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: NCPFS flags all files executable on NetWare Volumes wit
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <B24306C66FF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Oct 00 at 0:16, Jeff V. Merkey wrote:
> I noticed NCPFS is flagging all the files on a native NetWare volume as
> executable and chmod -x does not work, even if the NetWare server has 
> the NFS namespace loaded.  I looked at you code in more detail, and I 
> did not see support their for the NFS/Unix namespace.  

> Is this in a newer version, or has it not been implemented yet?  I was
> testing with MARS and Native NetWare this evening and saw this.  If the 
> NFS namespace is loaded, you should be able to get to it and access and 
> set all these bits in the file system namespace directory records.
> 
> Do you need any info from me to get this working, or is there another
> version where I can get this for Ute-Linux?

Hi Jeff,
  ncpfs does not support NFS fields, as access through namespace functions
is hopelessly broken (modify ns specific info has swapped some bits
in mask which data update and which not), and it also adds some (100%)
overhead on directory/inode lookups, as you must ask twice - first for
non-NFS info, and second for NFS specific...

  There exists patch from Ben Harris <bjh21@cus.cam.ac.uk>, which adds
this feature to 2.2.16 kernel and 2.2.0.17 ncpfs. You can download
it from ftp://platan.vc.cvut.cz/pub/linux/ncpfs/ncp{1,2}.pat. ncp1.pat
is kernel patch (including email headers; cut them if applying), ncp2.pat
is patch for 2.2.0.17 ncpfs userspace - it adds mount option "nfsextras".
(I apologize to Ben - I promised to integrate it into ncpfs, and into
2.4 kernel, but...)

  Except that, you can make all files non-executable by using
"filemode=0644" mount option. Or you can use "extras,symlinks", in which
case (NFS namespace incompatible) hidden/shareable/transactional attributes
are used to signal executability of file...

  If you have some document which describes what each NFS specific field 
does - currently ncpfs names them "name", "mode", "gid", "nlinks", "rdev",
"link", "created", "uid", "acsflag" and "myflag" - if I remember correctly,
it is how Unixware 2.0 nuc.h names them. And I did not found any information
about layout of NFS huge info, which is used for hardlinks :-(

  Also, as NCP 87,8 kills almost every NW server I know, if used namespace
is NFS, I'm a bit sceptic about usability of NCP 87,* on NFS namespace.

  In 1998 and 1999 I tried to ask Novell for documentation of NCP 95,*
(Netware Unix Client), but it was refused and ignored, so... here we are.
                                                Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
P.S.: Jeff, if you want, there is ncpfs/MaRS/LinWare specific list,
linware@sh.cvut.cz. Subscribe: "subscribe linware" to "listserv@sh.cvut.cz".
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
