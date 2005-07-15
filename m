Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVGOX04@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVGOX04 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 19:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVGOX04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 19:26:56 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:34064 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262053AbVGOXZV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 19:25:21 -0400
Subject: Re: reiserfs+acl makes processes hang?
From: Kasper Sandberg <lkml@metanurb.dk>
To: Tarmo =?ISO-8859-1?Q?T=E4nav?= <tarmo@itech.ee>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121469596.17539.9.camel@localhost>
References: <1121469596.17539.9.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 16 Jul 2005 01:25:20 +0200
Message-Id: <1121469920.18525.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

confirmed, i run 2.6.12 with reiserfs, created with reiserfsprogs 3.6.19

On Fri, 2005-07-15 at 23:19 +0000, Tarmo Tänav wrote:
> Hi,
> 
> I think I've found a bug in reiserfs acls. If triggered
> it means that any program trying to access the partition,
> where the bug occured, will just hang in D state, with
> no way to kill the program.
> 
> Here's how to reproduce:
> 1. mount a reiserfs volume (loopmount will do) with "-o acl".
> 2. create a directory "dir"
> 3. set some default acl: setfacl -d -m u:username:rwX dir
> 4. cd dir
> 5. dd if=/dev/zero of=somefile1 bs=4k count=100000
> (the idea is to run out of space)
> 6. now df should show 0 free space, if not then repeat 5.
> 7. echo "1" > somefile2 # this should hang infinitely
> 
> Now no program will be able to access the partition.
> 
> I haven't tried to reproduce it, but the same problem also happened
> when a user hit his hard quota limit on my server. Then no program
> could access his homedir.
> 
> 
> PS. I'm not subscribed to lkml so please CC
> 
> --
> Tarmo Tänav
> tarmo@itech.ee
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

