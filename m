Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422706AbWA0Xp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422706AbWA0Xp4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWA0Xp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:45:56 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:21825 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422706AbWA0Xpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:45:55 -0500
Message-ID: <43DAB0AC.9010108@oracle.com>
Date: Fri, 27 Jan 2006 15:45:48 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [x86-64] align per-cpu section to configured cache
 bytes
References: <20060127220242.13917.839.sendpatchset@tetsuo.zabbo.net> <20060127233227.GA9274@mars.ravnborg.org>
In-Reply-To: <20060127233227.GA9274@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Jan 27, 2006 at 02:02:42PM -0800, Zach Brown wrote:
> 
>>-  . = ALIGN(32);
>>+  . = ALIGN(CONFIG_X86_L1_CACHE_BYTES);
> 
> 
> Grepping other arch's than just x86 and x86_64 it looks like a common
> thing.
> Is this fix really only relevant for x86 + x86_64 or should it be done
> for all arch's?

I think it'd be needed if other archs had situations where C's
(load_module()'s, in particular) notion of the cacheline size differed
from vmlinux.lds.S's.  I didn't want to go screwing around with archs
that I couldn't immediately test :)

> If we do it for all archs we may as well create:
> #define PERCPU(aling) ...
> macro in asm-generic/vmlinux.lds.h

Sounds reasonable to me, should I leave that in your capable hands?

- z
