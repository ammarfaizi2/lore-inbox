Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSHLIwj>; Mon, 12 Aug 2002 04:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317622AbSHLIwj>; Mon, 12 Aug 2002 04:52:39 -0400
Received: from k100-159.bas1.dbn.dublin.eircom.net ([159.134.100.159]:46093
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S317616AbSHLIwi>; Mon, 12 Aug 2002 04:52:38 -0400
Message-ID: <3D57782E.5090009@corvil.com>
Date: Mon, 12 Aug 2002 09:56:14 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
References: <Pine.LNX.4.33.0208091459010.1283-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On 9 Aug 2002, Paul Larson wrote:
> 
>>On Fri, 2002-08-09 at 16:42, Linus Torvalds wrote:
>>
>>>Hmm.. Giving them a quick glance-over, the /proc issues look like they
>>>shouldn't be there in 2.5.x anyway, since the inode number really is
>>>largely just a random number in 2.5 and all the real information is
>>>squirelled away at path open time.
>>
> 
> It looks like the biggest impact on /proc would be that the /proc/<pid> 
> inodes wouldn't be 10%% unique any more, which in turn means that an 
> old-style /bin/pwd that actually walks the tree backwards and checks the 
> inode number would occasionally fail.
> 
> That in turn makes me suspect that we'd better off just biting the bullet 
> and makign the inode numbers almost completely static, and forcing that 
> particular failure mode early rather than hit it randomly due to unlucky 
> timing.
> 
> Doing a simple strace shows that all the systems I have regular access to
> use the "getcwd()" system call anyway, which gets this right on /proc (and
> other filesystems that do not guarantee unique inode numbers)

Anyone care to clarify which filesystems don't
have unique inode numbers. I always thought you
could uniquely identify any file using a device,inode
tuple? Fair enough proc is "special" but can/should
you not assume unique inodes within all other filesystems?

Also why can't you allocate a unique number in /proc?

thanks,
Pádraig.

