Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWF2O3x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWF2O3x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 10:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWF2O3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 10:29:52 -0400
Received: from www346.sakura.ne.jp ([202.181.99.66]:29446 "EHLO
	www346.sakura.ne.jp") by vger.kernel.org with ESMTP
	id S1750756AbWF2O3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 10:29:52 -0400
Message-ID: <44A3E354.6050001@ak.jp.nec.com>
Date: Thu, 29 Jun 2006 23:27:32 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Adrian Bunk <bunk@stusta.de>, jffs-dev@axis.com,
       linux-kernel@vger.kernel.org
Subject: Re: unused fs/jffs2/acl.c:jffs2_clear_acl()
References: <20060629130133.GC29056@stusta.de> <1151586970.16413.16.camel@pmac.infradead.org>
In-Reply-To: <1151586970.16413.16.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Thu, 2006-06-29 at 15:01 +0200, Adrian Bunk wrote:
> 
>>it might not have been intended that jffs2_clear_acl() in Linus' tree
>>is unused?
> 
> 
> I suspect you're right -- thanks for pointing it out.
> 
> Kaigai-san?

I'm sorry, it's a serious BUG.
When an inode is cleared, jffs2_clear_acl() should be called
to release on-memory ACL. Because the current implementation
didn't care about this cleaning-up, we have memory-leaking.

Please wait a patch for a while.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>
