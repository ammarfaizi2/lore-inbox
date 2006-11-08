Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423863AbWKHW7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423863AbWKHW7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 17:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423864AbWKHW73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 17:59:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423863AbWKHW72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 17:59:28 -0500
Date: Wed, 8 Nov 2006 14:58:15 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Olaf Kirch <okir@suse.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       davem@sunset.davemloft.net, kuznet@ms2.inr.ac.ru,
       netdev@vger.kernel.org
Subject: Re: 2.6.19-rc1: Volanomark slowdown
Message-ID: <20061108145815.25bb4c19@freekitty>
In-Reply-To: <20061108221028.GA16889@suse.de>
References: <1162924354.10806.172.camel@localhost.localdomain>
	<1163001318.3138.346.camel@laptopd505.fenrus.org>
	<20061108162955.GA4364@suse.de>
	<1163011132.10806.189.camel@localhost.localdomain>
	<20061108221028.GA16889@suse.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2006 23:10:28 +0100
Olaf Kirch <okir@suse.de> wrote:

> On Wed, Nov 08, 2006 at 10:38:52AM -0800, Tim Chen wrote:
> > The patch in question affects purely TCP and not the scheduler.  I don't
> 
> I know.
> 
> > think the scheduler has anything to do with the slowdown seen after
> > the patch is applied.
> 
> In fixing performance issues, the most obvious explanation isn't always
> the right one. It's quite possible you're right, sure.
> 
> What I'm saying though is that it doesn't rhyme with what I've seen of
> Volanomark - we ran 2.6.16 on a 4p Intel box for instance and it didn't
> come close to saturating a Gigabit pipe before it maxed out on CPU load.
> 
> > The total number of messages being exchanged around the chatrooms in 
> > Volanomark remain unchanged.  But ACKS increase by 3.5 times and
> > segments received increase by 38% from netstat.  
> 
> > So I think it is reasonable to conclude that the increase in TCP traffic
> > reduce the bandwidth and throughput in Volanomark.
> 
> You could count the number of outbound packets dropped on the server.
> 
> Olaf

Also under benchmark stress, the load can get so high that timers go
off that normally don't. For example, I have seen delayed ack timer
cause extra ack's when at lower loads the response happened quick enough
that the ACK was piggybacked.


-- 
Stephen Hemminger <shemminger@osdl.org>
