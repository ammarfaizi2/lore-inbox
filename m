Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVARACv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVARACv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVARACv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:02:51 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:58774
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261227AbVARACb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:02:31 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>
In-Reply-To: <41EC4D18.3060100@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
	 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
	 <41E7A7A6.3060502@opersys.com>
	 <Pine.LNX.4.61.0501141626310.6118@scrub.home>
	 <41E8358A.4030908@opersys.com>
	 <Pine.LNX.4.61.0501150101010.30794@scrub.home>
	 <41E899AC.3070705@opersys.com>
	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>
	 <41EA0307.6020807@opersys.com>
	 <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com>
	 <1105925842.13265.364.camel@tglx.tec.linutronix.de>
	 <41EB21C2.3020608@opersys.com>
	 <1105964417.13265.406.camel@tglx.tec.linutronix.de>
	 <41EC20FB.9030506@opersys.com>
	 <1106001113.13265.474.camel@tglx.tec.linutronix.de>
	 <41EC4D18.3060100@opersys.com>
Content-Type: text/plain
Date: Tue, 18 Jan 2005 01:02:28 +0100
Message-Id: <1106006548.13265.521.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-17 at 18:41 -0500, Karim Yaghmour wrote:
> Thomas Gleixner wrote:
> > I know, what I have said. I said reduce the filtering to the absolute
> > minimum and do the rest in userspace.
> 
> You keep adopting the interpretation which best suits you, taking
> quotes out of context, and keep repeating things that have already
> been answered. There are limits to one's patience.

I said before: "Sorting out disabled events is the filtering you 
have to do in kernel and you should do it in the hot path or
remove the unneccecary tracepoints at compiletime." 

This is exactly what I stated above. I omitted the addon of "do the rest 
in userspace", as it was obvious enough.

> What you did is change your position twice. It's there for anyone to see.

Sorry, I didn't know that you are representing anyone.

> > The now builtin filters are defined to fit somebodys needs or idea of
> > what the user should / wants to see. They will not fit everybodys
> > needs / ideas. So we start modifying, adding and #ifdefing kernel
> > filters, which is a scary vision.
> 
> Ah, finally. Here's an actual suggestion. _IF_ you want, I'll just
> export a ltt_set_filter(*callback) and rewrite the if in
> _ltt_log_event() to:
> if ((ltt_filter != NULL) && !(&ltt_filter(event_id, event_struct, data)))
> 	return -EINVAL;
> 
> You're always welcome to do the following from anywhere in your code:
> ltt_set_filter(NULL);

Provide a hook, export it and load your filters as a module, but keep
the filters out of the mainline kernel code. 

> > Enabling and disabling events is a valid basic filter request, which
> > should live in the kernel. Anything else should go into userspace, IMO.
> 
> What you are suggesting is that a system administator that wants to
> monitor his sendmail server over a period of three weeks should
> just postprocess 1.8TB (1MB/s) of data because Thomas Gleixner didn't
> like the idea of kernel event filtering based on anything but events.

A real common scenario with a broad range of users. And everybody has to
like the idea of hardwired filters in the kernel code to make the life
of this sysadmin easier.

See above about hooks.

Maybe some simple pipe would be helpful too:
	read_stream | prefilter | buildbuffers | storeit

tglx


