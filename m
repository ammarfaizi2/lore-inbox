Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135826AbRA2K6L>; Mon, 29 Jan 2001 05:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136619AbRA2K6B>; Mon, 29 Jan 2001 05:58:01 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:13842 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135826AbRA2K5w> convert rfc822-to-8bit;
	Mon, 29 Jan 2001 05:57:52 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dieter Nuetzel <Dieter.Nuetzel@hamburg.de>
Date: Mon, 29 Jan 2001 11:56:13 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-2
Content-transfer-encoding: 8BIT
Subject: Re: Linux-2.4.1-pre11 / ll_rw_b watermark metric?
CC: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-mailer: Pegasus Mail v3.40
Message-ID: <13F3075C2004@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jan 01 at 4:43, Dieter Nützel wrote:
> I have pre11 running with Andrea's suggested fix.
> 
>         high_queued_sectors = total_ram / 3;
>         low_queued_sectors = high_queued_sectors / 2;
>         if (low_queued_sectors < 0)
>                 low_queued_sectors = total_ram / 2;
>  

I have one question: How it can happen that low_queued_sectors
is less than zero with this changed logic? (And if it get triggered, 
low_queued_sectors will be greater than high_queued_sectors - which 
is not what we want...)

But it is certainly better than 2.4.0-pre8 approach, as
with 200MB of memory (exactly 192MB left unused) you can end up with 
low_queued_sectors == 0... And it does not give you optimal behavior.
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
