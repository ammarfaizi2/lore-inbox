Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbWD0GYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWD0GYi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbWD0GYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:24:38 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:60014 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964961AbWD0GYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:24:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tTvk9Y55E9tzBHpUqDqy5VDCwuV2jlbsTgQsHDWFziQc2EPDdlzLQkRvk9/XIb5uKBUQASV9Jm3wqOl4377QBNdyAmOzIoNynjrU72+DTyrrsfoH+YIxCOOp4euRZ8biuDh2hYOae/N6xBmxhyOa73+itsqgUHFwL/+E9waEn+U=  ;
Message-ID: <445061DC.5030008@yahoo.com.au>
Date: Thu, 27 Apr 2006 16:17:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjan@infradead.org>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de> <1146046118.7016.5.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI> <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI>
In-Reply-To: <Pine.LNX.4.58.0604270853510.20454@sbz-30.cs.Helsinki.FI>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg wrote:
> On Wed, 26 Apr 2006, Jörn Engel wrote:
> 
>>Still, if you could respin this with gcc 4.1 and post the numbers,
>>Pekka, that would be quite interesting.
> 
> 
> Inlining kfree the way I did doesn't pay off in 4.1 either.

Not to dispute your conclusions or method, but I think doing a
defconfig or your personal config might be more representative
of % size increase of text that will actually be executed. And
that is the expensive type of text.

eg. core code may contain many more instances of checks that
cannot be optimised away, meaning it may be a more significant
cache footprint increase than the 0.05% increase in your test.

Of course, it is equally possible that the instances in core
code do not represent often-executed code, so it is a bit of a
fudge either way.

>    text    data     bss     dec     hex filename
> 24910301 6946478 2092332 33949111 20605b7 vmlinux-gcc-3.4.5
> 24934157 6946530 2092332 33973019 206631b vmlinux-inline-kfree-gcc-3.4.5
> 24171004 6484710 2090188 32745902 1f3a9ae vmlinux-gcc-4.1.0
> 24185925 6484722 2090188 32760835 1f3e403 vmlinux-inline-kfree-gcc-4.1.0

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
