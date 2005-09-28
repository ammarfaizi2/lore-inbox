Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbVI1W2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVI1W2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVI1W2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:28:24 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:24398 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751130AbVI1W2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:28:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=3LXiVJdLH8cQmx8DojDbM3nQd2tRrRpkNy/X4diPe/b68WSLA+XgIqRUQSaqMtaa0CQqmmqOYmiSOoq1Sm9XIFuLgQZ5FAUk9DsHk9V/rl31ZEzt7URzVYRVdRtM+I8vD8mkTZAmI2yoBq1ccWdL71CVKO4r9T25p2LxTUm/dFI=  ;
Date: Thu, 29 Sep 2005 00:28:22 +0200
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl
Subject: Re: [PATCH] remove check_region in drivers-char-specialix.c
Message-ID: <20050928222822.GA14949@gollum.tnic>
References: <20050928083737.GA29498@gollum.tnic> <20050928175244.GY7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928175244.GY7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 06:52:44PM +0100, Al Viro wrote:
> On Wed, Sep 28, 2005 at 10:37:37AM +0200, Borislav Petkov wrote:
> > Hi Andrew,
> > 
> >    This is also a pretty simple case. We remove the wrapper and make
> >    sx__request_io_range return struct resource *. We check its value accordingly
> >    in the probing routine. It compiles cleanly here.
> 
> NAK.  You've just introduced a pile of leaks - if sx_probe() fails after
> that call, you end up with region claimed and not released.

Andrew told me already today that Jeff[1] had sent a patch fixing all that. To
prevent the leaks he's calling sx_release_io_range(bp) in every check before
exiting sx_probe so this seems correct. A small question though: After calling
sx_request_io_range() in the if-statement on line 499 is it ok to call
sx_request_io_range() for a second time in a row on line 587?  I think in
this case the second call has to go, no?

[1]rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
