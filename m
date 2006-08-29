Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWH2BLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWH2BLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 21:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWH2BK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 21:10:59 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:13401 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750783AbWH2BK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 21:10:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=joGC0vYkw/01zYjnJQ3e1CQRaeal/cEH+KDHcnBHxuJiEVA9jkzaMr0K/ZztCv0CPT3DTvpGv7OCCR/Fg0yhbnuRUA5xum6dI968a2AkdNKRsLboP0htUj8n94qKeEhDA6EJeinREaUBcW0lUDSxP/bFy1lqzPgDXeLTJqX+v54=  ;
Message-ID: <44F39403.4060909@yahoo.com.au>
Date: Tue, 29 Aug 2006 11:10:27 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFT] sched.h removal from module.h
References: <20060827153234.GA31505@martell.zuzino.mipt.ru>
In-Reply-To: <20060827153234.GA31505@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> I don't have compile-kernel-in-a-minute box, so
> 
> Please, test on your usual configs and send me _new_ warnings and errors
> that appeared.
> 
> Patch seems to pass [alpha, i386, x86_64] x [allmodconfig-SMP, -UP] without
> regressions.
> 
> [PATCH] sched.h removal from module.h
> 
> This is done by duplicating prototype of wake_up_process() which seems
> to be the only thing module.h wants.

This is really ugly, IMO. It makes the code less maintainable, so I don't
think there is any point in doing it. In this case, we really do want to
use scheduler functions, so the thing you do in that case is to include
sched.h, not declare them yourself :(

If you are particularly concerned about this, just move all those refcount
inlines into kernel/module.c (they're too big anyway)... then you can drop
the sched.h include from module.h for free ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
