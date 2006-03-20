Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWCTNOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWCTNOp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWCTNOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:14:44 -0500
Received: from mail1.kontent.de ([81.88.34.36]:61077 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932286AbWCTNOn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:14:43 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: [PATCH]use kzalloc in vfs where appropriate
Date: Mon, 20 Mar 2006 14:14:19 +0100
User-Agent: KMail/1.8
Cc: "Pekka Enberg" <penberg@cs.helsinki.fi>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Matthew Wilcox" <matthew@wil.cx>, viro@zeniv.linux.org.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0603172153160.30725@fachschaft.cup.uni-muenchen.de> <84144f020603192325h54fd3212l1f4846fd40b9f074@mail.gmail.com> <200603201508.47960.vda@ilport.com.ua>
In-Reply-To: <200603201508.47960.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603201414.19998.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 20. März 2006 14:08 schrieb Denis Vlasenko:
> On Monday 20 March 2006 09:25, Pekka Enberg wrote:
> > > Rewriting the test as:
> > > n!=0 && n > INT_MAX / size
> > > saves the division because size is much likelier to be a constant, and indeed
> > > the code is better:
> > >
> > >         cmpq    $268435455, %rax
> > >         movq    $0, 40(%rsp)
> > >         ja      .L313
> > >
> > > Is there anything I am missing?
> 
> You may drop "n!=0" part, but you must check size!=0.
> Since if size is 0, kcalloc returns NULL, then

Why? size == 0 is a bug. We want to oops here.

	Regards
		Oliver
