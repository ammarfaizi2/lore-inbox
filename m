Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUFYTqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUFYTqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266197AbUFYTqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:46:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33980 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265360AbUFYTqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:46:14 -0400
Date: Fri, 25 Jun 2004 20:46:11 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] A generic_file_sendpage()
Message-ID: <20040625194611.GQ12308@parcelfarce.linux.theplanet.co.uk>
References: <20040608154438.GK18083@dualathlon.random> <20040608193621.GA12780@holomorphy.com> <1086783559.1194.24.camel@boxen> <20040625191924.GA8656@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040625191924.GA8656@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2004 at 09:19:24PM +0200, Jörn Engel wrote:
> > +       old_fs = get_fs();
> > +       set_fs(KERNEL_DS);

Eeek...  Don't do that, please - set_fs() is not a good thing to add for
no good reason.
 
> Your patch is *much* smaller than mine.  Looks lean and mean.  But you
> depend on the struct file* passed to generic_file_sendpage().
> 
> One of my goals for 2.7 is to get rid of all users of struct file* in
> the various read-, write- and send-functions.  Currently, there are
> four of them, you would introduce number five.

And how, pray tell, are you going to do that on filesystems that keep
part of context in file->private_data?
