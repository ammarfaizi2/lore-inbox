Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262895AbTDAWjV>; Tue, 1 Apr 2003 17:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262906AbTDAWjV>; Tue, 1 Apr 2003 17:39:21 -0500
Received: from asie314yy33z9.bc.hsia.telus.net ([216.232.196.3]:15490 "EHLO
	saurus.asaurus.invalid") by vger.kernel.org with ESMTP
	id <S262895AbTDAWjU>; Tue, 1 Apr 2003 17:39:20 -0500
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stateless dropping of packets
References: <87he9ilz05.fsf@deneb.enyo.de>
From: Kevin Buhr <buhr@telus.net>
In-Reply-To: <87he9ilz05.fsf@deneb.enyo.de>
Date: 01 Apr 2003 14:50:39 -0800
Message-ID: <87d6k5ltmo.fsf@saurus.asaurus.invalid>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Weimer <fw@deneb.enyo.de> writes:
>
> Is it possible to drop packets, preferably using 2.4 iptables, before
> the packet triggers updates of some caches (e.g. the route cache)?

If you DROP the packet in a PREROUTING chain, that should work.  Since
the "filter" table doesn't have a PREROUTING chain, you need to use a
table that does, like the "mangle" table.  For example:

        iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j DROP

should drop everything with a source in 10.0.0.0/8 without touching
the routing cache.

-- 
Kevin <buhr@telus.net>
