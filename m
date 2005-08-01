Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVHAVo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVHAVo5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVHAVm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:42:56 -0400
Received: from graphe.net ([209.204.138.32]:17831 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261296AbVHAVko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:40:44 -0400
Date: Mon, 1 Aug 2005 14:40:39 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1122931637.7648.125.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508011438010.7888@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net>  <1122930474.7648.119.camel@localhost.localdomain>
  <Pine.LNX.4.62.0508011414480.7574@graphe.net> <1122931637.7648.125.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Richard Purdie wrote:

> > IP Not changing? Could it be in a loop doing faults for the same memory 
> > location that you cannot observe with gdb? Or is there some hardware fault 
> > that has stopped the processor?
> 
> I'm not the worlds most experienced user of gdb but I can't see any
> evidence of a hardware fault and the processor shows all indications of
> running. It seems likely to be looping with memory faults or otherwise
> jammed somehow.

Can you run kgdb on it to figure out what is going on?

> Is there anything I can use in /proc to monitor page faults or anything
> I can do with gdb to help narrow this down?

Run kgdb and see what is going on in the fault handler.

There are some variables in /proc/vmstat that may help:

spurious_page_faults 0
cmpxchg_fail_flag_update 0
cmpxchg_fail_flag_reuse 0
cmpxchg_fail_anon_read 0
cmpxchg_fail_anon_write 0

etc.


