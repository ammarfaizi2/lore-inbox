Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262846AbTCSA1w>; Tue, 18 Mar 2003 19:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262849AbTCSA1w>; Tue, 18 Mar 2003 19:27:52 -0500
Received: from sabre.velocet.net ([216.138.209.205]:14601 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S262846AbTCSA1u>;
	Tue, 18 Mar 2003 19:27:50 -0500
To: Martin Josefsson <gandalf@wlug.westbo.se>
Cc: Greg Stark <gsstark@mit.edu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-ac2 Memory Leak?
References: <8765qgb6z0.fsf@stark.dyndns.tv>
	<1048030102.1521.77.camel@tux.rsn.bth.se>
	<87znns9r1k.fsf@stark.dyndns.tv>
	<1048031585.748.83.camel@tux.rsn.bth.se>
In-Reply-To: <1048031585.748.83.camel@tux.rsn.bth.se>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 18 Mar 2003 19:05:11 -0500
Message-ID: <87u1e09q6g.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson <gandalf@wlug.westbo.se> writes:

> On Wed, 2003-03-19 at 00:46, Greg Stark wrote:
> > Martin Josefsson <gandalf@wlug.westbo.se> writes:
> > 
> > > This can be the source of your problems, connections can get very long
> > > timeouts and stay in ip_conntrack.
> > 
> > Is there a way to list the connections and confirm this is the problem?
> > It seems it would require an awful lot of connections to consume megabytes of
> > memory.
> 
> cat /proc/net/ip_conntrack
> 
> The third field is the timeout in seconds.
> The fourth field is the state of the connection, if it's TIME_WAIT with
> a large timeout then it's the list handling bug. (iirc it was TIME_WAIT
> that showed the problem...)

Nope, a total of 16 entries in ip_conntrack, one of which is in TIME_WAIT with
a timeout of 2m.



> The default tcp timeout is 5 days for esatblished connections.
> 
> There's a patch in patch-o-matic that enables you to tune the timeouts
> without having to edit the source. Instructions on how to get
> patch-o-matic are availiable on http://www.netfilter.org

Thanks.

-- 
greg

