Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755170AbWKMQAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbWKMQAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755174AbWKMQAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:00:48 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55967 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1755170AbWKMQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:00:47 -0500
X-Sasl-enc: glEZqEz3buTIWP/bPWm2KmSqkXw/UeAJnHVBElAgj6SR 1163433088
Subject: Re: [PATCH] autofs4 - panic after mount fail
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "bibo,mao" <bibo.mao@intel.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1292.1163416033@redhat.com>
References: <Pine.LNX.4.64.0611121732010.2724@raven.themaw.net>
	 <1292.1163416033@redhat.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 23:51:22 +0800
Message-Id: <1163433082.3016.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-13 at 11:07 +0000, David Howells wrote:
> Ian Kent <raven@themaw.net> wrote:
> 
> > -	if (sbi->pipe) {
> > -		fput(sbi->pipe);	/* Close the pipe */
> > -		sbi->pipe = NULL;
> > -	}
> > +	fput(sbi->pipe);	/* Close the pipe */
> > +	sbi->pipe = NULL;
> 
> Ummm...  Is that right?  fput() doesn't check its argument for a NULL pointer,
> so the original code shouldn't hurt and should give you an extra bit of
> defense.

HaHa .. sometimes it's people saying "get id of that you don't need it"
and other times it's the opposite.

Setting sbi->catatonic = 1 upon entry to autofs[4]_fill_super ensures
that autofs[4]_catatonic_mode is not called until after sbi->pipe is non
NULL. So I decided, in this case, to remove the test.

Ian


