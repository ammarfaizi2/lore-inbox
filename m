Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262267AbVCBLc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVCBLc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCBLc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:32:59 -0500
Received: from webapps.arcom.com ([194.200.159.168]:781 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262267AbVCBLc4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:32:56 -0500
Message-ID: <4225A466.7030301@arcom.com>
Date: Wed, 02 Mar 2005 11:32:54 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] RFC: disallow modular framebuffers
References: <20050301024118.GF4021@stusta.de>
In-Reply-To: <20050301024118.GF4021@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Mar 2005 11:38:25.0515 (UTC) FILETIME=[588DA3B0:01C51F1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> Do modular framebuffers really make sense?

Yes.  e.g., on embedded systems you may not use the display hardware
(and would therefore like to save a bit of memory) but it's convenient
to have only one build of the kernel/modules.

> OK, distributions like to make everything modular, but all the 
> framebuffer drivers I've looked at parse driver specific options in 
> their *_setup function only in the non-modular case.

Not the (new) Geode framebuffer driver -- it uses regular module
parameters for this very reason.

> And most framebuffer drivers contain a module_exit function.
> Is there really any case where this is both reasonable and working?

It's useful for testing if nothing else.  True, the Geode framebuffer
driver won't restore the mode on unload but since the software VGA
emulation on a Geode is less than perfect[*] I would expect people to
not use vgacon and thus there's nothing really to restore.

David Vrabel

[*] I never did work out what happened to the cursor...
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
