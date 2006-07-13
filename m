Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWGMQRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWGMQRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbWGMQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:17:37 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:26059 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932477AbWGMQRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:17:36 -0400
Subject: Re: Linker error with latest tree on EM64T
From: Marcel Holtmann <marcel@holtmann.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arjan van de Ven <arjan@infradead.org>, jakub@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060713161020.GA22355@mars.ravnborg.org>
References: <1152788160.4838.2.camel@localhost>
	 <1152788387.3024.32.camel@laptopd505.fenrus.org>
	 <1152791882.4838.6.camel@localhost>
	 <20060713132631.GA21657@mars.ravnborg.org>
	 <1152797421.4838.12.camel@localhost>
	 <20060713161020.GA22355@mars.ravnborg.org>
Content-Type: text/plain
Date: Thu, 13 Jul 2006 18:17:06 +0200
Message-Id: <1152807426.4838.59.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> > > From -linus:
> > > # Force gcc to behave correct even for buggy distributions
> > > CFLAGS          += $(call cc-option, -fno-stack-protector-all \
> > >                                      -fno-stack-protector)
> > 
> > I used the latest tree from Linus and I see this in the Makefile, but it
> > is not working.
> Unexpected - let's see if we can nail it down then.
> Can you please try to edit the line above to include only one of the -f
> options and see if that helps. make V=1 may help to identify if the flag
> are picked up or not.

see my previous email. This patch fixed it for me:

diff --git a/Makefile b/Makefile
index 7c010f3..b4a2a80 100644
--- a/Makefile
+++ b/Makefile
@@ -308,7 +308,7 @@ LINUXINCLUDE    := -Iinclude \
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+                   -fno-strict-aliasing -fno-common -fno-stack-protector
 # Force gcc to behave correct even for buggy distributions
 CFLAGS          += $(call cc-option, -fno-stack-protector-all \
                                      -fno-stack-protector)

> Also could you try executing:
> if gcc -fno-stack-protector-all -S -o /dev/null -xc /dev/null; then \
>   echo "y"; else echo "n"; fi
> And see if this gives a "y" or a "n".
> Try with -fno-stack-protector-all and with -fno-stack-protector.

With -fno-stack-protector I get a "y" and with -fno-stack-protector-all
I get an error:

cc1: error: unrecognized command line option "-fno-stack-protector-all"

Regards

Marcel


