Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264360AbTKZW65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264364AbTKZW65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:58:57 -0500
Received: from ns.suse.de ([195.135.220.2]:5334 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264360AbTKZW6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:58:54 -0500
Date: Wed, 26 Nov 2003 23:58:09 +0100
From: Andi Kleen <ak@suse.de>
To: arjanv@redhat.com
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031126235809.131fde15.ak@suse.de>
In-Reply-To: <1069882450.5219.1.camel@laptop.fenrus.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<1069882450.5219.1.camel@laptop.fenrus.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 22:34:10 +0100
Arjan van de Ven <arjanv@redhat.com> wrote:

> On Wed, 2003-11-26 at 20:30, David S. Miller wrote:
> 
> > > - Doing gettimeofday on each incoming packet is just dumb, especially
> > > when you have gettimeofday backed with a slow southbridge timer.
> > > This shows quite badly on many profile logs.
> > > I still think right solution for that would be to only take time stamps
> > > when there is any user for it (= no timestamps in 99% of all systems) 
> > 
> > Andi, I know this is a problem, but for the millionth time your idea
> > does not work because we don't know if the user asked for the timestamp
> > until we are deep within the recvmsg() processing, which is long after
> > the packet has arrived.
> 
> question: do we need a timestamp for every packet or can we do one
> timestamp per irq-context entry ? (eg one timestamp at irq entry time we
> do anyway and keep that for all packets processed in the softirq)

If people want the timestamp they usually want it to be accurate
(e.g. for tcpdump etc.). of course there is already a lot of jitter
in this information because it is done relatively late in the device
driver (long after the NIC has received the packet)

Just most people never care about this at all.... 

-Andi
