Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVF3Jpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVF3Jpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262916AbVF3Jpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:45:54 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:21349 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262914AbVF3Jpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:45:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=n6eWcI8AgvwtaTtpu5/mQ76Kb2Uvb471nsTGRP1bL1vA6ssysaOfAcSFIshcxHmP/o2qJxOlcSqJXOpq7qc+QpFY99V1BavD0mzECL0f/099TYaA366ZH4/w1iYWb9nWsiTE8Z14PKNfD1UxikfwhR+DwsnEuhDM+59ZxVWM7wA=
Subject: Re: psmouse sysfs problems
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1120117787.15470.1.camel@blight.blightgroup>
References: <1120057685.31934.36.camel@blight.blightgroup>
	 <200506291507.28015.dtor_core@ameritech.net>
	 <1120114623.15195.6.camel@blight.blightgroup>
	 <1120117787.15470.1.camel@blight.blightgroup>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 11:43:30 +0200
Message-Id: <1120124611.15470.17.camel@blight.blightgroup>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno gio, 30/06/2005 alle 09.53 +0200, Hetfield ha scritto:
> > Il giorno mer, 29/06/2005 alle 15.07 -0500, Dmitry Torokhov ha
> > scritto: 
> > > On Wednesday 29 June 2005 10:08, Hetfield wrote:
> > > > pwd
> > > > /sys/bus/serio/devices/serio0
> > > > root@blight serio0 # cat protocol
> > > > ImPS/2
> > > > root@blight serio0 # cat resetafter
> > > > 0
> > > > root@blight serio0 # echo 5 > res
> > > > resetafter  resolution
> > > > root@blight serio0 # echo 5 > resetafter
> > > > root@blight serio0 # cat resetafter
> > > > 0
> > > > root@blight serio0 #            
> > > > 
> > > > and sending 0, 1, 2 to protocol changed nothing.
> > > > same for resolution.
> > > > i needed that feature to switch from synaptics to imps protocol and
> > > > back.
> > > > 
> > > > i'm using 2.6.12-git10.
> > > > 
> > > > what should i do?
> > > >
> > > 
> > > Hi,
> > > 
> > > try this:
> > > 
> > >     echo -n "imps" > /sys/bus/serio/devices/serioX/protocol
> > >     echo -n "auto" > /sys/bus/serio/devices/serioX/protocol
> > > 
> > > psmouse (and serio core in general) does not like exta characters (like
> > > newline) in requests and discards such requests.
> > > 
> > 
> 
> thanks it seems working on my desktop, i'll try on my notebook too.
> 
> the problem is that plugging a imps2 mouse to notebook doesn't work with
> synaptics touchpad.
> i needed to unload psmouse module and reload with proto=imps
> 
> in win drivers (sorry!) i see that as soon as i plug the mouse, driver
> intercept it and says
> that synaptics advanced features will be disabled.
> when i unplug the mouse i get this features back.
> i'd like linux to do the same thing automatically, i'll play with
> protocol auto and resetafter values 
> 
> I'll report my test results


Here are results:
manual actions (i mean manual echo to protocol..): perfect

i tought resetafter param could restart the driver and set to a lower
protocol, but doesn't.
i see in dmesg that it only ask for resync after $resetafter value i
set.
using proto=auto, it always set synaptics protocol, even with plugged
mouse.

would be nice and automatic protocol up/down, maybe helped by resetafter
or another parameter 
for example:
"checkafter" that recheck configuration every xxx seconds and change
protocol.

Good /sys work however 

I'm ready to test any changement, just notice me.

