Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbUDMQ5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263598AbUDMQ5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:57:11 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:52744 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263274AbUDMQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:56:59 -0400
Message-ID: <407C1BEC.30801@techsource.com>
Date: Tue, 13 Apr 2004 12:57:16 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Guillaume@Lacote.name
CC: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
References: <200404131744.40098.Guillaume@Lacote.name>
In-Reply-To: <200404131744.40098.Guillaume@Lacote.name>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Guillaume Lacôte wrote:
> Hi,
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
> 
[snip]

I have a suggestion.  If you're compressing only for the sake of 
obfuscation, then don't really try to save any space.  Use a fast 
compression algorithm which doesn't necessarily do a great job.

When you're going to write, compress the block.  If it gets smaller, 
fine.  Store it in the same space it would have required even if it were 
uncompressed.  If the block gets bigger, then store it uncompressed. 
Whether or not the block could be compressed would be stored in metadata 
(in the inode, I guess).

