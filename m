Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262559AbVAUT0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVAUT0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262561AbVAUT0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:26:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29900 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262559AbVAUT0p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:26:45 -0500
Date: Fri, 21 Jan 2005 14:26:40 -0500
From: Dave Jones <davej@redhat.com>
To: Prarit Bhargava <prarit@sgi.com>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Message-ID: <20050121192640.GA5479@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Prarit Bhargava <prarit@sgi.com>, linux-kernel@vger.kernel.org,
	vojtech@suse.cz
References: <41F11C66.5000707@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F11C66.5000707@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 10:14:46AM -0500, Prarit Bhargava wrote:

 > Signed-off-by: Prarit Bhargava <prarit@sgi.com>
 > 
 > ===== i8042.c 1.71 vs edited =====
 > --- 1.71/drivers/input/serio/i8042.c    2005-01-03 08:11:49 -05:00
 > +++ edited/i8042.c      2005-01-21 10:02:20 -05:00
 > @@ -696,7 +696,10 @@
 >                unsigned char param;
 > 
 >                if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
 > -                       printk(KERN_ERR "i8042.c: i8042 controller self 
 > test timeout.\n");

wordwrapped patch.
		
 > +                       if (i8042_read_status() != 0xFF)
 > +                               printk(KERN_ERR "i8042.c: i8042 controller 
 > self test timeout.\n");
 > +                       else
 > +                               printk(KERN_ERR "i8042.c: no i8042 
 > controller found.\n");
 >                        return -1;
 >                }
 > 
 >                }

I doubt these }'s should line up, broken indentation ?
 
 > @@ -1011,21 +1014,34 @@
 >        i8042_timer.function = i8042_timer_func;
 > 
 >        if (i8042_platform_init())
 > +       {
 > +               del_timer_sync(&i8042_timer);
 >                return -EBUSY;
 > +       }

Spaces instead of tabs. Oops.
(Also the { should be on the same line as the if)

Nitpicking..

		Dave
