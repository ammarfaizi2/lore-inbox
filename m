Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbUKDXUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbUKDXUW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUKDXUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:20:22 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:41680 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262489AbUKDXRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:17:40 -0500
Date: Fri, 5 Nov 2004 00:17:34 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Patrick McHardy <kaber@trash.net>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps
Message-ID: <20041104231734.GA30029@merlin.emma.line.org>
Mail-Followup-To: Patrick McHardy <kaber@trash.net>,
	netfilter-devel@lists.netfilter.org, linux-net@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20041104121522.GA16547@merlin.emma.line.org> <418A7B0B.7040803@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418A7B0B.7040803@trash.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Nov 2004, Patrick McHardy wrote:

> Matthias Andree wrote:
> 
> >You can use "bk receive" to patch with this mail.
> >
> >BK: Parent repository is bk://linux.bkbits.net/linux-2.5
> >
> >Patch description:
> >ChangeSet@1.2427, 2004-11-04 13:00:54+01:00, matthias.andree@gmx.de
> >   Fix ip_conntrack_amanda data corruption bug that breaks amanda dumps.
> > 
> >   Fix a bug where the ip_conntrack_amanda module replaces the first LF
> >   after "CONNECT " by a NUL byte. This causes the UDP checksum to become
> >   corrupt and strips off the OPTIONS argument from the received packet,
> >   breaking amanda's sendbackup component altogether.  Replace the LF
> >   character before releasing the buffer.
> >
> The data that is changed is only a copy, the actual packet is not touched.

Why then does the application not see the packets as long as
ip_conntrack_amanda is loaded and starts seeing them again as soon as
"rmmod ip_conntrack_amanda" has completed?

And I'm not even arguing with tcpdump which may get the altered copy of the packet.

I am unaware of two things:
1. detailed packet flow and SKBs
2. internal ip_conntrack API.

I am however seeing that ip_conntrack_amanda
1. jams the application's protocol
2. modifies the packet.

So is there any evidence to support the "only a copy" theory?

-- 
Matthias Andree
