Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278625AbRKHVh3>; Thu, 8 Nov 2001 16:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278604AbRKHVhT>; Thu, 8 Nov 2001 16:37:19 -0500
Received: from a59178.upc-a.chello.nl ([62.163.59.178]:24334 "EHLO
	www.unternet.org") by vger.kernel.org with ESMTP id <S278579AbRKHVhI>;
	Thu, 8 Nov 2001 16:37:08 -0500
Date: Thu, 8 Nov 2001 22:35:30 +0100
From: Frank de Lange <lkml-frank@unternet.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hang with 2.4.14 & vmware 3.0.x, anyone else seen this?
Message-ID: <20011108223530.C11523@unternet.org>
In-Reply-To: <89FED3F0389@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <89FED3F0389@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Thu, Nov 08, 2001 at 10:24:05PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 10:24:05PM +0000, Petr Vandrovec wrote:
> Journaling will not do anything good in such case, as damaged kernel
> could write damaged data to your harddisk. You should run full fsck
> after every such lockup even if you are using journaled filesystem -
> - unless you are 100% sure that kernel really stoped doing anything
> instead of that it started doing strange things.

Hmmm, with ext3 that would not help you very much I think, given that the
journal is replayed before the fsck is performed (fsck can replay a journal
file). So if there's garbage in the journal, it might make its way into the
filesystem. Or it might confuse fsck...

I use reiserfs on another disk in the same box, which does not suffer from the
long fsck times, but does put a quite heavy load on the CPU during intense file
operations. Simple tests with ext3 seem to indicate that it suffers less from
this problem.

> Probably it is time for me to try Linus's kernel, but I have so perfect 
> exprience with Alan ones that I'm a bit reluctant to do that.

Yeah, same here. I decided to try a Linus kernel 'cause of some unexplained and
unwarranted slowdowns - especially in interactive applications.

With mixed results, the slowdowns seem to be gone but other problems appear
(like the vmware hangs). I'm back to -ac for the moment (running 2.4.13-ac5,
waiting for others to bend or break the IDE patches :-)

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ "Omnis enim res, quae dando non deficit, dum habetur
    et non datur, nondum habetur, quomodo habenda est."  ]
