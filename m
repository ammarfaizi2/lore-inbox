Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262115AbSJJTcJ>; Thu, 10 Oct 2002 15:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbSJJTcJ>; Thu, 10 Oct 2002 15:32:09 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60425 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262115AbSJJTcH>; Thu, 10 Oct 2002 15:32:07 -0400
Date: Thu, 10 Oct 2002 12:36:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Wright <chris@wirex.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 capget fix
In-Reply-To: <20021009171500.B25393@figure1.int.wirex.com>
Message-ID: <Pine.LNX.4.44.0210101235290.2750-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Chris Wright wrote:
> 
> Daniel Jacobowitz noticed that sys_capget is not behaving properly when
> called with pid of 0.  It is supposed to return current capabilities,
> not those of swapper.  Also cleaned up some duplicate code from a merge
> error.  Patch is tested, please apply.

This is not correct. You drop the tasklist_lock before you actually set 
read the capabilities, which means that by the time you read them, the 
task you looked up may not be there any more.

		Linus

