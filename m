Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbTJTXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTJTXsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 19:48:09 -0400
Received: from [65.172.181.6] ([65.172.181.6]:31695 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262917AbTJTXsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 19:48:05 -0400
Subject: Re: AIO and DIO testing on 2.6.0-test7-mm1
From: Daniel McNeil <daniel@osdl.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20031020142727.GA4068@in.ibm.com>
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
	 <20031020142727.GA4068@in.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1066693673.22983.10.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 20 Oct 2003 16:47:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-20 at 07:27, Suparna Bhattacharya wrote:
> On Fri, Oct 17, 2003 at 04:12:58PM -0700, Daniel McNeil wrote:
> > I've been doing some testing on 2.6.0-test7-mm1 with O_DIRECT and
> > AIO.  I wrote some tests to check the buffered i/o verses O_DIRECT
> > i/o races and O_DIRECT verses truncate.
> 
> Sounds very useful - thanks for doing this !
> 
> > 
> > I still had apply suparna's direct-io.c patch to prevent oopses.
> > Suparna, you said the patch was not the complete patch, do you have
> > the complete patch?
> 
> Not yet.
> A complete patch would need to address one more case that's rather
> tricky to solve -- the case where a single dio request covers an 
> allocated region followed by a hole.
> 
> Besides that there is a pending bug to address -- i.e to avoid
> dropping i_sem during the actual i/o in the case where we are
> extending the file (an intervening buffered write could extend
> i_size, exposing uninitialized blocks). For AIO-DIO this means 
> forcing the i/o to be synchronous for this case (as also for 
> the case where we are overwriting an allocated region followed 
> by a hole). Until we can use i/o barriers.
> 
> I was playing with a retry-based implementation for AIO-DIO,
> where the first (tricky) case above becomes simple to handle ...
> But didn't get a chance to work much on this during the last 
> few days. I actually do have a patch, but there are occasional 
> hangs with a lot of AIO-DIO writes to an ext3 filesystem in 
> particular, that I can't explain as yet.
> 
> Do your testcases cover any of these cases already ?
> 
> Regards
> Suparna
> 

I was hoping that my test cases would hit some of these potential AIO
verses buffered write (growing the file and filling in holes) races.
My tests always write zeroes and holes should always return zeroes, so
the check makes sure that the data is always zero. I am planning on
updating the tests to have more readers and maybe more writers to
check if we ever see uninitialized data.  I am starting to test on
2.6-test8 and will let you know how it goes.

Daniel

