Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUFWXrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUFWXrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUFWXrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:47:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42386 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262730AbUFWXrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:47:13 -0400
Date: Thu, 24 Jun 2004 00:47:12 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Daniel McNeil <daniel@osdl.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, Andy <genanr@emsphone.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] retry force umount (was Re: NFS and umount -f)
Message-ID: <20040623234712.GM12308@parcelfarce.linux.theplanet.co.uk>
References: <20040608155414.GA3975@thumper2> <1086710357.3896.11.camel@lade.trondhjem.org> <1088034175.2319.11.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088034175.2319.11.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2004 at 04:42:55PM -0700, Daniel McNeil wrote:
> This works for me on 2.6.7 as well.  However, I would get EBUSY back
> if processes were hung doing nfs operations to the downed server.
> The processes would get unstuck and get EIO, but the umount would
> still fail.  Doing a 2nd umount -f with no processes waiting for
> the server would succeed.  This patch retries force umounts in
> the kernel an extra time after giving them time to wake up and
> get out of the kernel.  It doesn't seem quite right to fail
> a bunch of nfs operations and leave the file system mounted.

Is there any reason to do that in the kernel?  What, umount(8) can't do the
same?
