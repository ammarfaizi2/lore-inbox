Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751616AbVLABlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751616AbVLABlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 20:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbVLABlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 20:41:55 -0500
Received: from main.gmane.org ([80.91.229.2]:1166 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751614AbVLABly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 20:41:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Yet another lock-free reader/writer lock
Date: Wed, 30 Nov 2005 20:40:29 -0500
Message-ID: <dmlk6k$6tt$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have another lock-free algorithm on my FOSS project site
http://atomic-ptr-plus.sourceforge.net/
It's the rcpc (reference counted proxy collector) package.
It uses double wide compare and swap, load reserved/store conditional,
or single wide compare and swap where the former aren't available,
e.g. 64 bit sparc.  Which pretty much makes it portable to practically
anything in any environment, kernel or user space.

One caveat.  It's probably not safe to use the single wide compare and
swap for 32 bit words if there's a possibility that a read lock will be
held long enough for a 30 bit counter to wrap.  But it's probably safe if
the reader does not preempt.

It's ported to 32 bit x86 (linux) and 32 bit ppc (OSX) which is the
only development platforms I have access to.  I may port it back to
win32 where I did the initial prototype (it's a vc++ vs. gcc port).

--
Joe Seigh

