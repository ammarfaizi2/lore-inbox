Return-Path: <linux-kernel-owner+w=401wt.eu-S1752021AbWLNG4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWLNG4Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752027AbWLNG4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:56:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51954 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbWLNG4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:56:25 -0500
Date: Thu, 14 Dec 2006 06:56:24 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] ib_verbs: Use explicit if-else statements to avoid errors with do-while macros
Message-ID: <20061214065624.GN4587@ftp.linux.org.uk>
References: <1166065805.6748.135.camel@gullible> <20061214064430.GM4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061214064430.GM4587@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2006 at 06:44:30AM +0000, Al Viro wrote:
> On Wed, Dec 13, 2006 at 10:10:05PM -0500, Ben Collins wrote:
> > At least on PPC, the "op ? op : dma" construct causes a compile failure
> > because the dma_* is a do{}while(0) macro.
> > 
> > This turns all of them into proper if/else to avoid this problem.
> 
> NAK.
> 
> Proper fix is to kill stupid do { } while (0) mess.  It's supposed
> to behave like a function returning void, so it should be ((void)0).

BTW, even though the original patch is already merged, I think that
we ought to get rid of do-while in such stubs, exactly to avoid such
problems in the future.  Probably even add to CodingStyle - it's not
the first time such crap happens.

IOW, do ; while(0) / do { } while (0)  is not a proper way to do a macro
that imitates a function returning void.

Objections?
