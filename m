Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264561AbUF1AKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264561AbUF1AKx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 20:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUF1AKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 20:10:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:49054 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264561AbUF1AKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 20:10:51 -0400
Date: Sun, 27 Jun 2004 17:10:44 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>, Andries Brouwer <aebr@win.tue.nl>,
       <greg@kroah.com>, <arjanv@redhat.com>, <jgarzik@redhat.com>,
       <tburke@redhat.com>, <linux-kernel@vger.kernel.org>,
       <mdharm-usb@one-eyed-alien.net>, <david-b@pacbell.net>,
       zaitcev@redhat.com
Subject: Re: drivers/block/ub.c
Message-Id: <20040627171044.052a67c6@lembas.zaitcev.lan>
In-Reply-To: <Pine.LNX.4.44L0.0406271108190.10134-100000@netrider.rowland.org>
References: <200406271624.18984.oliver@neukum.org>
	<Pine.LNX.4.44L0.0406271108190.10134-100000@netrider.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 11:19:38 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> My favorite approach has always been:
> 
> 	put_be32(cmd->cdb + 2, block);
> 
> Unfortunately there is no such function or macro!  It's easy to define an
> inline function that would carry out the series of four single-byte
> assignments that originally started this discussion.  A more sophisticated
> implementation would expand to Andries' unspeakably ugly code on
> big-endian platforms that don't impose a large penalty for non-aligned
> 4-byte accesses.  I leave it up to others to decide which is best on
> little-endian platforms that can do unaligned accesses.
> 
> I think it would be great if some such utility routine were added to a
> standard header in the kernel, together with its siblings put_le32(),
> put_be16(), put_le16(), and the corresponding get_xxxx() functions.

This is very nice and would be a great help for Infiniband developers.
However, parts of SCSI commands are not defined in terms of C structures
or even 32 bit words with an endianness. They are streams of bytes, at
least historically. Please kindly refer to the WRITE(6) command for
the evidence. You'd need put_be20() to form that block address. :-)

I write these byte marshalling sequences since 1985 and I'm a little
used to them. I do not recall thinking twice about writing that element
of ub. It probably doesn't deserve all the tempest Oliver raised over it.

-- Pete
