Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbTIHIMK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbTIHIMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 04:12:10 -0400
Received: from angband.namesys.com ([212.16.7.85]:56003 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S262043AbTIHIMH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 04:12:07 -0400
Date: Mon, 8 Sep 2003 12:12:06 +0400
From: Oleg Drokin <green@namesys.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org,
       Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908081206.GA17718@namesys.com>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831191419.A23940@bitwizard.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Aug 31, 2003 at 07:14:19PM +0200, Rogier Wolff wrote:

> Would it be possible to do something like: "pretend that there
> are always 100 million inodes free", and then report sensible
> numbers to "df -i"? 

This won't work. No sensible numbers would be there.

> There  is no installation program that will fail with: "Sorry, 
> you only have 100 million inodes free, this program will need
> 132 million after installation", and it allows me a quick way 
> of counting the number of actual files on the disk.... 

You cannot. statfs(2) only exports "Total number of inodes on disk" and
"number of free inodes on disk" values for fs. df substracts one from another one
to get "number of inodes in use".
Actually we export necessary numbers through sysfs for now. And we have patch
in our tree that just sets statfs(2) inode stuff to zero. You should see it after
next snapshot is released.

$ cat /sys/fs/reiser4/hdb1/oids_in_use
104875
$ cat /sys/fs/reiser4/hdb1/next_to_use
261239

Bye,
    Oleg
