Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUEDGwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUEDGwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 02:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbUEDGwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 02:52:11 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21412 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264251AbUEDGwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 02:52:08 -0400
Date: Tue, 4 May 2004 12:20:16 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-ID: <20040504065016.GA6911@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040430113751.GA18296@in.ibm.com> <20040430192712.2e085895.akpm@osdl.org> <20040503122316.GA7143@in.ibm.com> <20040503122520.1e02e861.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503122520.1e02e861.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 12:25:20PM -0700, Andrew Morton wrote:
> Well that create_workqueue_thread() will basically never fail - it's not a
> path we need to be optimising.

Even if thread creation normally never fails, we still check for its
return code and have some error recovery code! In that case, 
I dont understand the point behind continuing the loop once thread
destruction fails for some CPU. Lets say on a 128 CPU machine, if
thread creation fails for the 1st CPU (because of say ENOMEM?), then
why continue trying to create threads for the rest of 126 CPUs and
_then_ destroy? Why not just break at the first occurence of failure 
and cleanup then and there?


 


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
