Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSAJENE>; Wed, 9 Jan 2002 23:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289156AbSAJEMy>; Wed, 9 Jan 2002 23:12:54 -0500
Received: from cj44686-b.reston1.va.home.com ([24.18.166.90]:56842 "EHLO
	cj44686-b.reston1.va.home.com") by vger.kernel.org with ESMTP
	id <S289159AbSAJEMv>; Wed, 9 Jan 2002 23:12:51 -0500
Date: Wed, 9 Jan 2002 23:37:26 -0500
From: Tim Hollebeek <tim@hollebeek.com>
To: dewar@gnat.com
Cc: groudier@free.fr, jamagallon@able.es, Dautrevaux@microprocess.com,
        gcc@gcc.gnu.org, jtv@xs4all.nl, linux-kernel@vger.kernel.org,
        paulus@samba.org, tim@hollebeek.com, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020109233726.A5016@cj44686-b.reston1.va.home.com>
Reply-To: tim@hollebeek.com
In-Reply-To: <20020110012109.E80C0F2FEB@nile.gnat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20020110012109.E80C0F2FEB@nile.gnat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nope, that's not enough, it's not that simple. Yes your
> example of a-a is of course straightforward but what about
> 
>     b = (a & 1) | (b & 1);
> 
> if a is volatile and b is known to be odd, can the read of a be eliminated?
> The answer should be no (and I think the standard guarantees this), but the
> reasoning is completely different from thinking about the fact that a may
> change unexpectedly, since obviously no matter what value comes from
> reading a, b will be set to 1 if b is known to be odd.

But presumably the transformation to:

a; b = 1;

is ok.  where 'a;' represents the operation "read the value a into a
register and then let that register die".
