Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263911AbTDNUXf (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 16:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263928AbTDNUXe (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 16:23:34 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263911AbTDNUXc (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 16:23:32 -0400
Date: Mon, 14 Apr 2003 13:33:54 -0500 (CDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Martin Hicks <mort@wildopensource.com>, <hpa@zytor.com>, <pavel@ucw.cz>,
       <jes@wildopensource.com>, <linux-kernel@vger.kernel.org>,
       <wildos@sgi.com>
Subject: Re: [patch] printk subsystems
In-Reply-To: <20030408161010.25de9e09.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.44.0304141325010.14087-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't like the #define DEBUG approach.  It's useless for users; it's a
> developer debug tool.  It won't allow some support staff to ask users to
> enable module debugging (or subsystem debugging) and see what gets printed.

Agreed. Having a runtime-tweakable field would be very handy, and 
something that's been requested many times over. 

> Martin, you are ahead of my schedule, but I was planning to use sysfs
> to add a 'debug' flag/file that could be dynamically altered on a per-module
> basis.

Something I've pondered in the past is a per-subsystem (as in struct 
subsystem) debug field and log buffer. When the subsystem is registered, a 
sysfs 'debug' file is created, from which the user can set the noisiness 
level. 

>From there, each subsystem can specify the size of a log buffer, which 
would be allocated also when the subsystem is registered. Messages from 
the subsystem, and kobjects belonging to it, would be copied into the 
local log buffer. 

Wrapper functions can be created, similar to the dev_* functions, which 
take a kobject as the first parameter. From this, the subsystem and log 
buffer, can be derived (or rather, passed to a lower-level helper). 

This all falls under the 'gee-whiz-this-might-be-neat' category, and may
inherently suck; I haven't tried it. Doing the core code is < 1 day's
work, though there would be nothing that actually used it..


	-pat

