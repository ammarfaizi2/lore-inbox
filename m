Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUDOJ2v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 05:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUDOJ2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 05:28:51 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:5036 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261821AbUDOJ2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 05:28:50 -0400
Date: Thu, 15 Apr 2004 11:28:54 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040415092854.GA28721@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404131744.40098.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 April 2004 17:44:40 +0200, Guillaume Lacôte wrote:
> 
> I hope this is the right place to post this message; I tried to keep it small.
> Basically I really would like to implement compression at the dm level, 
> despite all of the problems. The reason for this is that reducing redundancy 
> through compression tremendously reduces the possibilities of success for an 
> attacker. I had implemented this idea in a java archiver ( 
> http://jsam.sourceforge.net ).
> 
> Although I am not a good kernel hacker, I have spent some time reading 
> compressed-loop.c, loop-aes, dm-crypt.c, and various threads from lkml 
> including http://www.uwsg.iu.edu/hypermail/linux/kernel/0402.2/0035.html
> Thus I would appreciate if you could answer the following questions regarding 
> the implementation of a "dm-compress" dm personality. 

Btw, looks like the whole idea is broken.  Consider a block of
known-plaintext.  The known plaintext happens to be at the beginning
of the block and has more entropy than the blocksize of your block
cypher.  Bang, you're dead.

Your whole approach depends on the fact, that any known plaintext in
the device is either not at the beginning of the block or has very
little entropy.  1k of zeroes already has too much entropy if you use
any form of huffman, so without RLE you're not frequently dead, but
practically always.

Does the idea still sound sane to you?

Jörn

-- 
...one more straw can't possibly matter...
-- Kirby Bakken
