Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269583AbTGOUD3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 16:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTGOUD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 16:03:28 -0400
Received: from mail.kroah.org ([65.200.24.183]:58321 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269583AbTGOUD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 16:03:27 -0400
Date: Tue, 15 Jul 2003 13:18:22 -0700
From: Greg KH <greg@kroah.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 - sysfs sensor nameing inconsistency
Message-ID: <20030715201822.GA5040@kroah.com>
References: <200307152214.38825.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307152214.38825.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 10:14:38PM +0400, Andrey Borzenkov wrote:
> In 2.4 all sensor chip got a subdirectory with name derived from type_name - a 
> single word describing sensor, like

And they used sysctl and proc, ugh, ugly :)

> adm1021.c:              type_name = "max1617";
> adm1021.c:              type_name = "max1617a";
> adm1021.c:              type_name = "adm1021";
> adm1021.c:              type_name = "adm1023";
> adm1021.c:              type_name = "thmc10";
> adm1021.c:              type_name = "lm84";
> adm1021.c:              type_name = "gl523sm";
> adm1021.c:              type_name = "mc1066";
> ...
> 
> etc. All user-level configuration (sensors, gkrellm) have been using these 
> names to match available sensors and configuration data.
> 
> In 2.6 sensors appear under /sysfs, type_name no more used and the only 
> identification available is .../name, but it seems to be arbitrary chosen 
> like
> 
> - single word ("it87") - lm87.c
> - "name chip" or "name subclient" - most others (lm78.c, wd83781d.c etc)
> - completely arbitrary shiny description - "Generic LM85", "National LM85-B" 
> etc in lm85.c
> 
> This means, any user program accessing sensors need incompatible changes and 
> comfiuration cannot be shared between 2.4 and 2.6 without serious redesign 
> and/or some translation layer.

The "translation layer" is libsensors.  libsensors needs to be rewritten
for 2.6.  The sensors people know this, and it's even detailed on their
web page.  Any help with this is greatly appreciated.

> If there are serious reasons to keep current names in "name" - what about 
> adding extra type_name property that will hold type_name compatible with 2.4, 
> at least for those drivers that are also available there. This would allow 
> easily reuse existing sensors configuration.

Patches to help do this are always welcome :)

thanks,

greg k-h
