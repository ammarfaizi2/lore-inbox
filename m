Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUDUCRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUDUCRq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 22:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUDUCRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 22:17:45 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:50276 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264500AbUDUCRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 22:17:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kim Holviala <kim@holviala.com>
Subject: Re: [PATCH] psmouse fixes for 2.6.5
Date: Tue, 20 Apr 2004 21:17:35 -0500
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org
References: <200404201038.46644.kim@holviala.com> <200404200759.11446.dtor_core@ameritech.net> <200404202338.53773.kim@holviala.com>
In-Reply-To: <200404202338.53773.kim@holviala.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404202117.37104.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 03:38 pm, Kim Holviala wrote:
> On Tuesday 20 April 2004 15:59, Dmitry Torokhov wrote:
> > On Tuesday 20 April 2004 02:38 am, Kim Holviala wrote:
> > > Some fixes for PS/2 mice:
> > >
> > > - fixed hotplugging (real reset of device instead of softreset)
> > > - support for Targus Scroller mice (from my last weeks patch)
> > > - extended protocol probing fixed
> >
> > Why do you have Tragus as a config option - just set the protocol mask
> > correctly by default...
> 
> Targus mice misuse the normal PS/2 protocol so that they can sneak through 
> command-filtering PS/2 ports (like on my Digital HiNote 2000). Basically they 
> output very strange but valid traffic when the wheel is moved. Anyway, this 
> is Linux, and I'd rather force people to turn it on explicitly rather than 
> take the risk of breaking some valid PS/2 device which might theoretically 
> output the same stuff.
>
 
And I think you will achieve the desired result by just doing:

-static unsigned int psmouse_max_proto = -1U;
+static unsigned int psmouse_probe_proto = PSMOUSE_ANY & ~PSMOUSE_TARGUS;

Think about distributions, they will just have turn this option on anyway.

-- 
Dmitry
