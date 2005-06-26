Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVFZMeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVFZMeb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 08:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261192AbVFZMeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 08:34:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8174 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261182AbVFZMe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 08:34:29 -0400
Date: Sun, 26 Jun 2005 13:34:26 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Steven French <sfrench@us.ibm.com>
Subject: Re: Fwd: Re: [patch 1/3] __leify posix_acl_xattr_entry, posix_acl_xattr_header
Message-ID: <20050626123426.GA15281@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
	Steven French <sfrench@us.ibm.com>
References: <200506222246.32763.adobriyan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506222246.32763.adobriyan@gmail.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2005 at 10:46:32PM +0400, Alexey Dobriyan wrote:
> Christoph, can you comment on what Steve said to my patch which is exactly
> the same as yours acl-endianess-annotations.patch?

Sure.

> ============================================================================
> From: Steven French <sfrench@us.ibm.com>
> 
> You may be correct, but making the in memory representations of these
> structions little endian seems wrong and I would be surprised if it were
> little endian, but I have not had time to think through what happens when a
> local filesystem takes an existing hard drive with ACLs on various inodes
> and moves the drive from a little endian to a big endian machine and the
> endian implications on this structure.
> 
> Although the representation on the wire for the cifs protocol is clearly
> little endian for the acl entries, I am uncomfortable with changes to the
> in memory representation until I do more checking.

I have asked myself that question aswell.  The odd thing about our posix
ACL implementation is that the ACL data passed to the xattr syscalls is
_always_ little endian, which is what the structure in this file define.

The incore represenation is in posix_acl.h and is always little endian.
