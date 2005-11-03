Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbVKCS7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbVKCS7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 13:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVKCS7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 13:59:20 -0500
Received: from pat.uio.no ([129.240.130.16]:64975 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1030441AbVKCS7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 13:59:19 -0500
Subject: Re: Kernel BUG
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10511031746300.3457-100000@mtfhpc.demon.co.uk>
References: <Pine.LNX.4.10.10511031746300.3457-100000@mtfhpc.demon.co.uk>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 13:59:11 -0500
Message-Id: <1131044351.8830.6.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.732, required 12,
	autolearn=disabled, AWL 1.27, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 18:10 +0000, Mark Fortescue wrote:
> Hi Trond,
> 
> I am running a sparc-linux kernel using an NFS Root and it is falling over
> with the trace below.
> 
> My Kernel is not a standard kernel (I have had to tweek it to get the
> SBUS GC3 and the 82077 floppy to work on my OPUS Sparc 1 clone).
> 
> Can you advise me on any known issues in the NFS Client code that might
> enter NULL pointers into the 'slot->slots[i]' in __lookup_tag.
> 
> If there are none that you are aware of, are there any specific areas that
> I should investigate with printk statements.

NFS does not ever directly access the radix tree internals: it always
uses the API, and it always protects those operations using the
NFS_I(inode)->req_lock.

Are you sure that radix_tree_init() is being called before the NFSroot
stuff is started? To me, this whole thing smells of memory scribble.

Cheers,
  Trond

