Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262770AbULQH7P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbULQH7P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 02:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbULQH7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 02:59:14 -0500
Received: from mail1.speakeasy.net ([216.254.0.201]:25768 "EHLO
	mail1.speakeasy.net") by vger.kernel.org with ESMTP id S262770AbULQH6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 02:58:53 -0500
Date: Thu, 16 Dec 2004 23:58:51 -0800 (PST)
From: vlobanov <vlobanov@speakeasy.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Mitchell Blank Jr <mitch@sfgoth.com>,
       krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Significance of do ... while (0)
In-Reply-To: <Pine.LNX.4.61.0412170843530.14529@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0412162354030.26987@shell3.speakeasy.net>
References: <41C25BDC.8080404@globaledgesoft.com> <20041217042911.GH76532@gaz.sfgoth.com>
 <Pine.LNX.4.61.0412170843530.14529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>    Can any one explain the importance of do  ... while (0)
> >
> >It's a standard C programming practice; more info is available from
> >your local search engine:
> >  http://www.google.com/search?lr=&c2coff=1&q=%22while%280%29%22
>
> Why? {} would suffice, no need to do{}while(0)
>
>
>
> Jan Engelhardt
> --
> ENOSPC
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Unless I'm mistaken, it won't work in all cases. Example:

    #define foo(...) { ... /* nefarious macro stuff here */ ... }

    if (some_condition)
        foo();
    else
        // do something nifty

The above would expand to:

    if (some_condition) {
        /* nefarious macro stuff here */
    };
    else
        // do something nifty

And that's not quite right.

-Vadim Lobanov
