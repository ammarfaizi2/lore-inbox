Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135742AbRDXUqd>; Tue, 24 Apr 2001 16:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135743AbRDXUqY>; Tue, 24 Apr 2001 16:46:24 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:49158 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135742AbRDXUqS>; Tue, 24 Apr 2001 16:46:18 -0400
Date: Tue, 24 Apr 2001 22:45:59 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Alexander Viro <viro@math.psu.edu>, Ed Tomlinson <tomlins@cam.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
Message-ID: <20010424224559.I2615@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010424152729.Z2615@arthur.ubicom.tudelft.nl> <200104241847.f3OIlc7T016933@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104241847.f3OIlc7T016933@webber.adilger.int>; from adilger@turbolinux.com on Tue, Apr 24, 2001 at 12:47:38PM -0600
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 12:47:38PM -0600, Andreas Dilger wrote:
> While I applaud your initiative, you made an unfortunate choice of
> filesystems to convert.  The iso_inode_info is only 4*__u32, as is
> proc_inode_info.  Given that we still need to keep a pointer to the
> external info structs, and the overhead of the slab cache itself
> (both CPU usage and memory overhead, however small), I don't think
> it is worthwhile to have isofs and procfs in separate slabs.

Well, I know a little bit about procfs because I'm currently
documenting it, so that's why I picked it first. After I got the idea,
isofs was quite easy.

In retrospect it would have been more effective to pick a filesystem
with a larger *_inode_info field, but then again: Al is right. Struct
inode is cluttered with *_inode_info fields, while we use anonymous
data entries in other parts of the kernel (like the data pointer in
struct proc_dir_entry, or the priv pointer in struct net_device).

There is another advantage: suppose you're hacking on a filesystem and
change it's *_fs_i.h header. With Al's proposal you only have to
recompile the filesystem you're hacking on, while you have to recompile
the complete kernel in the current situation.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
