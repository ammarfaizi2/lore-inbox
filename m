Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVGPFQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVGPFQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 01:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbVGPFQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 01:16:26 -0400
Received: from tomts20.bellnexxia.net ([209.226.175.74]:19147 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S262227AbVGPFQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 01:16:24 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: Stephen Pollei <stephen.pollei@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Lee Revell <rlrevell@joe-job.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
In-Reply-To: <feed8cdd050715125846f8c42f@mail.gmail.com>
References: <42D3E852.5060704@mvista.com>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <9a874849050714170465c979c3@mail.gmail.com>
	 <1121386505.4535.98.camel@mindpipe>
	 <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
	 <1121392856.7934.11.camel@orbiter>
	 <feed8cdd050715125846f8c42f@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 01:16:30 -0400
Message-Id: <1121490991.7057.21.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 12:58 -0700, Stephen Pollei wrote:
> But If I understand Linus's points he wants jiffies to remain a memory
> fetch, and make sure it doesn't turn into a singing dancing christmas
> tree.

It seems it relatively easy to support dynamic tick, the ARM
architecture has it. But with the numerous users of jiffies through the
code, it seems to me that it's hard to ensure that everyone of them will
continue to work correctly if the jiffies_increment is changed during
runtime.

As Linus noted, the current tick code is flexible and powerful, but it
can be hard to get it right in all case. 

WinCE developers have similar problems/concerns:

http://blogs.msdn.com/ce_base/archive/2005/06/08/426762.aspx

With the previous cleanup like time_after()/time_before(), msleep() and
friends, unit conversion helpers, etc. it's a step in the right
direction.

I just wanted to point out that while it's good to preserve the current
efficient tick implementation, it may be worthwhile to add a relative
timeout API like Alan Cox proposed a year ago to better hide the
implementation details.


- Eric St-Laurent


