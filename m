Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbTESAoE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 20:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTESAoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 20:44:03 -0400
Received: from uni01du.unity.ncsu.edu ([152.1.13.101]:901 "EHLO
	uni01du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S262278AbTESAoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 20:44:03 -0400
From: jlnance@unity.ncsu.edu
Date: Sun, 18 May 2003 20:53:16 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jim Nance <jlnance@us54.synopsys.com>, jlnance@unity.ncsu.edu,
       linux-kernel@vger.kernel.org, gary.nifong@synopsys.COM,
       James.Nance@synopsys.COM, david.thomas@synopsys.COM
Subject: Re: NFS problems with Linux-2.4
Message-ID: <20030519005316.GA20055@ncsu.edu>
References: <20030513145023.GA10383@ncsu.edu> <16065.3323.449992.207039@charged.uio.no> <20030515112231.A28148@synopsys.com> <shsznlkjo53.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <shsznlkjo53.fsf@charged.uio.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 05:00:24PM +0200, Trond Myklebust wrote:
> 
> Sorry. stat doesn't obey close-to-open. It relies on standard
> attribute caching. close-to-open means "open()" (and only "open()")
> checks data cache consistency...

Trond,
    Thanks for the info.  Here is a section of the man page for open.
Is the information it gives correct wrt using link & stat?

       O_EXCL When  used with O_CREAT, if the file already exists
              it is an error and the open will fail. In this con
              text,  a  symbolic link exists, regardless of where
              its points to.  O_EXCL is broken on NFS  file  sys
              tems,  programs  which  rely  on  it for performing
              locking tasks will contain a race  condition.   The
              solution for performing atomic file locking using a
              lockfile is to create a unique file on the same  fs
              (e.g., incorporating hostname and pid), use link(2)
              to make a link to the lockfile. If  link()  returns
              0,  the lock is successful.  Otherwise, use stat(2)
              on the unique file to check if its link  count  has
              increased to 2, in which case the lock is also suc
              cessful.

Thanks,

Jim
