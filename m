Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTAOVXS>; Wed, 15 Jan 2003 16:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbTAOVXS>; Wed, 15 Jan 2003 16:23:18 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:58851 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267322AbTAOVXQ> convert rfc822-to-8bit; Wed, 15 Jan 2003 16:23:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Mark H. Wood" <mwood@IUPUI.Edu>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ISO-9660 Rock Ridge gives different links different inums
Date: Wed, 15 Jan 2003 15:28:42 -0600
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.33.0301151601240.29932-100000@mhw.ULib.IUPUI.Edu>
In-Reply-To: <Pine.LNX.4.33.0301151601240.29932-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301151528.42592.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 January 2003 03:07 pm, Mark H. Wood wrote:
> On Fri, 10 Jan 2003, Horst von Brand wrote:
> > Peter Chubb <peter@chubb.wattle.id.au> said:
> > [...]
> >
> > > The problem is that in Unix the fundamental identity of a file is
> > > the tuple (blkdev, inum); names are merely indices (links) that resolve
> > > to that tuple.   Personally, I'd swap to a pair of system calls to map
> > > name to (blkdev, inum), and open(blkdev, inum).  Think of the inode
> > > number as a unique within-filesystem index.
> >
> > That way any joker can go ahead and open any file, without any regard to
> > permission bits on the directories that lead there. Not nice.
>
> Welcome to VMS, which can open files by INDEXF.SYS offset.  Some app.s
> which create and delete files rapidly never bother to make directory
> entries at all.  It may not be what you're used to, and it may be contrary
> to expected Unix semantics, but it's not unthinkable.

Or UNICOS, which then restricts the system call to only privileged operation:

This is (I believe) used to optimize a user mode NFS daemon by eliminating 
multiple namei translations (plus locking). The process is secure by not 
permitting the user to have the same privilege mapping of the daemon (thus
the old "kill nfsd" denial of service attack fails). There are also hints that 
this is used to optimize checkpoint/restart capabilities too.

NAME
     openi - Opens a file by using the inode number

SYNOPSIS
     int openi (long dev, long ino, long gen, long uflag);

IMPLEMENTATION
     Cray PVP systems

DESCRIPTION
     The openi system call presents the user with a flat view of all native
     UNICOS file systems currently mounted.  Rather than use the directory
     tree structure to search through directories for a file, openi
     provides access by inode number.

     The openi system call accepts the following arguments:

     dev       Specifies the device number as built by the makedev macro
               that is defined outside of the kernel.

     ino       Specifies an inode number for the file as reported by the ls
               -i command.

     gen       Specifies the generation number of the inode.  This provides
               a unique identification for a specific file.  The generation
               number changes when an inode is reused.  To print the inode
               generation values, use the fck(1) command with the -i and -l
               options.

     uflag     Specifies the open flags.  These are bit values of the form
               O_name that are defined in the fcntl.h file.

     Character, block, and FIFO special files are not allowed.  Specifying
     a dev and ino pair that point to one of these will produce an EINVAL
     error code.

NOTES
     Only a process with appropriate privilege can use this system call.

     If the PRIV_SU configuration option is enabled, the super user is
     allowed to use this system call.

     A process with the PRIV_MAC_READ and PRIV_DAC_OVERRIDE effective
     privileges are allowed to use this system call.  See the effective
     privilege discussion in the NOTES section of the open(2) man page for
     additional privilege requirements.  The open(2) search access
     discussions do not apply to this system call.

RETURN VALUES
     If openi completes successfully, a nonnegative integer is returned
     which may be used in further I/O operations.  Otherwise, openi returns
     a negative value, and errno is set to indicate the error.

ERRORS
     The openi system call fails to open the specified file if the
     following error condition or one of those listed on the open(2) man
     page occurs.

     Error Code          Description

     EINVAL              A dev and ino pair point to a character, block, or
                         FIFO special file.  The openi(2) system call does
                         not work with these types of files.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
