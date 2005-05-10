Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVEJNeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVEJNeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 09:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261645AbVEJNeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 09:34:05 -0400
Received: from main.gmane.org ([80.91.229.2]:65485 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261646AbVEJNdy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 09:33:54 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joe Seigh" <jseigh_02@xemaps.com>
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Date: Tue, 10 May 2005 09:32:07 -0400
Message-ID: <opsqkajto6ehbc72@grunion>
References: <opsqivh7agehbc72@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think you need a release memory barrier if you store into a hazard
pointer that is non null to prevent prior accesses from occurring after
the store.  That's an extra memory barrier for hazard pointers that I
overlooked. One thing that could be done is wait an extra RCU grace
period after the hazard pointer scan to ensure prior accesses have
completed before freeing the resource.  That would lengthen the delay
to approximately 2 RCU grace periods.  Could be a problem if you have
a high write rate and are trying to keep that delay minimal.

There might be another way.  I'd have to investigate it a little more.


-- 
Joe Seigh

