Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264291AbTKZUCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbTKZUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:02:05 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:18305 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264291AbTKZUCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:02:02 -0500
Date: Wed, 26 Nov 2003 20:01:53 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-ID: <20031126200153.GG14383@mail.shareable.org>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel> <20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel> <p73fzgbzca6.fsf@verdi.suse.de> <20031126113040.3b774360.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031126113040.3b774360.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> > - Doing gettimeofday on each incoming packet is just dumb, especially
> > when you have gettimeofday backed with a slow southbridge timer.
> > This shows quite badly on many profile logs.
> > I still think right solution for that would be to only take time stamps
> > when there is any user for it (= no timestamps in 99% of all systems) 
> 
> Andi, I know this is a problem, but for the millionth time your idea
> does not work because we don't know if the user asked for the timestamp
> until we are deep within the recvmsg() processing, which is long after
> the packet has arrived.

Do the timestamps need to be precise and accurately reflect the
arrival time in the irq handler?  Or, for TCP timestamps, would it be
good enough to use the time when the protocol handlers are run, and
only read the hardware clock once for a bunch of received packets?  Or
even use jiffies?

Apart from TCP, precise timestamps are only used for packet capture,
and it's easy to keep track globally of whether anyone has packet
sockets open.

-- Jamie
