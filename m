Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbVHXSo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbVHXSo2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbVHXSo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:44:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41869 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751393AbVHXSoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:44:05 -0400
Date: Wed, 24 Aug 2005 11:43:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulus@samba.org
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13-rc7
Message-Id: <20050824114351.4e9b49bb.pj@sgi.com>
In-Reply-To: <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
	<20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> ... breaks ppc64 since there we have node_to_cpumask() done as inlined
> function, not a macro.  So we get __first_cpu(&node_to_cpumask(...),...),
> with obvious consequences.

I sent a patch for this a few hours ago, thanks to Paul Mackerras's report:

  [PATCH 2.6.13-rc6] cpu_exclusive sched domains build fix

It just makes a local copy of the cpumask_t in a local variable on the stack.

I'm still a couple of hours from actually verifying that ppc64 builds with
this - due to unrelated confusions on my end.  Perhaps you or Mackerras will
report in first, to verify if this patch works as advertised.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
