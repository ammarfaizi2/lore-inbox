Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVCXIi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVCXIi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 03:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262724AbVCXIi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 03:38:28 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:13783 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S262606AbVCXIhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 03:37:54 -0500
Message-ID: <42427C51.2050705@bull.net>
Date: Thu, 24 Mar 2005 09:37:37 +0100
From: Jacky Malcles <Jacky.Malcles@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Wong <markw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 journalling BUG on full filesystem
References: <20050323202130.GA30844@osdl.org>
In-Reply-To: <20050323202130.GA30844@osdl.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/03/2005 09:47:19,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 24/03/2005 09:47:21,
	Serialize complete at 24/03/2005 09:47:21
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Wong wrote:
> I originally reported this to the linuxppc64-dev list, since I made it
> happen on a POWER system.  I'm told this might be more generic...
> 
> Anyone run into something like this?
> 
> Mark

If i'm not wrong I think I have had something around the same place "ext3 
journalling":

1)
The kjournald daemon hits a bugcheck:
    Assertion failure in journal_commit_transaction() at fs/jbd/commit.c:760: 
"jh->b_next_transaction == ((void *)0)"
kernel BUG at fs/jbd/commit.c:760! (fs/jbd/transaction.c, 954): 
journal_dirty_data: jh: e0000023ee0f9a58, tid:205049

2)

reading your email I decide to start a test and get this:
(fs/jbd/transaction.c, 954): journal_dirty_data: jh: e0000023ee0f9a58, tid:205049
kernel BUG at kernel/timer.c:416!
mkdir09[30886]: bugcheck! 0 [2]
/* Linux version 2.6.10 with CONFIG_JBD_DEBUG enable */


hope that it can help,

Jacky


> 
> ----- Forwarded message from Mark Wong <markw@osdl.org> -----
> 
> Date: Wed, 23 Mar 2005 08:05:30 -0800
> To: linuxppc64-dev@ozlabs.org
> From: Mark Wong <markw@osdl.org>
> Subject: ext3 journalling BUG on full filesystem
> 
> Hi,
> 
> I'm running 2.6.11 and I'm suspecting that a full ext3 filesystem is
> causing the following problem when performing some journaling
> operation.  Let me know if I can provide more details:
> 
> cpu 0x6: Vector: 700 (Program Check) at [c0000002e4f3f6d0]
>     pc: c0000000000a5fbc: .submit_bh+0x64/0x1fc
>     lr: c0000000000a62b4: .ll_rw_block+0x160/0x164
>     sp: c0000002e4f3f950
>    msr: 8000000000029032
>   current = 0xc00000038ff5c7c0
>   paca    = 0xc000000000612000
>     pid   = 1376, comm = kjournald
> kernel BUG in submit_bh at fs/buffer.c:2706!
> enter ? for help
> 6:mon> t
> [c0000002e4f3f9f0] c0000000000a62b4 .ll_rw_block+0x160/0x164
> [c0000002e4f3fab0] c000000000151ac4 .journal_commit_transaction+0xd88/0x16d4
> [c0000002e4f3fe30] c000000000155590 .kjournald+0x114/0x308
> [c0000002e4f3ff90] c000000000013ec0 .kernel_thread+0x4c/0x6c
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
  Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
  Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
  Tel : 04.76.29.73.14
