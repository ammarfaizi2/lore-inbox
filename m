Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVAJXRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVAJXRk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVAJXMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:12:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60083 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262747AbVAJXH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 18:07:27 -0500
Date: Mon, 10 Jan 2005 18:05:14 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Edjard Souza Mota <edjard@gmail.com>
Cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: User space out of memory approach
Message-ID: <20050110200514.GA18796@logos.cnet>
References: <3f250c71050110134337c08ef0@mail.gmail.com> <20050110192012.GA18531@logos.cnet> <4d6522b9050110144017d0c075@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d6522b9050110144017d0c075@mail.gmail.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 12:40:24AM +0200, Edjard Souza Mota wrote:
> Hi,
> 
> I guess it the idea was not fully and well explained. It is not the OOM Killer
> itself that was moved to user space but rather its ranking algorithm.
> Ranking is not an specific functionality of kernel space. Kernel only need
> to know which process whould be killed.
> 
> In that sense the approach is different and might be worth testing, mainly for
> cases where we want to allow better policies of ranking. For example, an
> embedded device with few resources and important different running applications:
> whic one is the best? To my understanding the current ranking policy
> does not necessarily chooses the best one to be killed.

Sorry, I misunderstood. Should have read the code before shouting.

The feature is interesting - several similar patches have been around with similar
functionality (people who need usually write their own, I've seen a few), but none 
has ever been merged, even though it is an important requirement for many users.

This is simple, an ordered list of candidate PIDs. IMO something similar to this 
should be merged. Andrew ?

Few comments about the code:

 retry:
-       p = select_bad_process();
+       printk(KERN_DEBUG "A good walker leaves no tracks.\n");
+       p = select_process();

You want to fallback to select_bad_process() if no candidate has been selected at
select_process().

You also want to move "oom" to /proc/sys/vm/.

