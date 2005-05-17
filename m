Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVEQFjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVEQFjX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 01:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVEQFjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 01:39:17 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:15374 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261155AbVEQFjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 01:39:00 -0400
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: Valdis.Kletnieks@vt.edu
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <200505161758.j4GHw4EW009866@turing-police.cc.vt.edu>
References: <1116263665.2434.69.camel@CoolQ>
	 <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
	 <1116266644.2434.86.camel@CoolQ>
	 <200505161758.j4GHw4EW009866@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116348446.2428.38.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 17 May 2005 12:47:26 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 13:58, Valdis.Kletnieks@vt.edu wrote:

> You'd be better off pointing out that 'man 2 write' lists the errors
that
> might be returned as:  EBAF, EINVAL, EFAULT, EFBIG, EPIPE, EAGAIN,
EINTR,
> ENOSPC, and EIO.
> 
> Does the POSIX spec allow write() to return -EROFS?
If there is POSIX spec about this issue, I won't post this RFD.  
> What happens if you're writing to an NFS-mounted file system, and the
remote
> system remounts the disk R/O?  What is reported in that case?
So, it's necessary to define the right error in this case.
Each FS will follow this standard, give the defined error;
User can follow this standard, without caring what FS they're using.
 
> > The purpose of this RFD, is to get the community to understand,
> > all I/O related syscalls should return VFS error, not FS error.
> 
> All fine and good, until you hit a case like ext3 where reporting
> the FS error code will better explain the *real* problem than forcing
> it to fit into one of the provided VFS errors.

So, if linux supports a new FS, which returns another error,
does that mean the app should be rewritten to include the new
error? There should be some standards constraint this behavour.

> > User mode app should not care about the FS they are using. 
> > So, the community should define the ONLY VFS error first.
> 
> I think that's been done, and the VFS behavior is "if the FS reports
> an error we pass it up to userspace".

Then,from userspace, V (of VFS) loses its meaning, because the
error is FS-related, not FS-unrelated.

regards,
----
Qu Fuping 


