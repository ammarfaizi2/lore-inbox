Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWGMQLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWGMQLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 12:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWGMQLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 12:11:21 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:14247 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932436AbWGMQLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 12:11:20 -0400
Date: Thu, 13 Jul 2006 18:10:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arjan van de Ven <arjan@infradead.org>, jakub@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linker error with latest tree on EM64T
Message-ID: <20060713161020.GA22355@mars.ravnborg.org>
References: <1152788160.4838.2.camel@localhost> <1152788387.3024.32.camel@laptopd505.fenrus.org> <1152791882.4838.6.camel@localhost> <20060713132631.GA21657@mars.ravnborg.org> <1152797421.4838.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152797421.4838.12.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel.
> > From -linus:
> > # Force gcc to behave correct even for buggy distributions
> > CFLAGS          += $(call cc-option, -fno-stack-protector-all \
> >                                      -fno-stack-protector)
> 
> I used the latest tree from Linus and I see this in the Makefile, but it
> is not working.
Unexpected - let's see if we can nail it down then.
Can you please try to edit the line above to include only one of the -f
options and see if that helps. make V=1 may help to identify if the flag
are picked up or not.

Also could you try executing:
if gcc -fno-stack-protector-all -S -o /dev/null -xc /dev/null; then \
  echo "y"; else echo "n"; fi
And see if this gives a "y" or a "n".
Try with -fno-stack-protector-all and with -fno-stack-protector.

	Sam
