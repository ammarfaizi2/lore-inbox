Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbWH3RhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbWH3RhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 13:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWH3RhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 13:37:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38316 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751218AbWH3RhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 13:37:15 -0400
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Cedric Le Goater <clg@fr.ibm.com>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, video4linux-list@redhat.com,
       kraxel@bytesex.org, haveblue@us.ibm.com, serue@us.ibm.com,
       Containers@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060830094943.bad0d618.akpm@osdl.org>
References: <20060829211555.GB1945@us.ibm.com>
	 <20060829143902.a6aa2712.akpm@osdl.org> <44F5BD23.3000209@fr.ibm.com>
	 <20060830094943.bad0d618.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 30 Aug 2006 14:36:41 -0300
Message-Id: <1156959402.3852.82.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua, 2006-08-30 às 09:49 -0700, Andrew Morton escreveu:
> On Wed, 30 Aug 2006 18:30:27 +0200
> Cedric Le Goater <clg@fr.ibm.com> wrote:
> 

> > The thread of this driver allows SIGTERM for some obscure reason. Not sure
> > why, I didn't find anything relying on it.
> > 
> > could we just remove the allow_signal() ?
> > 
> 
> I hope so.  However I have a bad feeling that the driver wants to accept
> signals from userspace.  Hopefully Mauro & co will be able to clue us in.

The history we have on our development tree goes only until Feb, 2004.
This line were added before it.

I've looked briefly the driver. The same allow_signal is also present on
tvaudio (part of bttv driver). BTTV were written to kernel 2.1, so, this
piece seems to be an inheritance from 2.1 time.

No other V4L drivers have this one, although cx88-tvaudio (written on
2.6 series) have a similar kthread to check if audio status changed. 

On cx88-tvaudio, it does:
                if (kthread_should_stop())
                        break;
instead of:

                if (dev->thread.shutdown || signal_pending(current))
                        goto done;

It is likely to work if we remove allow_signal and replacing the
signal_pending() by kthread_should_stop() as above.

The better is to check the real patch on a saa7134 hardware before
submiting to mainstream. You may submit the final patch for us to test
at the proper hardware.

Cheers, 
Mauro.

