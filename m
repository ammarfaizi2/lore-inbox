Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUHMV3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUHMV3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 17:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267600AbUHMV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 17:29:20 -0400
Received: from mail1.kontent.de ([81.88.34.36]:48330 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S267566AbUHMV3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 17:29:18 -0400
Date: Fri, 13 Aug 2004 23:29:19 +0200
From: Sascha Wilde <wilde@sha-bang.de>
To: "David N. Welton" <davidw@eidetix.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: 2.6 kernel won't reboot on AMD system - 8042 problem?
Message-ID: <20040813212919.GA876@kenny.sha-bang.local>
References: <20040811141408.17933.qmail@web81304.mail.yahoo.com> <20040811175613.GA829@kenny.sha-bang.local> <411BA214.2060306@eidetix.com> <411BA797.2030705@eidetix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <411BA797.2030705@eidetix.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2004 at 07:23:35PM +0200, David N. Welton wrote:
> David N. Welton wrote:
> 
> >Sascha, if you want to test it out, try this in i8042_controller_init,
> >at about line 724 (near this: i8042_initial_ctr = i8042_ctr;)
> >
> >    {
> >        unsigned char pram;
> >        pram = (~i8042_ctr) & 0xff ;
> >        i8042_command(&pram, I8042_CMD_CTL_WCTR);
> >    }
> 
> In fact, it's enough to fix the problem on my machine!  I can even plug 
> the keyboard back in and it works.
> 
> --- /home/davidw/linux-2.6.7/drivers/input/serio/i8042.c 
> 2004-06-16 07:18
> :57.000000000 +0200
> +++ drivers/input/serio/i8042.c 2004-08-12 19:05:17.000000000 +0200
> @@ -710,6 +710,9 @@
>                 return -1;
>         }
> 
> +
> +       i8042_ctr = (~i8042_ctr) & 0xff;
> +
>         i8042_initial_ctr = i8042_ctr;
> 
> Try that and see how it works for you

This works for me too.  Thanks!

I hadn't had the time to read the rest of the thread in full detail,
but it seem, that we are geting closer to a solution.

cheers
sascha
-- 
Sascha Wilde
"Gimme about 10 seconds to think for a minute..."

