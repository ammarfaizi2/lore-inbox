Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285379AbRLGCfQ>; Thu, 6 Dec 2001 21:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285380AbRLGCfG>; Thu, 6 Dec 2001 21:35:06 -0500
Received: from bitmover.com ([192.132.92.2]:63367 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285379AbRLGCew>;
	Thu, 6 Dec 2001 21:34:52 -0500
Date: Thu, 6 Dec 2001 18:34:51 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
        phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206183451.A4235@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
	phillips@bonn-fries.net, davidel@xmailserver.org,
	rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com,
	riel@conectiva.com.br, lars.spam@nocrew.org, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206143516.P27589@work.bitmover.com> <E16C7P1-0003Ou-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E16C7P1-0003Ou-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Dec 06, 2001 at 10:54:03PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 10:54:03PM +0000, Alan Cox wrote:
> > That's a red herring, there are not 64 routers in either picture, there
> > are 64 ethernet interfaces in both pictures.  So let me rephrase the
> > question: given 64 ethernets, 64 CPUs, on one machine, what's easier,
> > 1 multithreaded networking stack or 64 independent networking stacks?
> 
> I think you miss the point. If I have to program the system as 64
> independant stacks from the app level I'm going to go slowly mad

Well, that depends.  Suppose the application is a webserver.  Not your
simple static page web server, that one is on a shared nothing cluster
already.  It's a webserver that has a big honkin' database, with lots
of data being updated all time, the classic sort of thing that a big
SMP can handle but a cluster could not.  Fair enough?

Now imagine that the system is a collection of little OS images, each
with their own file system, etc.  Except /home/httpd is mounted on 
a globally shared file system.  Each os image has its own set of 
interfaces, one or more, and its own http server.  Which updates 
data in /home/httpd.

Can you see that this is a non-issue?  For this application, the ccCluster
model works great.  The data is all in a shared file system, nice and 
coherent, the apps don't actually know there is another OS banging on the 
data, it all just works.

Wait, I'll admit this means that the apps have to be thread safe, but that's
true for the traditional SMP as well.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
