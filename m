Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316600AbSGBEEv>; Tue, 2 Jul 2002 00:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316606AbSGBEEu>; Tue, 2 Jul 2002 00:04:50 -0400
Received: from OL65-148.fibertel.com.ar ([24.232.148.65]:26581 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S316600AbSGBEEu>;
	Tue, 2 Jul 2002 00:04:50 -0400
Date: Tue, 2 Jul 2002 01:11:56 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RE2: [OKS] Module removal
Message-ID: <20020702011156.E2295@almesberger.net>
References: <20020702001152.D2295@almesberger.net> <31775.1025581336@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31775.1025581336@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Tue, Jul 02, 2002 at 01:42:16PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> Incrementing the use count at registration time is no good, it stops
> the module being unloaded.  Operations are deregistered at rmmod time.
> Setting the use count at registration prevents rmmod from removing the
> module, so you cannot deregister the operations.  Catch 22.

But those references go through the module exit function, which
acts like an implicit reference counter. So as long as

 - module exit de-registers all of them (if it doesn't, we're
   screwed anyhow), and
 - the registry itself isn't racy (if it is, this is likely to
   surface in other circumstances too, e.g. if a driver destroys
   internal state immediately after de-registration)

they should be safe, shouldn't they ?

- Werner

P.S. mail.ocs.com.au thinks I'm a spammer :-(

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://icapeople.epfl.ch/almesber/_____________________________________/
