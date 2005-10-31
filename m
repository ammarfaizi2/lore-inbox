Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbVJaOFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVJaOFf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbVJaOFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:05:35 -0500
Received: from smtp108.sbc.mail.re2.yahoo.com ([68.142.229.97]:29798 "HELO
	smtp108.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751209AbVJaOFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:05:34 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFT/PATCH] atkbd - speed up setting leds/repeat state
Date: Mon, 31 Oct 2005 09:05:31 -0500
User-Agent: KMail/1.8.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200510310224.03010.dtor_core@ameritech.net> <20051031124746.GC18147@ucw.cz>
In-Reply-To: <20051031124746.GC18147@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510310905.32269.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 October 2005 07:47, Vojtech Pavlik wrote:
> On Mon, Oct 31, 2005 at 02:24:02AM -0500, Dmitry Torokhov wrote:
> > Input: atkbd - speed up setting leds/repeat state
> > 
> > Changing led state is pretty slow operation; when there are multiple
> > requests coming at a high rate they may interfere with normal typing.
> > Try optimize (skip) changing hardware state when multiple requests
> > are coming back-to-back.
> > 
> > Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
>  
> It looks good - just two comments:
> 
> 	1) wmb() shouldn't be needed after set_bit()
>

Judging by the comments in bitops only i386 implementation of set_bit
implies memory barrier, other arches do not guarantee it. That's why
I added wmb() there.
 
> 	2) maybe we want to enforce the delay before we send the 
>            next SET_LED command.
> 

Well, with this patch "while true; do xset led 3; xset led -3; done"
does not interfere with typing on my box and system load is staying
low which means we don't have too many outstanding requests.

-- 
Dmitry
