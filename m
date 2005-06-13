Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbVFMWDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbVFMWDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFMWAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:00:48 -0400
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:12667 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261490AbVFMV6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 17:58:44 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Input sysbsystema and hotplug
Date: Mon, 13 Jun 2005 16:58:36 -0500
User-Agent: KMail/1.8.1
Cc: linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Hannes Reinecke <hare@suse.de>, Andrew Morton <akpm@osdl.org>
References: <200506131607.51736.dtor_core@ameritech.net> <20050613212654.GB11182@vrfy.org>
In-Reply-To: <20050613212654.GB11182@vrfy.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506131658.37583.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 16:26, Kay Sievers wrote:
> On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > I am trying to convert input systsem to play nicely with sysfs and I am
> > having trouble with hotplug agent. The old hotplug mechanism was using
> > "input" as agent/subsystem name, unfortunately I can't simply use "input"
> > class because when Greg added class_simple support to input handlers
> > (evdev, mousedev, joydev, etc) he used that name. So currently stock
> > kernel gets 2 types of hotplug events (from input core and from input
> > handlers) with completely different arguments processed by the same
> > input agent.
> > 
> > So I guess my question is: is there anyone who uses hotplug events
> > for input interface devices (as in mouseX, eventX) as opposed to
> > parent input devices (inputX).
> 
> Hmm, udev uses it. But, who needs device nodes. :)
> 

Oh, OK. Damn, Andrew will hate us for breaking mouse support yet again :(
because there are people (like me) relying on hotplug to load input handlers.
First time I booted by new input hotplug kernel I lost my mouse.

I wonder should we hack something allowing overriding subsystem name
so we could keep the same hotplug agent? Or should we bite teh bullet and
change it?

Adding Andrew to CC... 

> > If not then I could rename Greg's class
> > to "input_dev" and my new class to "input" and that will be compatible
> > with older installations. 
> 
> I still think we should rename the parent-input device class and keep
> the more interesting class named "input", cause this will not break current
> setups besides one hotplug-handler and follows the usual style in sysfs.

-- 
Dmitry
