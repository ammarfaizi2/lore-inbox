Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUCWOcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 09:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUCWOcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 09:32:46 -0500
Received: from mail.ondacorp.com.br ([200.195.196.14]:17631 "EHLO
	mail.ondacorp.com.br") by vger.kernel.org with ESMTP
	id S262580AbUCWOco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 09:32:44 -0500
Message-ID: <40604A88.3010207@arenanetwork.com.br>
Date: Tue, 23 Mar 2004 11:32:40 -0300
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Organization: ArenaNetwork Lan House & Cyber
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: kuznet@ms2.inr.ac.ru, davem@redhat.com
Subject: Re: EAGAIN and Linux 2.6 IPsec patch
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this fixed already? Please cc me too.

On Tue, 30 Sep 2003 15:41:51 +0400
Alexey <kuznet@ms2.inr.ac.ru> wrote:

Hello!

 > The following (untested) patch tries to do that.

This does not work and has no chances to do. We have already discussed
this, actually. You can get reasoning from saved mailbox, I think.
To resume, proto->connect() method must not ever block.

Alexey

PS. I think I am back to life, so this time I am honest telling
this bug is going to be fixed properly.
-
FreeS/WAN design list.
https://mj2.freeswan.org/cgi-bin/mj_wwwusr/domain=mj2.freeswan.org to 
unsubscribe



On Tue, 30 Sep 2003 21:34:24 +1000
Herbert Xu <herbert@gondor.apana.org.au> wrote:

 > OK, this looks like a bug that is independent of the packet queueing 
issue.
 >
 > TCP/UDP connects do a route/IPSEC lookup to determine information
 > about the connection.  The IPSEC lookup can fail with EAGAIN if the
 > policy is in place without any SAs.
 >
 > Since connect already has an O_NONBLOCK bit we should make it try
 > harder if it is clear.
 >
 > The following (untested) patch tries to do that.

Please don't do this, any attempt to fix the EAGAIN behavior
with hacks like this are riddled with problems.

Several patches nearly identical to your's have been submitted
in the past.

Alexey is supposed to work on support for unresolved routes, which
is the proper way to fix this problem.
-
FreeS/WAN design list.
https://mj2.freeswan.org/cgi-bin/mj_wwwusr/domain=mj2.freeswan.org to 
unsubscribe

-- 
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br
