Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWCTXcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWCTXcz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 18:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWCTXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 18:32:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:13497 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964967AbWCTXcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 18:32:54 -0500
Date: Mon, 20 Mar 2006 23:32:48 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060320233247.GF27946@ftp.linux.org.uk>
References: <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com> <20060319194723.GA27946@ftp.linux.org.uk> <20060320130950.GA9334@thunk.org> <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com> <4ae3c140603201136q7e61963dy635bb2c6047f0bc2@mail.gmail.com> <20060320195858.GD27946@ftp.linux.org.uk> <4ae3c140603201453p113c8c11h3029d1d55d209e27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140603201453p113c8c11h3029d1d55d209e27@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 05:53:08PM -0500, Xin Zhao wrote:
> Apparently this comparison is not 100% fair. In my experiment, I
> randomly pick pathname from 1.2 million path names to resolve the
> inode number. But in your "cp -rl linux2.6 foo1" experiment, you
> essentially did directory entry lookup sequentially, which maximize
> the possible performance. If you do the same thing in a random
> fashion, you will probably get much worse performance. As I said
> before, I totally agree that 2000/sec is slow. But the point here is
> whether 2000/sec is enough for most scenarios?

It is not; e.g. unpacking a tarball or running make(1) on even a
medium-sized tree is going to hurt that way.  Moreover, the same
goes for a lot of scripts, etc.

And that's aside of the question of CPU load you are inflicting -
it's not just 2000/sec, it's 2000/sec _and_ _nothing_ _else_ _gets_
_done_.

BTW, for real lookup speed, try find(1).  From hot cache.

> I am not saying existing FS implementation is not efficient. I agreed
> that file system has been fully optimized. What I want to say is to
> support complex mapping in the system I described before, we might
> need some extension on existing file systems. Question is what is the
> best extension. Consider how to allow user a, b to share physical copy
> f.1, while allowing user c to use private copy f.2? The virtual
> pathname to physical pathname should be transparent to end users. That
> is, all the users should be able to access right file copies using
> virtual path "f". The file system should be able to tell the different
> identity and return the data from the right physical copy. That's what
> we want to do. But it is hard to achieve without some extension. :)

So what happens upon rename()?
