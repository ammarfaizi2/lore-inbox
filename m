Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271575AbTGRJyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271564AbTGRJsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:48:04 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:30724 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S271575AbTGRJeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:34:17 -0400
Date: Fri, 18 Jul 2003 11:48:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: Jeff Garzik <jgarzik@pobox.com>, <schlicht@uni-mannheim.de>,
       <ricardo.b@zmail.pt>, <linux-kernel@vger.kernel.org>
Subject: Re: SET_MODULE_OWNER
In-Reply-To: <20030717131902.76c68c56.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0307181121010.717-100000@serv>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
 <3F16C190.3080205@pobox.com> <200307171756.19826.schlicht@uni-mannheim.de>
 <3F16C83A.2010303@pobox.com> <20030717125942.7fab1141.davem@redhat.com>
 <3F170589.50005@pobox.com> <20030717131902.76c68c56.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 17 Jul 2003, David S. Miller wrote:

> People who do modprobe -r in their crontabs are asking
> for trouble, losing their netdevice is the least of their
> trouble especially if they have firewall rules installed.
> 
> Module reference counting added complications to net device
> handling, and once I killed it off we could begin addressing
> all of the real bugs that exist with network devices.  For example,
> now that we're foreced to make net devices dynamic memory in all
> cases we can deal with dangling procfs/sysfs references to the device
> sanely.  Fixing that was not possible with module refcounting.

I wouldn't say impossible, but definitively not nice.
OTOH a usage indicator is useful and the network driver knows if one of 
its devices is in use, but the module count is the only way to tell this 
to module code and there is currently no sane way to have a use count and 
force the removal of a module.
The network device cleanup is without doubt needed, but I would have 
prefered to accompany it with module layer cleanup. The current module 
code continues a lot of the old design mistakes.

bye, Roman

