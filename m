Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750800AbVLYHad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVLYHad (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 02:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVLYHad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 02:30:33 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:21655 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750800AbVLYHac
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 02:30:32 -0500
Date: Sun, 25 Dec 2005 07:30:32 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: [PATCH] nfsd4_lock() returns bogus values to clients
Message-ID: <20051225073032.GA27946@ftp.linux.org.uk>
References: <20051225062937.GW27946@ftp.linux.org.uk> <20051225064933.GZ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225064933.GZ27946@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 06:49:33AM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: 1135493243 -0500
> 
> missing nfserror() in default case of a switch by return value of
> posix_lock_file(); as the result we send negative host-endian to
> clients that expect positive network-endian, preferably mentioned
> in RFC...  BTW, that case is not impossible - posix_lock_file()
> can return -ENOLCK and we do not handle that one explicitly.

Gaack...  s/nfserror/nfserrno/, of course...
