Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbTKJGoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 01:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262958AbTKJGoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 01:44:08 -0500
Received: from smtp801.mail.ukl.yahoo.com ([217.12.12.138]:51367 "HELO
	smtp801.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262955AbTKJGoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 01:44:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, arief_mulya <arief_m_utama@telkomsel.co.id>
Subject: Re: [PATCH?] psmouse-base.c
Date: Mon, 10 Nov 2003 01:43:58 -0500
User-Agent: KMail/1.5.4
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
References: <3FAEF7BC.8060503@telkomsel.co.id> <20031109201211.2ce2edce.akpm@osdl.org>
In-Reply-To: <20031109201211.2ce2edce.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311100143.58955.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 November 2003 11:12 pm, Andrew Morton wrote:
> arief_mulya <arief_m_utama@telkomsel.co.id> wrote:
> > static int psmouse_pm_callback(struct pm_dev *dev, pm_request_t
> > request, void *data)
> >  {
> >          struct psmouse *psmouse = dev->data;
> >          struct serio_dev *ser_dev = psmouse->serio->dev;
> >
> >
> >          switch (request) {
> >          case PM_RESUME:
> >                  psmouse->state = PSMOUSE_IGNORE;
> >                  serio_rescan(psmouse->serio);
> >          default:
> >                  return 0;
> >          }
> >  }
>
> What does the driver do without this change?  ie: what problem is this
> fixing?
>
> Why is it calling serio_rescan() rather than serio_reconnect()?
>

serio_reconnect() is only in your tree (-mm), it has not been pushed to
Linus yet... Unfortunately using rescan can cause input devices be shifted
if some program has them open while suspending.

Dmitry
