Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932522AbWCWWgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbWCWWgd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932524AbWCWWgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:36:33 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:26816 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932522AbWCWWgc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:36:32 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 02/13] powerpc: add hvc backend for rtas
Date: Thu, 23 Mar 2006 23:36:19 +0100
User-Agent: KMail/1.9.1
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       "Ryan S. Arnold" <rsa@us.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323203521.100452000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323213217.GB5538@pb15.lixom.net>
In-Reply-To: <20060323213217.GB5538@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603232336.19683.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thursday 23 March 2006 22:32 schrieb Olof Johansson:
> > +static inline int hvc_rtas_write_console(uint32_t vtermno, const char
> > *buf, int count) +{
> > +     int done;
> > +
> > +     /* if there is more than one character to be displayed, wait a bit */
> > +     for (done = 0; done < count; done++) { 
> > +             int result;
> > +             result = rtas_call(rtascons_put_char_token, 1, 1, NULL, buf[done]);
> > +             if (result) 
> > +                     break;
>
> Why introduce a scope-local variable just to check it?
>                 if(rtas_call(...))   would be cleaner.

I don't like doing the important stuff inside of another expression,
and I prefer conditions not to have side-effects.
If nobody else has a strong opinion on it, I'd prefer to leave it.

BTW, who is the current maintainer of hvc_console? Ryan is working on
glibc nowadays, right?

> > +     /* Really the fun isn't over until the worker thread breaks down
> > and the +      * tty cleans up */
> > +     if (hvc_rtas_dev)
> > +             hvc_remove(hvc_rtas_dev);
> > +}
> > +module_exit(hvc_rtas_exit); /* before drivers/char/hvc_console.c */
>
> Cryptic comment?

No idea how what it was about, I'll remove it.

	Arnd <><
