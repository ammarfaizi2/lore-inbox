Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVAOBMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVAOBMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVAOBJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:09:08 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:20673 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262089AbVAOBGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:06:45 -0500
Date: Sat, 15 Jan 2005 02:06:32 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Karim Yaghmour <karim@opersys.com>
cc: Andi Kleen <ak@muc.de>, Nikita Danilov <nikita@clusterfs.com>,
       linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@us.ibm.com>
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <41E8358A.4030908@opersys.com>
Message-ID: <Pine.LNX.4.61.0501150101010.30794@scrub.home>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
 <41E7A7A6.3060502@opersys.com> <Pine.LNX.4.61.0501141626310.6118@scrub.home>
 <41E8358A.4030908@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 14 Jan 2005, Karim Yaghmour wrote:

> As you can see, most of this is already used in one way or another by
> LTT. The only thing LTT doesn't use is the dynamic resizing, but as was
> said earlier in this thread, some people actually want to have this.

This doesn't mean everything has to be put into a single call. Several 
parameters can still be set after creation.

> start_reserve, end_reserve, rchan_start_reserve:
>         Some subsystems, like LTT, need to be able to write some key
>         data at sub-buffer boundaries. This is to specify how much
>         space is required for said data.

Why should a subsystem care about the details of the buffer management?
You could move all this into the relay layer by making a relay channel 
an event channel. I know you want to save space, but having a magic 
event_struct_size array is not a good idea. If you have that much events, 
that a little more overhead causes problems, the tracing results won't be 
reliable anymore anyway.
Simplicity and maintainability are far more important than saving a few 
bytes, the general case should be fast and simple, leave the complexity to 
the special cases.

bye, Roman
