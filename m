Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267569AbRGNDlh>; Fri, 13 Jul 2001 23:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267571AbRGNDl1>; Fri, 13 Jul 2001 23:41:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24337 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S267569AbRGNDlU>; Fri, 13 Jul 2001 23:41:20 -0400
Date: Fri, 13 Jul 2001 23:09:54 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] VM statistics code
In-Reply-To: <3B4FBC7E.D8694436@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0107132308040.4111-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Jul 2001, Andrew Morton wrote:

> Marcelo Tosatti wrote:
> > 
> > Hi Linus,
> > 
> > The following patch adds detailed VM statistics (reported via /proc/stats)
> > which is tunable on/off by the CONFIG_VM_STATS option.
> 
> We need this, bad.  Two suggested changes:
> 
> >
> > +#define VM_STAT_INC_PTEUNMAP(zone) zone->stat.vm_pteunmap++;
> 
> All these macros are a waste of space :)
> 
> Much better to have:
> 
> #define VM_STAT_ZONE(zone, op)	zone->stat.op
> 
> Then, at the call site:
> 
> 	VM_STAT_ZONE(some_zone, vm_pteunmap++);
> 
> Or, if you prefer,
> 
> #define VM_STAT_ZONE_INC(zone, field)	zone->field++
> 
> That way, you don't have to add a new macro each time
> you add a new field.

You're right. Will do that.

> Also, a sysrq key which dumps the stats out, please - when
> your box has wedged there ain't no way you'll be running
> vmstat.

Agreed. 

Thanks for your comments. 

