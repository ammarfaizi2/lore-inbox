Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWEQJss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWEQJss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWEQJss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 05:48:48 -0400
Received: from mail.gmx.de ([213.165.64.20]:22450 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750758AbWEQJss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 05:48:48 -0400
X-Authenticated: #14349625
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: tim.c.chen@linux.intel.com, "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200605171823.24476.kernel@kolivas.org>
References: <4t16i2$12rqnu@orsmga001.jf.intel.com>
	 <200605160945.13157.kernel@kolivas.org>
	 <1147822331.4859.37.camel@localhost.localdomain>
	 <200605171823.24476.kernel@kolivas.org>
Content-Type: text/plain
Date: Wed, 17 May 2006 11:49:23 +0200
Message-Id: <1147859363.8813.41.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 18:23 +1000, Con Kolivas wrote:

> There is a ceiling to the priority beyond which tasks that only ever sleep
> for very long periods cannot surpass.

(Hmm.  The intent is more clear, ie reserve the top for low latency
tasks,... but that sounds a bit like xmms protection.) 

The main problem I see with this ceiling, solely from the interactivity
viewpoint, is that interactive tasks which have started burning cpu
and/or freshly forked interactive tasks land in the same spot.  Thud.c
demonstrates this problem quite well.  You don't want a few copies of
thud in the same queue with your interactive task, much less above it if
it's used enough cpu to drop a notch or two.  Much pain ensues.

	-Mike

