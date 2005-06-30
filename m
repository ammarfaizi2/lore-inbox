Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262817AbVF3HxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbVF3HxL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 03:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbVF3HxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 03:53:10 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:16688 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262817AbVF3HxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 03:53:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=SPr3U0QQRtdJ4+jsDAC/5p91J8bML/wQj3xbEAs2MLgBBbVyMx8GFa07OA18B2Rce7/o0C34l5b72RatsdtbaJjl20SSx02BRxb81ZJrFeEz9hz8wLFfFaIash4nV8ASppFTk+sz04DyHcDMzhCpYRuqWA6f4diEP4bzHoUIpfw=
Subject: Re: psmouse sysfs problems
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1120114623.15195.6.camel@blight.blightgroup>
References: <1120057685.31934.36.camel@blight.blightgroup>
	 <200506291507.28015.dtor_core@ameritech.net>
	 <1120114623.15195.6.camel@blight.blightgroup>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:49:47 +0200
Message-Id: <1120117787.15470.1.camel@blight.blightgroup>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Il giorno mer, 29/06/2005 alle 15.07 -0500, Dmitry Torokhov ha
> scritto: 
> > On Wednesday 29 June 2005 10:08, Hetfield wrote:
> > > pwd
> > > /sys/bus/serio/devices/serio0
> > > root@blight serio0 # cat protocol
> > > ImPS/2
> > > root@blight serio0 # cat resetafter
> > > 0
> > > root@blight serio0 # echo 5 > res
> > > resetafter  resolution
> > > root@blight serio0 # echo 5 > resetafter
> > > root@blight serio0 # cat resetafter
> > > 0
> > > root@blight serio0 #            
> > > 
> > > and sending 0, 1, 2 to protocol changed nothing.
> > > same for resolution.
> > > i needed that feature to switch from synaptics to imps protocol and
> > > back.
> > > 
> > > i'm using 2.6.12-git10.
> > > 
> > > what should i do?
> > >
> > 
> > Hi,
> > 
> > try this:
> > 
> >     echo -n "imps" > /sys/bus/serio/devices/serioX/protocol
> >     echo -n "auto" > /sys/bus/serio/devices/serioX/protocol
> > 
> > psmouse (and serio core in general) does not like exta characters (like
> > newline) in requests and discards such requests.
> > 
> 

thanks it seems working on my desktop, i'll try on my notebook too.

the problem is that plugging a imps2 mouse to notebook doesn't work with
synaptics touchpad.
i needed to unload psmouse module and reload with proto=imps

in win drivers (sorry!) i see that as soon as i plug the mouse, driver
intercept it and says
that synaptics advanced features will be disabled.
when i unplug the mouse i get this features back.
i'd like linux to do the same thing automatically, i'll play with
protocol auto and resetafter values 

I'll report my test results

