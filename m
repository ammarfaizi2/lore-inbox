Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283003AbRLMB5E>; Wed, 12 Dec 2001 20:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRLMB4z>; Wed, 12 Dec 2001 20:56:55 -0500
Received: from chmls16.mediaone.net ([24.147.1.151]:34766 "EHLO
	chmls16.mediaone.net") by vger.kernel.org with ESMTP
	id <S282999AbRLMB4o>; Wed, 12 Dec 2001 20:56:44 -0500
Date: Wed, 12 Dec 2001 20:43:33 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
Message-ID: <20011212204333.A4017@pimlott.ne.mediaone.net>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Anton Altaparmakov <aia21@cam.ac.uk>,
	Nathan Scott <nathans@sgi.com>,
	Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <20011207202036.J2274@redhat.com> <20011208155841.A56289@wobbly.melbourne.sgi.com> <3C127551.90305@namesys.com> <20011211134213.G70201@wobbly.melbourne.sgi.com> <5.1.0.14.2.20011211184721.04adc9d0@pop.cus.cam.ac.uk> <3C1678ED.8090805@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1678ED.8090805@namesys.com>
User-Agent: Mutt/1.3.23i
From: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 12:21:49AM +0300, Hans Reiser wrote:
> Naming conventions are easy.

Hans,

While I look forward to your work, I think Anton points out some
issues that you really should try to address now, only you have not
understood them.  Can I take a crack at posing some concrete
questions that manifest the issues?

Let's imagine that we have a Linux system with an NTFS filesystem
and a reiserfs4 filesystem.  You can make any tentative assumptions
about reiserfs4 and new API's that you like, I just want to have an
idea of how you envision the following working:

First, I write a desktop application that wants to save an HTML file
along with some other object that contains the name of the creating
application.  The latter can go anywhere you want, except in the
same stream as the HTML file.  The user has requested that the
filename be /home/user/foo.html , and expects to be able to FTP this
file to his ISP with a standard FTP program.  What calls does my
application make to store the HTML and the application name?  If the
answer is different depending on whether /home/user is NTFS or
reiserfs4, explain both ways.

Second, I booted NT and created a directory in the NTFS filesystem
called /foo .  In the directory, I created a file called bar.  I
also created a named stream called bar, and an extended attribute
called bar.  Now I boot Linux.  What calls do I make to see each of
the three objects called bar?

The heart of Anton's argument is that the UNIX filesystem name space
is basically used up--there's just not much room to add new
semantics.  The only obvious avenue for extension is, if /foo is not
a directory, you can give some interpretation to /foo/bar .  But
this doesn't help if /foo is a directory.  So something has to give,
and we want to see what will give in reiserfs4.

Andrew
