Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264532AbRFOVpL>; Fri, 15 Jun 2001 17:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264536AbRFOVpB>; Fri, 15 Jun 2001 17:45:01 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:60291 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264532AbRFOVon>;
	Fri, 15 Jun 2001 17:44:43 -0400
Date: Fri, 15 Jun 2001 23:44:16 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dan Streetman <ddstreet@us.ibm.com>
Cc: Alan Cox <alan@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ps2 keyboard filter hook
Message-ID: <20010615234416.A4837@suse.cz>
In-Reply-To: <OF6CD0EC09.7E779796-ON85256A6C.007426B5@raleigh.ibm.com> <Pine.LNX.4.10.10106151704170.27777-100000@ddstreet.raleigh.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10106151704170.27777-100000@ddstreet.raleigh.ibm.com>; from ddstreet@us.ibm.com on Fri, Jun 15, 2001 at 05:30:03PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2001 at 05:30:03PM -0400, Dan Streetman wrote:
> 
> >X11 likes to talk direct to the PS/2 port.  I actually think you should
> >instead
> >talk to Vojtech for the mainstream kernel about the input device work. It
> >sounds much cleaner and more close to what you need
> 
> Ah, I didn't realize the input layer was handling PS/2 stuff...?  Although I am
> not sure it would work; the special needs of these keyboards requires the driver
> to do some bizarre things, such as:
> 
> - change scancodes.  I was and still am shocked by this.  I will say that it is
>   a 'legacy feature' that I'm told is due having to deal with Windoze...
> - consume scancodes.  The keyboard uses normal scancodes for the extra hardware
>   as well as normal keys, so if the driver can't filter them out large amounts
>   of strange characters will appear when (e.g.) a credit card is swiped.
> - send large amounts of bytes (multi-KB) to the PS/2 port (I think this
>   may be possible).
> 
> The filtering needs to be done fairly early (I think), or the keyboard state may
> get corrupted by seemingly random 'normal' scancodes coming in (for non-raw
> modes)...
> 
> Vojtech, could you comment on if the above is possible using the input layer?

Yes, and quite easily it'll fit into the input layer. Basically the way
to do it would be to open the PS/2 port in the filter driver (thus
disabling the normal keyboard driver to open it) and then register a new
PS/2 port which the normal keyboard driver would attach to.

See the input CVS (http://www.suse.cz/development/input/quick.html)

-- 
Vojtech Pavlik
SuSE Labs
