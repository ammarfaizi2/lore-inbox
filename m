Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274092AbRISPrj>; Wed, 19 Sep 2001 11:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274101AbRISPr3>; Wed, 19 Sep 2001 11:47:29 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:9093 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S274092AbRISPrO>; Wed, 19 Sep 2001 11:47:14 -0400
Date: Wed, 19 Sep 2001 11:47:23 -0400
To: sujal@sujal.net
Cc: codalist@TELEMANN.coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: Coda and Ext3
Message-ID: <20010919114721.C14151@cs.cmu.edu>
Mail-Followup-To: sujal@sujal.net, codalist@TELEMANN.coda.cs.cmu.edu,
	linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <3B9792FB.7020708@progress.com> <20010906115302.B826@cs.cmu.edu> <1000909441.2017.20.camel@pcsshah>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1000909441.2017.20.camel@pcsshah>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2001 at 10:23:36AM -0400, Sujal Shah wrote:
>      The Linux Coda drivers and the ext3 patches don't seem to get along
> very well, at least in Linux 2.4.7.  I've got a stock 2.4.7 kernel with
> a patch applied to the USB drivers (for a sony digital camera; see
> http://www.sujal.net/tech/linux/ just a change in unusual_devs.h). 
> 
> After I applied the ext3 patches from
> http://www.uow.edu.au/~andrewm/linux/ext3/ .  Basically, when an
> application tries to write to a file system mounted via coda, the
> application terminates with "Memory Fault" returned to the terminal. 
> THe file system still thinks it's busy (can't umount).

Yeah, I know, and it will probably work when you don't enable
data-journalling. Coda's kernelmodule currently uses generic_file_read
and generic_file_write on it's containerfiles, which works for many
filesystems. However, ext3fs (and tmpfs and several others) have a
filesystem specific write implementation and don't really like being
called with the generic functions.

The patch is simple, but I haven't made it yet. Basically we need to
wrap the read/write calls and call cii->c_cfile->f_op->file_write or
something.

> loaded, however.  Also, I backed out the patches for ext3 and the
> problem went away.

ext2 uses the generic file read/write functions, so whenever ext2 is the
underlying filesystem it all works fine.

Jan

