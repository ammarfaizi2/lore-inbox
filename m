Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317762AbSFSEiH>; Wed, 19 Jun 2002 00:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317763AbSFSEiH>; Wed, 19 Jun 2002 00:38:07 -0400
Received: from ns.suse.de ([213.95.15.193]:6416 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317762AbSFSEiG>;
	Wed, 19 Jun 2002 00:38:06 -0400
Date: Wed, 19 Jun 2002 06:38:07 +0200
From: Dave Jones <davej@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.x: arch/i386/kernel/cpu
Message-ID: <20020619063807.B25509@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <aeouoe$a66$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <aeouoe$a66$1@cesium.transmeta.com>; from hpa@zytor.com on Tue, Jun 18, 2002 at 08:45:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2002 at 08:45:18PM -0700, H. Peter Anvin wrote:
 > Whomever broke up arch/i386/kernel/setup.c and created the CPU
 > directory (very good idea) messed up in at least one place:

Patrick Mochel takes credit/glory/fame/blame for this one.

 > The *AMD-defined* CPUID flags (0x80000001) are not just used on AMD
 > processors!  In fact, at least AMD, Transmeta, Cyrix and VIA all use
 > them; I don't know about Centaur or Rise.  Intel supports the actual
 > level starting with the P4 although it returns all zero.

Bugger, you're right.

On my Cyrix III box before..

 CPU: After vendor init, caps: 00803135 80803035 00000000 00000000
 CPU:     After generic, caps: 00803135 80803035 00000000 00000000
 CPU:             Common caps: 00803135 80803035 00000000 00000000

and after..

 CPU: After vendor init, caps: 00803135 80000000 00000000 00000000
 CPU:     After generic, caps: 00803135 80000000 00000000 00000000
 CPU:             Common caps: 00803135 80000000 00000000 00000000

Interesting how it's picking up that 8 in the 2nd set of caps, but
not any of the other bits..

 > It should, in my opinion, be moved into generic_identify().  Anyone
 > who has a reason why that shouldn't be done speak now or I'll send the
 > patch to Linus.

Sounds reasonable to me, unless Patrick has a preferred way of fixing 
this problem.

        Dave


-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
