Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262261AbSIZL7O>; Thu, 26 Sep 2002 07:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbSIZL7O>; Thu, 26 Sep 2002 07:59:14 -0400
Received: from ns.suse.de ([213.95.15.193]:61195 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262261AbSIZL7N>;
	Thu, 26 Sep 2002 07:59:13 -0400
Date: Thu, 26 Sep 2002 14:04:30 +0200
From: Andi Kleen <ak@suse.de>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: "David S. Miller" <davem@redhat.com>, ak@suse.de, niv@us.ibm.com,
       linux-kernel@vger.kernel.org, jamal <hadi@cyberus.ca>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
Message-ID: <20020926140430.E14485@wotan.suse.de>
References: <3D924F9D.C2DCF56A@us.ibm.com.suse.lists.linux.kernel> <20020925.170336.77023245.davem@redhat.com.suse.lists.linux.kernel> <p73n0q5sib2.fsf@oldwotan.suse.de> <20020925.172931.115908839.davem@redhat.com> <3D92CCC5.5000206@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D92CCC5.5000206@drugphish.ch>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 11:00:53AM +0200, Roberto Nibali wrote:
> o we can't filter more than 13Mbit/s anymore after loading around 3000
>   rules into the kernel (problem is gone with nf-hipac for example).

For iptables/ipchain you need to write hierarchical/port range rules 
in this case and try to terminate searchs early.

But yes, we also found that the L2 cache is limiting here
(ip_conntrack has the same problem) 

> o we can't log all the messages we would like to because the user space
>   log daemon (syslog-ng in our case, but we've tried others too) doesn't
>   get enough CPU time anymore to read the buffer before it will be over-
>   written by the printk's again. This leads to an almost proportial to
>   N^2 log entry loss with increasing number of rules that do not match.
>   This is the worst thing that can happen to you working in the
>   security business: not having an appropriate log trace during a
>   possible incident.

At least  that is easily fixed. Just increase the LOG_BUF_LEN parameter
in kernel/printk.c

Alternatively don't use slow printk, but nfnetlink to report bad packets
and print from user space. That should scale much better.

-Andi
