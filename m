Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030446AbWHIDrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbWHIDrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWHIDrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:47:25 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:27012 "EHLO
	asav14.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1030446AbWHIDrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:47:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAOL22ESBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: Fabio Comolli <fabio.comolli@gmail.com>
Subject: Re: 2.6.18-rc3-mm2
Date: Tue, 8 Aug 2006 23:47:22 -0400
User-Agent: KMail/1.9.3
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <d120d5000608081124s53777b42v4bb4d48c90f6a59e@mail.gmail.com> <b637ec0b0608081136o3adf98dbn15e206c8eea41a1c@mail.gmail.com>
In-Reply-To: <b637ec0b0608081136o3adf98dbn15e206c8eea41a1c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608082347.22544.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 14:36, Fabio Comolli wrote:
> Hi.
> 
> On 8/8/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On 8/8/06, Fabio Comolli <fabio.comolli@gmail.com> wrote:
> > > Hi Dmitry.
> > >
> > > On 8/8/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > > > Fabio, do you have a multiplexing controller as well?
> > >
> > > Well, I don't even know what this means :-(
> > > How do I know?
> > >
> > > However, it's a HP laptop, model name Pavillion DV4378EA.
> > >
> >
> > Yep, you do have it:
> >
> > > i8042.c: Detected active multiplexing controller, rev 1.1.
> >
> > Could you please try booting with i8042.nomux and tell me if it works?
> >
> 
> Yup, it works.
> 

Fabio, Rafael,

Could you please try applying the patch below on top of -rc3-mm2 and
see if it works without needing i8042.nomux?

Thank you! 

-- 
Dmitry

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/serio/i8042.c
===================================================================
--- work.orig/drivers/input/serio/i8042.c
+++ work/drivers/input/serio/i8042.c
@@ -435,7 +435,7 @@ static int i8042_enable_mux_ports(void)
 		i8042_command(&param, I8042_CMD_AUX_ENABLE);
 	}
 
-	return 0;
+	return i8042_enable_aux_port();
 }
 
 /*
