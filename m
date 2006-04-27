Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWD0GrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWD0GrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964968AbWD0GrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:47:10 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:62866 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964967AbWD0GrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:47:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=clCotitZpNz/tJghqBqadcxz51+BxKe+j4NTU3lx4T5sbBmGUaWesiP8ZO4Vkzf8xSS7IZO/BRB8QmiycyHKnxMuii/Dgk8EOt/RJm1qqwMmQN6k5C2MO3D9bxaQUCRi7kMmJX/v/IsY7xbsqFmhaLxACOOsmNTYHaL52mkhz4c=  ;
Message-ID: <445066B0.1010104@yahoo.com.au>
Date: Thu, 27 Apr 2006 16:37:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: Kyle Moffett <mrmacman_g4@mac.com>,
       Bart Hartgers <bart@etpmod.phys.tue.nl>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjan@infradead.org>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de> <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI> <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de> <444F5B74.60809@etpmod.phys.tue.nl> <444F6FDD.7040000@etpmod.phys.tue.nl> <CB27C57D-BABF-4900-9299-F342861CF1E0@mac.com> <Pine.LNX.4.58.0604270928170.20454@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0604270928170.20454@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Wed, 26 Apr 2006, Kyle Moffett wrote:
> 
>>Here's code that I've found works as well as can be expected under both GCC 3
>>and GCC 4.  If xp is a known-NULL constant the whole function will be
>>optimized out completely.  If xp is known-not-NULL, then it will optimize to a
>>kfree function without the null check.  Otherwise it optimizes to call the
>>out-of-line version.
> 
> 
> Wouldn't it be better to simply remove calls to kfree() with known 
> NULL constant?

Yes, but this will optimise away the check for known non-NULL.

At the cost of icache footprint.

I think unmeasurable micro-optimisations that go against historic
CPU trends (eg. size for speed) aren't worth wasting too much
sleep over. If it is a 0.0001% speedup today, it'll be a 0.0001%
slowdown tomorrow :)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
