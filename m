Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263847AbTF2Tra (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTF2Tr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:47:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22423 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263847AbTF2TqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:46:01 -0400
Date: Sun, 29 Jun 2003 21:00:20 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291545410600.02136814@smtp.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 03:45:41PM -0400, rmoser wrote:

> >> seen this written by many people who choose to use ext3.  Thus proving
> >> that there is value in in-place filesystem conversion :)
> >
> >Uh-huh.  You want to get in-kernel conversion between ext* and reiserfs?
> >With recoverable state if aborted?  Get real.
> 
> no, in-kernel conversion between everything.  You don't think it can be done?
> It's not that difficult a problem to manage data like that :D

I think that I will believe it when I see the patchset implementing it.
Provided that it will be convincing enough.  Other than that...  Not
really.  You will need code for each pair of filesystems, since
convertor will need to know *both* layouts.  No amount of handwaving
is likely to work around that.  And we have what, something between
10 and 20 local filesystems?  Have fun...

If you want your idea to be considered seriously - take reiserfs code,
take ext3 code, copy both to userland and put together a conversion
between them.  Both ways.  That, by definition, is easier than doing
it in kernel - you have the same code available and none of the limitations/
interaction with other stuff.  When you have it working, well, time to
see what extra PITA will come from making it coexist with other parts
of kernel (and with much more poor runtime environment).

AFAICS, it is _very_ hard to implement.  Even outside of the kernel.
If you can get it done - well, that might do a lot for having the
idea considered seriously.  "Might" since you need to do it in a way
that would survive transplantation into the kernel _and_ would scale
better that O((number of filesystem types)^2).
