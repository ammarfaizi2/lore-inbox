Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262760AbTCPVYy>; Sun, 16 Mar 2003 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262762AbTCPVYy>; Sun, 16 Mar 2003 16:24:54 -0500
Received: from holomorphy.com ([66.224.33.161]:14807 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262760AbTCPVYx>;
	Sun, 16 Mar 2003 16:24:53 -0500
Date: Sun, 16 Mar 2003 13:35:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
Message-ID: <20030316213516.GM20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303162203590.11399-100000@localhost.localdomain> <3E74EB92.7010801@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E74EB92.7010801@colorfullife.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>> have you seen my "procfs/procps threading performance speedup" patch? It
>> does something like this.

On Sun, Mar 16, 2003 at 10:24:34PM +0100, Manfred Spraul wrote:
> Interesting patch. Do seekdir and telldir still work? I think you must 
> detect lseek calls and invalidate the cookie - either by hooking lseek 
> or by looking at f_version.
> I think my solution for proc_pid_readdir() is better: You must fall back 
> to the old algorithm if the pid number stored in f_private got invalid 
> between two syscalls. I've modified the hash table slightly and search 
> for the next pid value directly, which works even if the current 
> position disappeared.

I'm heavily on the side of deterministic bounds here (these things trip
the NMI oopser, so if the bounds aren't deterministic, neither is
stability), so I favor manfred's proc_pid_readdir() algorithm.

It actually looks compatible with your prior patch aside from replacing
and/or modifying its get_pid_list() speedup.


-- wli
