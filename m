Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVCNXaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVCNXaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 18:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVCNXaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 18:30:12 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:44749 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262078AbVCNX3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 18:29:23 -0500
Message-ID: <42361E33.4020903@ens-lyon.org>
Date: Tue, 15 Mar 2005 00:28:51 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: AGP module removal impossible ?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

I can't remove the AGP chipset module on my boxes.
Looks like the AGP chipset driver holds a reference on itself and
thus makes removal impossible.

 From what I understand, as soon as intel_agp is loaded, agp_intel_probe
is called. It gets a reference on intel_agp module through
!try_module_get(bridge->driver->owner) in agp_add_bridge.
Then this reference can only be released through module_put in
agp_remove_bridge which is called agp_intel_remove which is only called
when removing the module.

Thus it looks impossible to remove this module at all.
And I think the problem occurs with all other AGP chipset drivers.

I hope the reason is not just that module removal support is not important
in 2.6 :) It looks strange to implement a module removal routine if we
know it can't be used :)

Regards,
Brice Goglin
