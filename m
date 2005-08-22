Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVHVT4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVHVT4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 15:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbVHVT4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 15:56:09 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:18906 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750768AbVHVT4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 15:56:08 -0400
Message-ID: <430A1DB5.9070000@symas.com>
Date: Mon, 22 Aug 2005 11:47:17 -0700
From: Howard Chu <hyc@symas.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b4) Gecko/20050821 SeaMonkey/1.0a
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
References: <43057641.70700@symas.com.suse.lists.linux.kernel> <17157.45712.877795.437505@gargle.gargle.HOWL.suse.lists.linux.kernel> <430666DB.70802@symas.com.suse.lists.linux.kernel> <p73oe7syb1h.fsf@verdi.suse.de> <87fyt3vzq0.fsf@mid.deneb.enyo.de> <43095E10.3010003@symas.com> <20050822130618.GA19007@wotan.suse.de>
In-Reply-To: <20050822130618.GA19007@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > processes (PTHREAD_SCOPE_SYSTEM). The previous comment about slapd
> > only needing to yield within a single process is inaccurate; since
> > we allow slapcat to run concurrently with slapd (to allow hot
> > backups) we need BerkeleyDB's locking/yield functions to work in
> > System scope.

>  That's broken by design - it means you can be arbitarily starved by
>  other processes running in parallel. You are basically assuming your
>  application is the only thing running on the system which is wrong.
>  Also there are enough synchronization primitives that can synchronize
>  multiple processes without making such broken assumptions.

Again, I think you overstate the problem. "Arbitrarily starved by other 
processes" implies that the process scheduler will do a poor job and 
will allow the slapd process to be starved. We do not assume we're the 
only app on the system, we just assume that eventually we will get the 
CPU back. If that's not a valid assumption, then there is something 
wrong with the underlying system environment.

Something you ought to keep in mind - correctness and compliance are 
well and good, but worthless if the end result isn't useful. Windows NT 
has a POSIX-compliant subsystem but it is utterly useless. That's what 
you wind up with when all you do is conform to the letter of the spec.

-- 
  -- Howard Chu
  Chief Architect, Symas Corp.  http://www.symas.com
  Director, Highland Sun        http://highlandsun.com/hyc
  OpenLDAP Core Team            http://www.openldap.org/project/

