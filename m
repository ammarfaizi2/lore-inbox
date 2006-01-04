Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965107AbWADBYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWADBYb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 20:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965109AbWADBYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 20:24:31 -0500
Received: from pat.uio.no ([129.240.130.16]:38572 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965105AbWADBYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 20:24:30 -0500
Subject: Re: [PATCH] fix posix lock on NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Peter Staubach <staubach@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, ASANO Masahiro <masano@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <43BAD9DF.4090401@redhat.com>
References: <20051222.132454.1025208517.masano@tnes.nec.co.jp>
	 <43BAD2EC.2030807@redhat.com> <20060103194630.GL19769@parisc-linux.org>
	 <43BAD9DF.4090401@redhat.com>
Content-Type: text/plain
Date: Wed, 04 Jan 2006 02:24:07 +0100
Message-Id: <1136337847.7846.50.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.758, required 12,
	autolearn=disabled, AWL 1.19, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-03 at 15:09 -0500, Peter Staubach wrote:
> Matthew Wilcox wrote:
> >Mandatory locks aren't mandatory for other clients.
> >  
> >
> 
> So?
> 
> I guess that I don't understand this response.
> 
> The server is responsible for keeping itself from attempting to access
> a mandatory lock file.  The client is not responsible for doing so and
> trying to help the server is kind of a waste of time, mostly.
> 
> The mandatory lock mode bits really only come into play when attempting
> to read or write the file.  In this case, the system will automatically
> try to take a lock for the process, if that process does not already
> have a lock.  The server should prevent itself from trying to access
> files like this in order to avoid DoS attacks.
> 
> The NFS client does not support mandatory locking, mostly due to the
> possibility of DoS attacks and also due to the locking and NFS protocols
> not being sufficiently aware of each other.  NFSv4 can be used to address
> this latter problem, but probably not the former.
> 
> So, why deny lock requests for such files?  Especially on the client?

I agree, however that would have been a change in behaviour that would
have been hard to find time to test properly in an -rc6(?) release, so
we went for the quick and dirty fix.

Cheers,
  Trond

