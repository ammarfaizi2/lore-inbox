Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTDOTk6 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 15:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTDOTk6 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 15:40:58 -0400
Received: from mta6.snfc21.pbi.net ([206.13.28.240]:16007 "EHLO
	mta6.snfc21.pbi.net") by vger.kernel.org with ESMTP id S264052AbTDOTkx 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 15:40:53 -0400
Date: Tue, 15 Apr 2003 12:59:23 -0700
From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] /sbin/hotplug multiplexor
To: Robert Love <rml@tech9.net>, "Kevin P. Fleming" <kpfleming@cox.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <3E9C649B.8080106@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20030414190032.GA4459@kroah.com>
 <200304142209.56506.oliver@neukum.org> <20030414203328.GA5191@kroah.com>
 <200304142311.01245.oliver@neukum.org> <3E9B2720.7020803@cox.net>
 <1050356754.3664.82.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 2003-04-14 at 17:24, Kevin P. Fleming wrote:
>>Personally, this is one reason why I'd much rather see a daemon-based model 
>>where each interested daemon can "subscribe" to the messages it is interested 
>>in. It's very possible (and likely, i.e. udev) that the steps involved for the 
>>daemon to respond to the hotplug event are so lightweight that creating a 
>>subprocess to handle them would be very wasteful.

Historically, one of the motivations for the /sbin/hotplug
approach was to avoid the costs of running Yet Another Daemon
that's idle almost all the time ... and all it'd do when it
learns about a new device is fork an easily-customized shell
script, which normally loads driver modules and runs device
setup scripts.  (Modprobe does per-driver scripts, which are
no good for per-device actions, and needs a config file.)

Cheaper all around to have the kernel do that; plus, it had
information that was not otherwise available to daemons.
Much easier to adopt and evolve shell scripts, too.

That is, the design center was for medium-weight events that
always involve starting new processes, and which moreover
tend not to run often.  How often do you connect a new USB or
PCI device?  If it takes a full second to react, that's OK;
and Linux is usually faster than that.  (Windows isn't! :)

I'd certainly agree that some hotplug agents need to be
talking with daemons.  But I've always thought of them as
being application-specific ... tell the print server about
a new printer, for example.  And what you need to tell that
server seems unlikely to be what you'd tell something that's
sampling your collection of video or audio streams.


Robert Love wrote:
> See http://www.freedesktop.org/software/dbus/

Looks interesting.

- Dave



