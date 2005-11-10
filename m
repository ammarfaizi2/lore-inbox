Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVKJQH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVKJQH4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVKJQH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:07:56 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:61193 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751101AbVKJQHz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:07:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=IQhBD6tcH6PJNIGgWOb7CfDxAZrwE53c5toBatjOlTFoGvSOhyzXd1cQkloASVLl9rvZkdY7QaV79diMyj1+u0mO8R8ioNgavLbQyUzchF9Hlh31wCoSv1BkRk452mpbay9QaWWYwMeQhVqSdqBIeWyXzdnD5ymS/LlsUCoU8kM=
From: Bruce Korb <bruce.korb@gmail.com>
Organization: At Home
To: Valdis.Kletnieks@vt.edu
Subject: Re: missing build functionality?
Date: Thu, 10 Nov 2005 08:07:53 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200411232102.iANL2H5T025781@turing-police.cc.vt.edu>
In-Reply-To: <200411232102.iANL2H5T025781@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511100807.53219.bruce.korb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 01:02 pm, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 23 Nov 2004 12:33:39 PST, Bruce Korb said:
> 
> > Anyway, I do not see an obvious way to construct an object archive library
> > that I wish to use for multiple drivers.  There are two problems.  This:
> > 
> > > ifeq ($(ARCH),ia64) 
> > > 	CFLAGS_KERNEL = 
> > > endif
> > 
> > because I am making the archive for a loadable driver. 
> 
> The usual solution for 2 modules that share an archive would be to create
> *three* modules driver-a, driver-b, and driver-core - and then have the
> appropriate depmod magic so a 'modprobe driver-a' does an insmode
> driver-core,
> as does a 'modprobe driver-b'.
> 
> Otherwise, you're just loading the entire library into memory twice,
> once for each driver...

If the library is actually a glue layer that smooths out the differences
between kernel API's, then that is exactly what I want to do.  There
is not a substantial amount of functionality.  In fact, it is mostly
macros.  The key word being, "mostly".  There is enough code in what
is not done in macros that it should not be compiled with every driver,
but not so much that it is worth making a separate driver library driver.  :)

So, it would still be very useful to know how to link against a "libmumble.a"
file built in another directory.  Copying all sources and libraries into
a build directory before kicking off the build is kludgey.  (Linux being the
only platform where that seems to be necessary.)

Thanks - Bruce
