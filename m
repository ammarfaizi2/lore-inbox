Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVGTLV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVGTLV4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 07:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbVGTLV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 07:21:56 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:3052 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261156AbVGTLVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 07:21:55 -0400
Date: Wed, 20 Jul 2005 13:21:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050720112127.GC3890@wohnheim.fh-wedel.de>
References: <42D72705.8010306@tu-harburg.de> <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050719191648.GA24444@taniwha.stupidest.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 July 2005 12:16:48 -0700, Chris Wedgwood wrote:
> 
> Also, how is lseek + readdir supposed to work in general?

To my understanding, you can lseek to any "proper" offset inside a
directory.  Proper means that the offset marks the beginning of a new
dirent (or end of file) in the interpretation of the filesystem.

A filesystem could use offset n for directory entry n, or it could
interpret n as the offset in bytes and require that a dirent start at
this offset (else the offset wouldn't be proper) or it could be
anything else as well.

Userspace doesn't have any means to figure out, which addresses are
proper and which aren't.  Except that getdents(2) moves the fd offset
to a proper address, which likely will remain proper until the fd is
closed.  Reopening the same directory may result in a formerly proper
offset isn't anymore.

Does the above make sense?

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
