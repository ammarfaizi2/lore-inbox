Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbRESXji>; Sat, 19 May 2001 19:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262015AbRESXj2>; Sat, 19 May 2001 19:39:28 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59040 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262020AbRESXjP>;
	Sat, 19 May 2001 19:39:15 -0400
Date: Sat, 19 May 2001 19:39:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B070257.5632A059@mandrakesoft.com>
Message-ID: <Pine.GSO.4.21.0105191933280.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 19 May 2001, Jeff Garzik wrote:

> Are we talking about device arguments just for chrdevs and blkdevs? 
> (ie. drivers)  or for regular files too?

Let's distinguish between per-fd effects (that's what name in open(name, flags)
is for - you are asking for descriptor and telling what behaviour do you
want for IO on it) and system-wide side effects.

IMO encoding the former into name is perfectly fine, and no write on
another file can be sanely used for that purpose. For the latter, though,
we need to write commands into files and here your miscdevices (or procfs
files, or /dev/foo/ctl - whatever) is needed.


