Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbRBSVZu>; Mon, 19 Feb 2001 16:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRBSVZk>; Mon, 19 Feb 2001 16:25:40 -0500
Received: from [213.96.124.18] ([213.96.124.18]:52715 "HELO dardhal")
	by vger.kernel.org with SMTP id <S129537AbRBSVZ3>;
	Mon, 19 Feb 2001 16:25:29 -0500
Date: Mon, 19 Feb 2001 22:26:43 +0000
From: José Luis Domingo López 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: Re: [PATCH] change awe_wave initialization to match 2.2 better
Message-ID: <20010219222643.A2226@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <20010219142809.E5296@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010219142809.E5296@devserv.devel.redhat.com>; from notting@redhat.com on Mon, Feb 19, 2001 at 02:28:09PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 19 February 2001, at 14:28:09 -0500,
Bill Nottingham wrote:

> The awe_wave driver in 2.2 looked at the common I/O ports for
> the card if no parameters were specified. The 2.4 driver currently
> does an ISAPnP probe, but doesn't fall back to the previous probing
> behavior, which means that users with working module configurations
> will have theirs broken on upgrade.
> 
Don't know if what follows has something to do with the patch you
submitted, but under kernel 2.2.x SB AWE 64 had a nasty problem. pnpdump
from the isapnptools (all versions I've tested) only reports one of a
total of three IO adresses for the Wavetable device:
(IO 0 (SIZE 4) (BASE 0x0620))
(IO 1 (SIZE 4) (BASE 0x0A20))  <-- not reported by pnpdump
(IO 2 (SIZE 4) (BASE 0x0E20))  <-- not reported by pnpdump

The latter two lines where manually added, as described in the
SB-AWE-HOWTO. Using isapnptools 1.21-2 (Debian Potato) the card configures
correctly, but with isapnptools 1.23-0.3 (Debian Woody) there is an error
trying to parse the first of the manually added lines (Don't know what to
do with A20)) on or around line 350).

It seem obvious that this change in behaviour is isapnptools related, but
not detecting the whole three IO addresses is an unresolved problem (as of
2.2.18, not tried with built-in PnP support in 2.4.x).

Would you need more information ?. I'm a totally kernel-devel newbie, but
with 3+ years using Linux, I think I can help with testing and triying
with kernel 2.4.x or patched 2.2.x.

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo EN internautas PUNTO org  => ¿ Spam ? Atente a las consecuencias
jdomingo AT internautas DOT   org  => Spam at your own risk

