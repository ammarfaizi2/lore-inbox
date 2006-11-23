Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755886AbWKWEfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755886AbWKWEfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 23:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755910AbWKWEfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 23:35:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:53220 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1755626AbWKWEfs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 23:35:48 -0500
Date: Thu, 23 Nov 2006 04:35:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: dgc@sgi.com, jesper.juhl@gmail.com, chatz@melbourne.sgi.com,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com, xfs-masters@oss.sgi.com,
       netdev@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Message-ID: <20061123043543.GI3078@ftp.linux.org.uk>
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com> <9a8748490611220458w4d94d953v21f7a29a9f1bdb72@mail.gmail.com> <20061123011809.GY37654165@melbourne.sgi.com> <20061122.201013.112290046.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061122.201013.112290046.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 08:10:13PM -0800, David Miller wrote:
> From: David Chinner <dgc@sgi.com>
> Date: Thu, 23 Nov 2006 12:18:09 +1100
> 
> > So, assuming the stacks less than 32 bytes are 32 bytes, we've got
> > 1380 bytes in the XFS stack there, 
> 
> On sparc64 just the XFS parts of the backtrace would be a minimum of
> 2816 bytes (each function has a minimum 8 * 16 byte stack frame, and
> there are about 22 calls in that trace).  It's probably a lot more
> with local variables and such.
> 
> It's way too much.  You guys have to fix this stuff.
> 
> If TCP's full send and receive path can be done in less function
> calls, XFS can allocate blocks in less too.
> 
> I would even say 10 function calls deep to allocate file blocks
> is overkill, but 22 it just astronomically bad.

Especially since a large part is due to cxfs...
