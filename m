Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbUBZQpl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 11:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbUBZQpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 11:45:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:63129 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262817AbUBZQpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 11:45:31 -0500
Subject: Re: Latest AIO patchset
From: Daniel McNeil <daniel@osdl.org>
To: Hayim Shaul <hayim@post.tau.ac.il>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402261525460.29206-100000@soul.math.tau.ac.il>
References: <Pine.LNX.4.44.0402261525460.29206-100000@soul.math.tau.ac.il>
Content-Type: text/plain
Organization: 
Message-Id: <1077813902.1956.282.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Feb 2004 08:45:02 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you checking the return value of write()?

O_DIRECT has alignment requirements since it writes directly from
user-space to disk by passing the page cache.  Also the size
of the write has to be a multiple of 512 (for 2.6).
Try using posix_memalign() with pagesize as the alignment arg
to allocated the data buffer.  O_DIRECT does work on ext3.

Daniel

On Thu, 2004-02-26 at 05:30, Hayim Shaul wrote:
> On Wed, 25 Feb 2004, Benjamin LaHaise wrote:
> 
> > On Wed, Feb 25, 2004 at 08:45:29PM +0200, Hayim Shaul wrote:
> > > What exactly is the O_DIRECT flag? When I add this flag to the open func
> > > it fails.
> > > 
> > > More specificaly, this function fails
> > >   open("filename", O_RDWR | O_DIRECT | O_LARGEFILE | O_CREAT, S_IRWXU);   
> > > 
> > > but this one succeeds
> > >   open("filename", O_RDWR | O_LARGEFILE | O_CREAT, S_IRWXU);   
> > > 
> > > I'm running linux 2.6.0 with libaio 0.3.92.
> > 
> > Which filesystem?  Not all support O_DIRECT.
> > 
> 
> ext3
> I'm think it does support ext3.
> 
> Actually, I was wrong. open does succeed. It return a valid fd
> but after writing and exiting, the file is still zero size.
> 
> removing the O_DIRECT with the same prog writes quite alot to the file.
> 
> Hayim.
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

