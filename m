Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbTIBMbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 08:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbTIBMbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 08:31:13 -0400
Received: from mta03.fuse.net ([216.68.1.123]:44214 "EHLO mta03.fuse.net")
	by vger.kernel.org with ESMTP id S261385AbTIBMa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 08:30:59 -0400
From: "Dale E Martin" <dmartin@cliftonlabs.com>
Date: Tue, 2 Sep 2003 08:30:50 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: repeatable, hard lockup on boot in linux-2.6.0-test4 (more details)
Message-ID: <20030902123050.GA854@cliftonlabs.com>
References: <20030902003146.GA870@cliftonlabs.com> <20030901182335.4c2e220f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901182335.4c2e220f.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I hadn't noticed the call to i8042_check_mux inside the if statement
condition after the loop, doh!)

> Can you try this one please?

Yes, this time it did this loop 4 times:
     for (i = 0; i < 4; i++) {
	 DB();
		i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
  }

And then I got one more at 590, inside i8042_check_mux:
    DB();
    if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
						  "i8042", i8042_request_irq_cookie))
                return -1;
		DB();

This last one did not show up, nor did any inside the conditional loops at
line 878 or 883, nor at line 888.  So perhaps it was in request_irq that it
locked up?

I'll be away from this machine for the day, although I can try something
new this evening.

Take care,
     Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
(I hadn't noticed the call to i8042_check_mux inside the if statement
condition after the loop, doh!)

> Can you try this one please?

Yes, this time it did this loop 4 times:
     for (i = 0; i < 4; i++) {
	 DB();
		i8042_init_mux_values(i8042_mux_values + i, i8042_mux_port + i, i);
  }

And then I got one more at 590, inside i8042_check_mux:
    DB();
    if (request_irq(values->irq, i8042_interrupt, SA_SHIRQ,
						  "i8042", i8042_request_irq_cookie))
                return -1;
		DB();

This last one did not show up, nor did any inside the conditional loops at
line 878 or 883, nor at line 888.  So perhaps it was in request_irq that it
locked up?

I'll be away from this machine for the day, although I can try something
new this evening.

Take care,
     Dale
-- 
Dale E. Martin, Clifton Labs, Inc.
Senior Computer Engineer
dmartin@cliftonlabs.com
http://www.cliftonlabs.com
pgp key available
