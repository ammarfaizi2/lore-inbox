Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTLJPC4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 10:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbTLJPC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 10:02:56 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:31735 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S263544AbTLJPCy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 10:02:54 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Andre Hedrick <andre@linux-ide.org>, Valdis.Kletnieks@vt.edu
Subject: Re: Linux GPL and binary module exception clause?
Date: Wed, 10 Dec 2003 09:02:21 -0600
X-Mailer: KMail [version 1.2]
Cc: Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100512480.3805-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10312100512480.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Message-Id: <03121009022103.31567@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 December 2003 07:16, Andre Hedrick wrote:
> Very simple.
>
> Apply the basics of GPL and strip all the inlines to a file called
> kernel_inlines.[ch] and export all the symbols to export_symbol.

I belive that is what is done for the usermode includes (excluding the
inlines), and including some of the constants.

As a matter of fact, the user includes can't be used in the kernel anyway
since they ARE incomplete from the kernels point of view. They don't even
have to match the kernel at all.. They DO have to match the libc being
used, though.

> Thus all the cute tricks people try to taint the unprotecable interface is
> removed.  The basics of removing the code in question.
>
> If you holler wait you are changing the core and you can't BUZZIT.
> I can change what ever I want and distribute it where ever I care.

You are still deriving your binary from a GPL source when a module is loaded.
The kernel relocation symbols themselves are under GPL.

The advantage that the NVIDIA approach has is that all GPL symbols/relocation/
whatever is handled by the wrapper for the binary driver. And that wrapper is
distributed in an "acceptable" way.

The DISadvantage it has is that the "defined" module interface changes. And it
can even change during minor updates. The module interface is NOT a fixed 
target, like the usermode interface is. And then the NVIDIA driver(and/or
wrapper) will require changes to continue to work...

And bugs in a tainted kernel will continue to be unfixable.
