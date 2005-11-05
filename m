Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbVKEQon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbVKEQon (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVKEQon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:44:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:6535 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932144AbVKEQol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:44:41 -0500
Date: Sat, 5 Nov 2005 16:44:40 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, ak@suse.de
Subject: Re: [PATCH 01/25] compat: Remove leftovers from register_ioctl32_conversion
Message-ID: <20051105164440.GM7992@ftp.linux.org.uk>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com> <20051105162710.209305000@b551138y.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105162710.209305000@b551138y.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 05:26:51PM +0100, Arnd Bergmann wrote:
> We don't need the semaphore any more since we no longer
> write to the ioctl32 hash table while the kernel is running.

Could we *please* get rid of this ridiculous return type of compat_ioctl?

->ioctl() returns 32bit value.  Everywhere.  On 32 and 64 bit platforms.
Having ->compat_ioctl() return value twice wider than not just emulated
->ioctl(), but native one as well...

Let's kill that stupidity before adding fsckloads of new instances.
