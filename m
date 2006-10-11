Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWJKTIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWJKTIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWJKTIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:08:32 -0400
Received: from 1wt.eu ([62.212.114.60]:32516 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932459AbWJKTIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:08:31 -0400
Date: Wed, 11 Oct 2006 20:24:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SOT] GIT usage question
Message-ID: <20061011182415.GE5050@1wt.eu>
References: <452D3DFA.6010408@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452D3DFA.6010408@tls.msk.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 10:54:50PM +0400, Michael Tokarev wrote:
> For quite some time I'm trying to understand if it's possible
> to extract changes from some subsystem's GIT tree compared to
> some version of linux kernel.
> 
> For example, let's say I want to see if my SATA controller will
> work with current libata, but without all the pain of trying
> current 2.6.19-pre/rc instabilities.  Libata changes are quite
> local for the subsystem, so in theory, or at least how I see
> it, that should be possible.
> 
> So I have 3 remote branches in my local GIT tree:
> 
>  o origin which points to Linus's 2.6.19-pre
>  o libata, which is current libata tree
>  o 2.6.18 release -- the kernel I'm running right now.
> 
> I want to get changes *for libata subsystem* in origin or
> libata (libata is just changes which are on the way to Linus,
> and current difference is very minor), to apply against 2.6.18.
> Ie, in short, changes which went to origin *from* libata.
> 
> Is it possible?

If I understand what you want to do, you just have to do this :

$ git-checkout 2.6.18
$ git-pull . libata

This will merge in 2.6.18 everything that's in libata. If you
want to check before what will be merged :

$ git-log 2.6.18..libata
or :
$ git-diff 2.6.18..libata

or also to review the patches one at a time :

$ git-format-patch -k -m 2.6.18..libata

then read all the files.

Hoping it helps
willy

