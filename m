Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267570AbRGND22>; Fri, 13 Jul 2001 23:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267569AbRGND2S>; Fri, 13 Jul 2001 23:28:18 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:12269 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S267568AbRGND2B>; Fri, 13 Jul 2001 23:28:01 -0400
Message-ID: <3B4FBC7E.D8694436@uow.edu.au>
Date: Sat, 14 Jul 2001 13:29:02 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] VM statistics code
In-Reply-To: <Pine.LNX.4.21.0107131856470.3716-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Hi Linus,
> 
> The following patch adds detailed VM statistics (reported via /proc/stats)
> which is tunable on/off by the CONFIG_VM_STATS option.

We need this, bad.  Two suggested changes:

>
> +#define VM_STAT_INC_PTEUNMAP(zone) zone->stat.vm_pteunmap++;

All these macros are a waste of space :)

Much better to have:

#define VM_STAT_ZONE(zone, op)	zone->stat.op

Then, at the call site:

	VM_STAT_ZONE(some_zone, vm_pteunmap++);

Or, if you prefer,

#define VM_STAT_ZONE_INC(zone, field)	zone->field++

That way, you don't have to add a new macro each time
you add a new field.



Also, a sysrq key which dumps the stats out, please - when
your box has wedged there ain't no way you'll be running
vmstat.

-
