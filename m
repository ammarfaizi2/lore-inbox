Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131839AbRAJXiN>; Wed, 10 Jan 2001 18:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132301AbRAJXiD>; Wed, 10 Jan 2001 18:38:03 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:14346
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S131839AbRAJXhu>; Wed, 10 Jan 2001 18:37:50 -0500
Date: Thu, 11 Jan 2001 12:37:42 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Micah Gorrell <angelcode@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poll and Select not scaling
Message-ID: <20010111123742.A12271@metastasis.f00f.org>
In-Reply-To: <000401c07b5c$08d924b0$9b2f4189@angelw2k>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000401c07b5c$08d924b0$9b2f4189@angelw2k>; from angelcode@myrealbox.com on Wed, Jan 10, 2001 at 04:21:17PM -0700
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 04:21:17PM -0700, Micah Gorrell wrote:

    I have been trying to increase the scalabilty of an email server
    that has been ported to Linux.  It was originally written for
    Netware, and there we are able to provide over 30,000 connections
    at any given time.  On Linux however select stops working after
    the first 1024 connections.  I have changed include/linux/fs.h
    and updated NR_FILE to be 81920.  In test applications I have
    been able to create well over 30,000 connections but I am unable
    to do either a select or a poll on them.  Does any one know what
    I can do to fix this?

Which verion of linux and what libc are you using? For some time now
linux has supported the ability to select and poll on more than 102
FDs and several applications do indeed use this (squid for example).

For large numbers of FDs you probably want poll, which shouldn't give
you any problems. As you point out with sleect you need to redefine
NR_FILE or somesuch -- but hacking the kernel headers shouldn't be
necessary and may not help as libc will stull potentially get the
wrong value.

See where libc gets it from, I think recent libc version may allow
you to do something like:


#define NR_FILE	 <large-number>
#include <blah.h>
#include <blem.h>


but I could be wrong. Using poll you you have no problems.




  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
