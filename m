Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262519AbREUW1I>; Mon, 21 May 2001 18:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262518AbREUW06>; Mon, 21 May 2001 18:26:58 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:43786 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262513AbREUW0q>; Mon, 21 May 2001 18:26:46 -0400
Date: Tue, 22 May 2001 00:26:47 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Jan Hudec <bulb@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: question: permission checking for network filesystem
In-Reply-To: <20010521153246.A9454@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.3.96.1010521233913.27071A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Agree, but it will improve behavior. Or speed, rather. Otherwise open would
> take 3(!) roundtrips (instead of two - now lookup can't be get rid of) -
> lookup, permission and open. The protocol can do all three in one request.
> The problem is I can't tell the 3 calls from VFS belong together.

You can write lookup so that it always succeeds and returns dummy inode
without sending anything and do all the work in open & inode operations.

> > > Could anyone see a solution other than adding a flags to open mode (say
> > > O_EXEC and O_EXEC_LIB), that would be added to the dentry_open in open_exec
> > > and sys_uselib? I don't like the idea of pathing vfs for this.
> > 
> > Send always 'open for read' and ignore 'open for execute'.
> 
> Won't work for many reasons. Correct error code is one (could be removed by
> pre-checking permission),

> exclusivity of write versus execute is the other
> (can't be workaround).

MAP_DENYWRITE is used for this. If somebody is mapping file with
MAP_DENYWRITE, lock it on server. Write locking does not depend on exec,
and it is bad to expect that it may be used only in exec. 

Mikulas


