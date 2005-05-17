Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbVEQQxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVEQQxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVEQQxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:53:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15572 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261836AbVEQQxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:53:31 -0400
Date: Tue, 17 May 2005 17:53:53 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Greg K-H <greg@kroah.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix root hole in raw device
Message-ID: <20050517165353.GB29811@parcelfarce.linux.theplanet.co.uk>
References: <11163046682662@kroah.com> <11163046681444@kroah.com> <20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk> <1116335082.1963.58.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116335082.1963.58.camel@sisko.sctweedie.blueyonder.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 02:04:42PM +0100, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2005-05-17 at 05:57, Al Viro wrote:
> 
> > That is not quite correct.  You are passing very odd filp to ->ioctl()...
> > Old variant gave NULL, which is also not too nice, though.
> 
> Which would you prefer?  I guess that if there _are_ going to be
> problems, we'd be better off finding them early by passing in the NULL
> value.

For now I'd rather pass NULL.  Longer term (== post 2.6.12, since There Is No
2.7(tm)) - just remove the struct file * argument of bdev ioctl and have
int flags used instead, with "opened for write" and "opened non-blocking"
passed in it.  And switch the inode argument to bdev...
