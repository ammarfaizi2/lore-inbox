Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVGTSLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVGTSLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVGTSLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:11:20 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:33676 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261448AbVGTSLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:11:15 -0400
X-ORBL: [63.202.173.158]
Date: Wed, 20 Jul 2005 11:11:01 -0700
From: Chris Wedgwood <cw@f00f.org>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050720181101.GB11609@taniwha.stupidest.org>
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <20050720112127.GC3890@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050720112127.GC3890@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2005 at 01:21:27PM +0200, J?rn Engel wrote:

> To my understanding, you can lseek to any "proper" offset inside a
> directory.  Proper means that the offset marks the beginning of a
> new dirent (or end of file) in the interpretation of the filesystem.

But you can never tell where these are in general.

> Userspace doesn't have any means to figure out, which addresses are
> proper and which aren't.  Except that getdents(2) moves the fd
> offset to a proper address, which likely will remain proper until
> the fd is closed.

I don't see why or how this can be true in general (it might be, but I
don't see how myself).  If we are half way through scanning a
directory and people start messing with it we could end up somewhere
bogus (in which case f_op->readdir I guess is expected to try and do
something sane here?)

> Reopening the same directory may result in a formerly proper offset
> isn't anymore.

For that to be the case where is the state kept to ensure your current
offset is valid?

