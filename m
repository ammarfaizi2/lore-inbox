Return-Path: <linux-kernel-owner+w=401wt.eu-S1755290AbXABP0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290AbXABP0e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 10:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbXABP0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 10:26:34 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36464 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755290AbXABP0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 10:26:33 -0500
Date: Tue, 2 Jan 2007 10:26:32 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.name>
cc: gregkh@suse.de, <maneesh@in.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: error handling in sysfs, fill_read_buffer()
In-Reply-To: <200701020850.28724.oliver@neukum.name>
Message-ID: <Pine.LNX.4.44L0.0701021024110.4122-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Oliver Neukum wrote:

> Hi,
> 
> if a driver returns an error in fill_read_buffer(), the buffer will be
> marked as filled. Subsequent reads will return eof. But there is
> no data because of an error, not because it has been read.
> Not marking the buffer filled is the obvious fix.
> 
> 	Regards
> 		Oliver
> 
> Signed-off-by: Oliver Neukum <oliver@neukum.name>
> --
> 
> --- a/fs/sysfs/file.c	2006-12-24 05:00:32.000000000 +0100
> +++ b/fs/sysfs/file.c	2007-01-01 15:03:14.000000000 +0100
> @@ -70,7 +70,8 @@
>   *	Allocate @buffer->page, if it hasn't been already, then call the
>   *	kobject's show() method to fill the buffer with this attribute's 
>   *	data. 
> - *	This is called only once, on the file's first read. 
> + *	This is called only once, on the file's first read unless an error
> + *	is returned.
>   */

I don't think this matches what people expect of sysfs.  If a show method 
fails then the assumption is that the file cannot be read at all, so 
there's no point in trying to call the method again.

Alan Stern

