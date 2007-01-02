Return-Path: <linux-kernel-owner+w=401wt.eu-S1755330AbXABPxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330AbXABPxb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755332AbXABPxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:53:31 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:60909 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755330AbXABPxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:53:30 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: error handling in sysfs, fill_read_buffer()
Date: Tue, 2 Jan 2007 16:53:30 +0100
User-Agent: KMail/1.8
Cc: Oliver Neukum <oliver@neukum.name>, gregkh@suse.de, maneesh@in.ibm.com,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0701021045120.4122-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0701021045120.4122-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701021653.31045.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 2. Januar 2007 16:47 schrieb Alan Stern:
> On Tue, 2 Jan 2007, Oliver Neukum wrote:
> 
> > Am Dienstag, 2. Januar 2007 16:26 schrieb Alan Stern:
> > > On Tue, 2 Jan 2007, Oliver Neukum wrote:
> > > 
> > > > Hi,
> > > > 
> > > > if a driver returns an error in fill_read_buffer(), the buffer will be
> > > > marked as filled. Subsequent reads will return eof. But there is
> > > > no data because of an error, not because it has been read.
> > > > Not marking the buffer filled is the obvious fix.
> > > > 
> > > > 	Regards
> > > > 		Oliver
> > > > 
> > > > Signed-off-by: Oliver Neukum <oliver@neukum.name>
> > > > --
> > > > 
> > > > --- a/fs/sysfs/file.c	2006-12-24 05:00:32.000000000 +0100
> > > > +++ b/fs/sysfs/file.c	2007-01-01 15:03:14.000000000 +0100
> > > > @@ -70,7 +70,8 @@
> > > >   *	Allocate @buffer->page, if it hasn't been already, then call the
> > > >   *	kobject's show() method to fill the buffer with this attribute's 
> > > >   *	data. 
> > > > - *	This is called only once, on the file's first read. 
> > > > + *	This is called only once, on the file's first read unless an error
> > > > + *	is returned.
> > > >   */
> > > 
> > > I don't think this matches what people expect of sysfs.  If a show method 
> > > fails then the assumption is that the file cannot be read at all, so 
> > > there's no point in trying to call the method again.
> > 
> > This would make handling ENOMEM very hard.
> 
> No harder than handling any other error: Close the sysfs file, then open 
> it and try to read it again.

If you close it, it doesn't matter. However if not, it does.
Not all the world simply uses "cat".

	Regards
		Oliver
