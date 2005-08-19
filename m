Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbVHSFAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbVHSFAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 01:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVHSFAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 01:00:36 -0400
Received: from [85.8.12.41] ([85.8.12.41]:14996 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932403AbVHSFAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 01:00:35 -0400
Message-ID: <4305676E.5080401@drzeus.cx>
Date: Fri, 19 Aug 2005 07:00:30 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: Multi-sector writes
References: <42FF3C05.70606@drzeus.cx> <20050817155641.12bb20fc.akpm@osdl.org> <43042114.7010503@drzeus.cx> <20050817224805.17f29cfb.akpm@osdl.org> <20050818073824.C2365@flint.arm.linux.org.uk> <4304380B.5070406@drzeus.cx> <20050818092321.B3966@flint.arm.linux.org.uk> <43044B7A.6090102@drzeus.cx> <20050818201919.GD516@openzaurus.ucw.cz>
In-Reply-To: <20050818201919.GD516@openzaurus.ucw.cz>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>>* Transport problem. The driver will report back a CRC error, timeout or
>>whatnot and break. We might not know how many sectors survived so we try
>>again, going sector-by-sector. We might get a transfer error again,
>>possibly even before the previous one. But at this point the transport
>>is probably so noisy that we have little chans of doing a clean umount
>>anyway. So when the device gets fixed, either by replaying the journal
>>    
>>
>
>Well, but then you can get:
>
>good data #1
>trash #2
>good data #2
>trash #1
>
>I'm not sure how much journalling filesystems will like that in their journals...
>
>  
>

Unless the card is horribly broken it will not write sectors that cannot
be transfered successfully. If there would be a transport error that
goes undetected by the CRC we would just continue, believing that
everything is peachy.

The scenario you're describing could show up in the case of a media
error though. But that would mean that a sector went bad in an extremely
short time, which isn't likely unless the wear leveling has gone crazy
or the card is completely worn out. Either way the card is no longer useful.

Rgds
Pierre

