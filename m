Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270067AbUJVOcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270067AbUJVOcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 10:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270097AbUJVOcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 10:32:18 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:24635 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S270067AbUJVOcQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 10:32:16 -0400
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
From: Kasper Sandberg <lkml@metanurb.dk>
To: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.aau.dk>
Cc: LKML Mailinglist <linux-kernel@vger.kernel.org>, umbrella@cs.aau.dk
In-Reply-To: <200410221613.35913.ks@cs.aau.dk>
References: <200410221613.35913.ks@cs.aau.dk>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 22 Oct 2004 16:32:15 +0200
Message-Id: <1098455535.12574.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 16:13 +0200, Kristian Sørensen wrote:
> Hi all!
> 
> After some more testing after the previous post of the OOPS in 
> generic_delete_inode, we have now found a gigantic memory leak in Linux 2.6.
> [789]. The scenario is the same:
> 
> File system: EXT3
> Unpack and delete linux-2.6.8.1.tar.bz2 with this Bash while loop:
> 
> let "i = 0"
> while [ "$i" -lt 10 ]; do
>    tar jxf linux-2.6.8.1.tar.bz2;
>    rm -fr linux-2.6.8.1;
>    let "i = i + 1"
> done
> 
> When the loop has completed, the system use 124 MB memory more _each_ time.... 
> so it is pretty easy to make a denial-of-service attack :-(
well.. i could understand if it used the total size of a unpacked linux
kernel, even after the loop stopped, since it would just keep it cached,
however, it might not be that case when it adds 124mb each time...
> 
> We have tried the same test on a RHEL WS 3 host (running a RedHat 2.4 kernel) 
> - and there is no problem.
> 
> 
> Any deas?
> 

