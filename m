Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWF0UJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWF0UJg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932564AbWF0UJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:09:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932563AbWF0UJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:09:35 -0400
Message-ID: <44A19068.9060904@osdl.org>
Date: Tue, 27 Jun 2006 13:09:12 -0700
From: John Daiker <jdaiker@osdl.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Marko Macek <Marko.Macek@gmx.net>
CC: vojtech@suse.cz, thoffman@arnor.net, vanackere@lif.univ-mrs.fr,
       linux-kernel@vger.kernel.org
Subject: Re: USB input ati_remote autorepeat problem
References: <44A18C38.7040504@gmx.net>
In-Reply-To: <44A18C38.7040504@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have also experience this problem with the ati_remote driver, but 
didn't know the fix.  If I am correct, the HZ always used to default to 
1000HZ, but not it is configurable in the kernel as 1000HZ, 250HZ, or 
100HZ.  By my calculations, the FILTER_TIME will be at most 20% longer 
than before, but as little as 2% bigger.

        HZ       Old        New        % Difference
       100       5          6          20%
       250       12.5       13.5       8%
      1000       50         51         2%

Those are my calculations based on your previously stated definitions.  
The FILTER_TIME const is only used 1 time in ati_remote.c, so I doubt 
there would be a problem redefining it.  Would a redefinition to 50 be 
more appropriate (so keep the repeat delay the same across all platforms)?

Tonight I will recompile and test the driver with the 2 new definitions 
and report on my findings.

John



Marko Macek wrote:
> Hello!
>
> I have problems with autorepeat in ati_remote (drivers/usb/input) 
> driver in "recent" kernels: all keys start repeating immediately 
> without some delay.
>
> This makes some things, like changing the channel prev/next or 
> toggling fullscreen, etc... impossible/hard.
>
> The problem seems to be related to FILTER_TIME and HZ=250 (which I 
> forgot to change).
>
> FILTER_TIME is defined to HZ / 20, and since 250 is not divisible by 
> 20, the time will be too short to ignore enough events.
>
> Defining FILTER_TIME to HZ / 20 + 1 seems to fix things, but I'm not 
> sure if there are any bad side effects.
>
>    Mark
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
