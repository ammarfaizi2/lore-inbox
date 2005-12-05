Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbVLEQBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbVLEQBZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 11:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbVLEQBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 11:01:25 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34971
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751379AbVLEQBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 11:01:24 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Indrek Kruusa <indrek.kruusa@tuleriit.ee>
Subject: Re: [QUESTION] Filesystem like structure in RAM w/o using filesystem (not ramdisk)
Date: Sun, 4 Dec 2005 18:39:46 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <438EE256.6040403@tuleriit.ee>
In-Reply-To: <438EE256.6040403@tuleriit.ee>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512041839.46914.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 05:45, Indrek Kruusa wrote:
> Hello!
>
> As I have understood the accessing ramdisk goes through the same kernel
> path which is meant for accessing slow block device (i_nodes caching etc.).
> Is there any other common way (some API above shared memory?) to
> create/open/read/write globally accessible hierarchical datablocks in RAM?
> Could it be possibly faster than ramdisk?

You can use ramfs which stores data in the page cache (no block device backing 
it, and no filesystem driver).  That's about as simple as you're going to 
get.

An expanded version of ramfs is tmpfs.  This allows you to set size limits 
(which you need to allow anybody other than root write access to one of these 
things; otherwise you can fill up memory and trivially bring down the 
system), and also allows the data to be swapped out (ramfs pins the dirty 
pages in memory, since there's no backing block device for it to be flushed 
to it just vetoes all attempts to do so.  Tmpfs substitutes the normal swap 
mechanism, whatever swap partitions or swap files you've set up.)

I have no idea what would happen if you tried to enable a swap file on a tmpfs 
mount, but since only root could be try that particular bit of peversity, 
it's almost certainly a "don't do that then"...

> Thanks in advance,
> Indrek

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
