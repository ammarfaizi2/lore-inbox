Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269958AbTGRInR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 04:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270441AbTGRInR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 04:43:17 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:13322 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269958AbTGRInQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 04:43:16 -0400
Date: Fri, 18 Jul 2003 10:58:10 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Walt H <waltabbyh@comcast.net>
Cc: Andries Brouwer <aebr@win.tue.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       arjanv@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davzaffiro@tasking.nl
Subject: Re: [PATCH] pdcraid and weird IDE geometry
Message-ID: <20030718105810.A2925@pclin040.win.tue.nl>
References: <3F160965.7060403@comcast.net> <1058431742.5775.0.camel@laptop.fenrus.com> <3F16B49E.8070901@comcast.net> <1058453918.9055.12.camel@dhcp22.swansea.linux.org.uk> <20030717173413.A2393@pclin040.win.tue.nl> <3F175C5C.3030708@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F175C5C.3030708@comcast.net>; from waltabbyh@comcast.net on Thu, Jul 17, 2003 at 07:33:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 17, 2003 at 07:33:00PM -0700, Walt H wrote:

> OK. Just got home from work. I've tried booting and specifying geometry
> via hdg=79780,16,63 hdg=noprobe etc... The geometry is accepted,
> however, drive access fails when trying to read the disk. This geometry
> is the geometry reported by hde (my old drive without screwy geometry).
>  The code in calc_pdcblock_offset to calculate the offset is unchanged
> in my patch (except the date type conversion to float) and calls
> get_info_ptr for geometry.

I don't understand. Did you introduce some float? Remove it immediately.

You just replace

        lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
        lba = lba * (ideinfo->head*ideinfo->sect);
        lba = lba - ideinfo->sect;

by

	lba = ideinfo->capacity - 63;

Then everything works for you, I suppose.
Subsequently we wait for other people with the same hardware
and see how the 63 varies as a function of their setup.
(Or maybe you can go into the BIOS and specify different
translations yourself?)

(By the way, didnt your boot parameters lead to ideinfo->head = 16
and ideinfo->sect = 63?)

Andries

