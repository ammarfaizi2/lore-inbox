Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273993AbRIXQe0>; Mon, 24 Sep 2001 12:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273992AbRIXQeQ>; Mon, 24 Sep 2001 12:34:16 -0400
Received: from air-1.osdlab.org ([65.201.151.5]:45576 "EHLO
	osdlab.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S273993AbRIXQeO>; Mon, 24 Sep 2001 12:34:14 -0400
Message-ID: <3BAF6016.243D5185@osdlab.org>
Date: Mon, 24 Sep 2001 09:32:22 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Crutcher Dunnavant <crutcher@datastacks.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Magic SysRq alternate fix register functions
In-Reply-To: <E15k86n-0005lE-00@the-village.bc.nu> <3BAA3C17.557A2C4E@osdlab.org> <20010921182207.M8188@mueller.datastacks.com> <20010921183608.N8188@mueller.datastacks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Crutcher Dunnavant wrote:
> 
> ++ 21/09/01 18:22 -0400 - Crutcher Dunnavant:
> > I'm not sure if this is sufficient. The low level interfaces need to be
> > exposed, and if we are not expecting modules to pay attention to the
> > CONFIG_MAGIC_SYSRQ setting, then the all of these interfaces need to be
> > overridden.
> >
> > However, do we even need this #ifdef CONFIG_MAGIC_SYSRQ block at all?
> > What does it matter if modules register or unregister events, if they
> > cannot be called?
> >
> > The old code only zaped the enable if sysrq was not defined, and that is
> > what I'm doing in the table. Some real changes would be neccessary to
> > actually drop out the whole system.
> >
> > There is also no real reason to try and no-op these functions for speed,
> > as they are trivial and FAR outside of the main call path.
> >
> > So the way to go I see here is:
> >  a) allow the registration functions to always be defined.
> > and either:
> >  b) handle the return failure in the __sysrq_XXX functions themselves,
> >  c) or not.
> 
> A 'dont-close-it' patch is attached.
> 
>   ----------------------------------------------------------------------
>  Name: patch-2.4.10-pre13-sysrq_register
>  patch-2.4.10-pre13-sysrq_register       Type: Plain Text (text/plain)
>  Description: patch-2.4.10-pre13-sysrq_register

Yep, that certainly fixes the API when CONFIG_MAGIC_SYSRQ
is not defined, which is what I wanted to see.

~Randy
