Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTKKO1s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 09:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTKKO1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 09:27:47 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:5869 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263369AbTKKO1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 09:27:46 -0500
Subject: Re: OT: why no file copy() libc/syscall ??
From: Albert Cahalan <albert@users.sf.net>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davide.rossetti@roma1.infn.it, filia@softhome.net,
       jesse@cats-chateau.net, dwmw2@infradead.org, moje@vabo.cz,
       kakadu_croc@yahoo.com
In-Reply-To: <20031111133859.GA11115@bitwizard.nl>
References: <1068512710.722.161.camel@cube>
	 <20031111133859.GA11115@bitwizard.nl>
Content-Type: text/plain
Organization: 
Message-Id: <1068559904.722.200.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Nov 2003 09:11:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-11 at 08:38, Rogier Wolff wrote:
> On Mon, Nov 10, 2003 at 08:05:11PM -0500, Albert Cahalan wrote:
> > So open the file, change context, and then:
> > 
> > long copy_fd_to_file(int fd, const char *name, ...)
> > 
> > (if you can no longer read from the OPEN fd,
> > either we override that or we just don't care
> > about such mostly-fictional cases)
> 
> 
> Actually, I think we should have a: 
> 
> 	long copy_fd_to_fd (int src, int dst, int len)
> 
> type of systemcall. 

I don't think that works. To have a destination
file descriptor, you have to already have created
the destination file. Having done so, it may now
be impossible to transfer the security data. This
is especially the case with network filesystems.

I can well imagine providing a file descriptor for
the destination directory and making the filename
optional. This helps pin things down if there's
worry about an attacker moving directories, and it
neatly allows for fully anonymous temporary files
if a file descriptor is returned.


