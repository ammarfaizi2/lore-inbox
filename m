Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161090AbVKQDBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161090AbVKQDBs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 22:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbVKQDBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 22:01:48 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:2196 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161090AbVKQDBr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 22:01:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YX9zpcfddd4eRWmRQdyZVdne0Hp/mr+ZlqqexEYKPmLOMGiU/LFzikvk+xMmWPGEHWAU95teYAtSCMfFq+U7aiDQpbod83UpouQkEP9hW4Jm8A5bNUrfsWjKV5fYVQ2DIwlkdBebFVt78uZNLwctIDRM98GnKa/KaJyGrHu1hR4=
Message-ID: <35fb2e590511161901t7a615992s123a22cd8403511d@mail.gmail.com>
Date: Thu, 17 Nov 2005 03:01:46 +0000
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: ipt_ROUTE loopback
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I'm trying to find an easy way to have a Linux box completely ignore
the local routing table and have traffic destined for one interface go
out of a loopback cable and back into the other rather than traversing
the local routing within the host, viz:

eth0
x.x.x.x
   |
   | <--- loopback cable
   |
eth1
y.y.y.y

This is completely against normal practice, but useful for test. I've
so far tried playing around with iproute2 and have this evening built
up ipt_ROUTE, which seems more promising. I can get traffic forced out
of the "correct" interface and bypass the local routing table, but it
always has the destination MAC of the first interface when it reaches
the second.

So, I can bodge the destination MAC (I'm still deciding how to do that
- maybe I'll take apart ipt_ROUTE and have it do MAC rewriting too)
but I'm curious as to whether there's a "right" way to do this that
I've so far missed? I've considered using the briding code in some
weird kind of transparent-yet-not-really bridge setup, but I don't
really want to do that.

Any suggestions? This seems like something others must have also
wanted to do. I'm happy to break things in doing it, but I'm hopeful
for a "you missed this page...".

Jon.
