Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262405AbVCDOxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262405AbVCDOxz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVCDOxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 09:53:55 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:60010 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262405AbVCDOwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 09:52:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=e4toO7kWEA++VIGZNuBfCYac+G2XjMV+YH1iInZeefu4m7Mor6t9aJrA2Ojp5QbRrGbf7dJiK+m6ImGzKExMAtesPcJAZiQ4oJtKyayvgzFUpVDpGmAhAVximQyxNOsZLjYaXZWIL0M3rcVfoEI36pY4plFSiMygRbkgozUegjE=
Message-ID: <d120d50005030406525896b6cb@mail.gmail.com>
Date: Fri, 4 Mar 2005 09:52:42 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alexey Dobriyan <adobriyan@mail.ru>
Subject: Re: [PATCH] new driver for ITM Touch touchscreen
Cc: Hans-Christian Egtvedt <hc@mivu.no>, linux-kernel@vger.kernel.org
In-Reply-To: <200503041403.37137.adobriyan@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1109932223.5453.16.camel@charlie.itk.ntnu.no>
	 <200503041403.37137.adobriyan@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Mar 2005 14:03:37 +0200, Alexey Dobriyan <adobriyan@mail.ru> wrote:
> On Friday 04 March 2005 12:30, Hans-Christian Egtvedt wrote:
> 
> > I've ported the works from Chris Collins so the drivers compiles without
> > warnings and works (for me) with Linux 2.6.10 and 2.6.11.
> 
> > Any comments on the driver would be much appreciated.
> 
> > +struct itmtouch_dev {
> 
> > +       int                     refcount; //
> 
> There is already generic interface for reference-counted objects. See
> lib/kref.c and kref documentation at:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110987233406767&w=2
> 

... which is absolutely unusable for this particular purpose - the
touchscreen object is not going away when refcount is 0. The variable
shoudl be renamed to "users" or something. Moreover it needs locking.

Anyway, all of this will be handled by the input core very shortly so
it can be left as is for now.

As far as the driver goes:

- yes, it does need input_sync;
- I prefer using input_set_abs_params instead of setting mix, max,
flat and fuzz for each axis manually;
- I believe "/* .. */" is preferred over "//"
- kill the commented out bad prototypes.

Also, is there a way to query the screen for actual size?

-- 
Dmitry
