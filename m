Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWJMSMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWJMSMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWJMSMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:12:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:58571 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751781AbWJMSMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:12:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ug3WR8Hw8aJVp5r/nPZigpWLGYb1OghtLdl1RhzM5pU4wahYR6HDh4f7s7M5V7p7dfGiUQa6rc8Zu2vOv9OdnLsK8zjQFwutZhtDI1XNkoayq26wb6eYo1BiAKnJatijBrEQc/iC6zsu5VdjHnuG9u30piyuzyu5DRUWXMVKW/w=
Message-ID: <961aa3350610131112l141b782ey281e068116411cbf@mail.gmail.com>
Date: Sat, 14 Oct 2006 03:12:23 +0900
From: "Akinobu Mita" <akinobu.mita@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [patch 7/7] stacktrace filtering for fault-injection capabilities
Cc: linux-kernel@vger.kernel.org, ak@suse.de, "Don Mullis" <dwm@meer.net>,
       Valdis.Kletnieks@vt.edu
In-Reply-To: <20061013180039.GD29079@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061012074305.047696736@gmail.com>
	 <452df23e.44ca1e09.1a7f.780f@mx.google.com>
	 <20061012142004.a111ca6a.akpm@osdl.org>
	 <20061013180039.GD29079@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/10/14, Akinobu Mita <akinobu.mita@gmail.com>:

> > > --- work-fault-inject.orig/lib/Kconfig.debug
> > > +++ work-fault-inject/lib/Kconfig.debug
> > > @@ -472,6 +472,8 @@ config LKDTM
> > >
> > >  config FAULT_INJECTION
> > >     bool
> > > +   select STACKTRACE
> > > +   select FRAME_POINTER
> > >
> > >  config FAILSLAB
> > >     bool "fault-injection capabilitiy for kmalloc"
> > >
> >
> > Is the selection of FRAME_POINTER really needed?  The fancy new unwinder
> > is supposed to be able to handle frame-pointerless unwinding?
>
> As I wrote in another reply, There are two type of implementation of
> this stacktrace filter.
>
> - using STACKTRACE + FRAME_POINTER
> - using new unwinder (STACK_UNWIND)
>
> The stacktrace with using new unwinder without FRAME_POINTER is much
> slower than STACKTRACE + FRAME_POINTER.
>

Maybe I should drop new unwinder support for now.
