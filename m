Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262700AbTCRXmQ>; Tue, 18 Mar 2003 18:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbTCRXmQ>; Tue, 18 Mar 2003 18:42:16 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:28554 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S262700AbTCRXmN>;
	Tue, 18 Mar 2003 18:42:13 -0500
Subject: Re: 2.4.20-ac2 Memory Leak?
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Greg Stark <gsstark@mit.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <87znns9r1k.fsf@stark.dyndns.tv>
References: <8765qgb6z0.fsf@stark.dyndns.tv>
	 <1048030102.1521.77.camel@tux.rsn.bth.se>  <87znns9r1k.fsf@stark.dyndns.tv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048031585.748.83.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Mar 2003 00:53:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-19 at 00:46, Greg Stark wrote:
> Martin Josefsson <gandalf@wlug.westbo.se> writes:
> 
> > This can be the source of your problems, connections can get very long
> > timeouts and stay in ip_conntrack.
> 
> Is there a way to list the connections and confirm this is the problem?
> It seems it would require an awful lot of connections to consume megabytes of
> memory.

cat /proc/net/ip_conntrack

The third field is the timeout in seconds.
The fourth field is the state of the connection, if it's TIME_WAIT with
a large timeout then it's the list handling bug. (iirc it was TIME_WAIT
that showed the problem...)

> Also, I've looked high and low and can't find this anywhere, how do i tune the
> timeouts connections get? I have certain protocols that potentially receive
> very little traffic and I want to make sure they don't time out.

The default tcp timeout is 5 days for esatblished connections.

There's a patch in patch-o-matic that enables you to tune the timeouts
without having to edit the source. Instructions on how to get
patch-o-matic are availiable on http://www.netfilter.org

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
