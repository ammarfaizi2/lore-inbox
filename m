Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318320AbSGWUxY>; Tue, 23 Jul 2002 16:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318322AbSGWUxY>; Tue, 23 Jul 2002 16:53:24 -0400
Received: from ns.suse.de ([213.95.15.193]:27656 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318320AbSGWUxS>;
	Tue, 23 Jul 2002 16:53:18 -0400
Date: Tue, 23 Jul 2002 22:56:28 +0200
From: Dave Jones <davej@suse.de>
To: Patrick Mochel <mochel@osdl.org>
Cc: Markus Pfeiffer <profmakx@profmakx.org>, linux-kernel@vger.kernel.org
Subject: Re: CPU detection broken in 2.5.27?
Message-ID: <20020723225628.D16446@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Patrick Mochel <mochel@osdl.org>,
	Markus Pfeiffer <profmakx@profmakx.org>, linux-kernel@vger.kernel.org
References: <20020723223456.C16446@suse.de> <Pine.LNX.4.44.0207231333330.954-100000@cherise.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207231333330.954-100000@cherise.pdx.osdl.net>; from mochel@osdl.org on Tue, Jul 23, 2002 at 01:34:37PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2002 at 01:34:37PM -0700, Patrick Mochel wrote:
 > 
 > > Which stepping do you have ?
 > 2.

I meant ->x86_model there, I assume you did too, and you have a 0xF24/0xF27 cpu.
I wasn't aware these were HT aware. In fact, only 0xF50 are confirmed.
Interesting.

 > Sorry, it was in the invisible charset. 

Ah ok. I'll install the correct font later.

 > ===== arch/i386/kernel/cpu/intel.c 1.3 vs edited =====
 > --- 1.3/arch/i386/kernel/cpu/intel.c	Wed Jul 10 03:46:31 2002
 > +++ edited/arch/i386/kernel/cpu/intel.c	Tue Jul 23 13:25:01 2002
 > @@ -232,15 +232,19 @@
 >  	if (c->x86 == 6) {
 >  		switch (c->x86_model) {
 >  		case 5:
 > -			if (l2 == 0)
 > -				p = "Celeron (Covington)";
 > -			if (l2 == 256)
 > -				p = "Mobile Pentium II (Dixon)";
 > +			if (c->x86_mask == 0) {
 > +				if (l2 == 0)
 > +					p = "Celeron (Covington)";
 > +				else if (l2 == 256)
 > +					p = "Mobile Pentium II (Dixon)";

Something that just nagged me about this code.
Where are those strings stored ? If they're in the same
text as this code, we shouldn't be creating references to them,
as after boot, all this will go poof. (it's __init)

If they are stored there, a simple strdup/memcpy will fix it
of course, but I'm wondering if we even need to. Or does
our linker magic put strings in data sections ?

        Dave
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
