Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265238AbUAPBkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUAPBkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:40:45 -0500
Received: from waste.org ([209.173.204.2]:15811 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S265238AbUAPBkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:40:43 -0500
Date: Thu, 15 Jan 2004 19:40:37 -0600
From: Matt Mackall <mpm@selenic.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Add CRC32C chksums to crypto routines
Message-ID: <20040116014037.GN28521@waste.org>
References: <yqujisje43q9.fsf@chaapala-lnx2.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yqujisje43q9.fsf@chaapala-lnx2.cisco.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 03:31:10PM -0600, Clay Haapala wrote:
> This patch against 2.6.1 adds CRC32C checksumming capabilities to the
> crypto routines.  The structure of it is based wholly on the existing
> digest (md5) routines, the main difference being that chksums are
> often used in an "accumulator" fashion, effectively requiring one to
> set the seed, and the digest algorithms don't do that.
> 
> CRC32C is a 32-bit CRC variant used by the iSCSI protocol and in other
> drivers.  iSCSI uses scatterlists, so it was strongly suggested by the
> SCSI maintainers during reviews of Version 4 of the linux-iscsi driver
> that the code be added to the crypto routines, which operate on
> scatterlists.
> 
> Test routines have been added to tcrypt.c.
> 
> The linux-iscsi project can be found on SourceForge:
>   http://sourceforge.net/projects/linux-iscsi/

Clay!

The cryptoapi stuff seems sensible, but we've already got at least one
copy of the core crc32c code in the kernel at net/sctp/crc32c.c. It'd
be better to work with the sctp folks to push this into lib/crc32.c.
Handling multiple polynomials shouldn't be too painful there.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
