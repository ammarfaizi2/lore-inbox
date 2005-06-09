Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVFIIDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVFIIDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVFIIDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:03:21 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:5611 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262323AbVFIIDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:03:16 -0400
Date: Thu, 9 Jun 2005 09:52:58 +0200 (CEST)
To: akpm@osdl.org,
       ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com
Subject: Re: BUG in i2c_detach_client
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <2Y7hnCpC.1118303578.5739060.khali@localhost>
In-Reply-To: <20050608163212.7c9f9255.akpm@osdl.org>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Greg KH" <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

> > Will do. But I don't think that's it. I've been adding printks to
> > determine the execution path and it goes through the ERROR3 path in
> > asb100_detect(), which means AFACT that the error path in
> > asb100_detect_subclients() isn't taken:
> >
> >  ERROR3:
> >          i2c_detach_client(data->lm75[0]);
> >          kfree(data->lm75[1]);
> >          kfree(data->lm75[0]);
> >  ERROR2:
> >          i2c_detach_client(new_client); // <--- BUG() in here.
> >  ERROR1:
> >          kfree(data);
> >  ERROR0:
> >          return err;
>
> hm, the tree I have here doesn't do that.  What kernel do you have there?

I suspect that the bug will only show when the i2c-core and asb100
drivers (and the relevant i2c bus driver) are built into the kernel.
(See my previous post.)

Thanks,
--
Jean Delvare
