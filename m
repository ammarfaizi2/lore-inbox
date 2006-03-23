Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWCWWu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWCWWu0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 17:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWCWWu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 17:50:26 -0500
Received: from lixom.net ([66.141.50.11]:60116 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1161000AbWCWWu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 17:50:26 -0500
Date: Thu, 23 Mar 2006 16:49:26 -0600
To: Arnd Bergmann <arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, Olof Johansson <olof@lixom.net>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, "Ryan S. Arnold" <rsa@us.ibm.com>
Subject: Re: [Cbe-oss-dev] [patch 02/13] powerpc: add hvc backend for rtas
Message-ID: <20060323224925.GC5538@pb15.lixom.net>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323203521.100452000@dyn-9-152-242-103.boeblingen.de.ibm.com> <20060323213217.GB5538@pb15.lixom.net> <200603232336.19683.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603232336.19683.arnd@arndb.de>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 11:36:19PM +0100, Arnd Bergmann wrote:
> Am Thursday 23 March 2006 22:32 schrieb Olof Johansson:
> > > +static inline int hvc_rtas_write_console(uint32_t vtermno, const char
> > > *buf, int count) +{
> > > +     int done;
> > > +
> > > +     /* if there is more than one character to be displayed, wait a bit */
> > > +     for (done = 0; done < count; done++) { 
> > > +             int result;
> > > +             result = rtas_call(rtascons_put_char_token, 1, 1, NULL, buf[done]);
> > > +             if (result) 
> > > +                     break;
> >
> > Why introduce a scope-local variable just to check it?
> >                 if(rtas_call(...))   would be cleaner.
> 
> I don't like doing the important stuff inside of another expression,
> and I prefer conditions not to have side-effects.
> If nobody else has a strong opinion on it, I'd prefer to leave it.

Ok. It just looked silly to have the declaration/assignment/test and no
use of result outside of those three lines.

> BTW, who is the current maintainer of hvc_console? Ryan is working on
> glibc nowadays, right?

That's what I think IBM pays him to do, that's never stopped people from
maintaining other code in the past though. :-)


-Olof
