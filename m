Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbVGSTQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbVGSTQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVGSTQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:16:57 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:4257 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261981AbVGSTQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:16:56 -0400
X-ORBL: [63.202.173.158]
Date: Tue, 19 Jul 2005 12:16:48 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050719191648.GA24444@taniwha.stupidest.org>
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DD50FC.9090004@tu-harburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2005 at 09:14:04PM +0200, Jan Blunck wrote:

> >So you can seek to m*<stack-depth>+<offset> to access an offset into
> >something at depth m?
> >
>
> Yes.

Hos does that work if offset >= m?

> I disagree. Where is the information value of i_size if we always
> could return 0?

Directories clearly can't have zero size, so 0 means 'special'.

Anything other than zero *might* be a real value.

> IMO it should be at least an upper bound for the "number" of
> informations that could actually be read (in terms of a seek offset)
> like it is in the case of regular files.

Why?  And what should that upper bound be?

> Better, if it is a strict upper bound so that you can seek to every
> value smaller than i_size. For this purpose the i_size of
> directories doesn't need to reflect any unit.

lseek talks about bytes --- yes, it means for files specifically but I
still don't see why we need to define more counter-intuitive semantics
for directories when we don't need them.

Also, how is lseek + readdir supposed to work in general?
