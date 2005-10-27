Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbVJ0BUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbVJ0BUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 21:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbVJ0BUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 21:20:19 -0400
Received: from main.gmane.org ([80.91.229.2]:63949 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964952AbVJ0BUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 21:20:17 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: Notifier chains are unsafe
Date: Wed, 26 Oct 2005 21:17:31 -0400
Message-ID: <djp9r4$8dj$1@sea.gmane.org>
References: <Pine.LNX.4.44L0.0510261636580.7186-100000@iolanthe.rowland.org>	 <200510262344.37982.ak@suse.de> <1130368820.3586.213.camel@linuxchandra>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <1130368820.3586.213.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandra Seetharaman wrote:
> Andy, comment above rcu_read_lock says, "It is illegal to block while in
> an RCU read-side critical section."
> 
> As i mentioned in the other email we are discussing about "task
> notifier" in lse-tech. We thought of using RCU, but one of the
> requirements was that the registered function should be able to block,
> so we are looking for alternatives.
> 

What are the requirements that preclude a conventional rwlock?  If you
don't have any, then you should go with that.

The other solutions I've mentioned before.

Copy on read.

Various lock-free schemes:
SMR hazard pointers
RCU+SMR (probably overkill since you don't need the read side performance)
reference counting
proxy reference counting

The last would probably be the easiest to implement expecially if you used
a spinlock to safely increment the reference count without the more complicated
atomic thread-safety.  It's also more self contained.

User land implementations of most of the above can be found at
http://sourceforge.net/projects/atomic-ptr-plus/

The proxy refcounting stuff is in the atomic-ptr-plus package.  It's
in c++ but you should be able to figure it out.

RCU+SMR is in the fastsmr package.



--
Joe Seigh

