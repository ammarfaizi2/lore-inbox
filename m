Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965008AbWGKHXL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965008AbWGKHXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWGKHXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:23:11 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:9759 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965008AbWGKHXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:23:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=UYsurd1yzqEy2xy7yODi/d/4mxsIww0sdK/OcFIVtI8BegqPbqyiAV0qoO3MM68KAHqXEUli6C4olJWFl8ixDtl31JsDmt3NP1vCiU2u6TzNj9+h4uVOU07TgB0InHb0CbSy0z/y0ebEPR4tObZSdGAG0vYQYnoqz6vjs6zSips=
Message-ID: <44B351CF.1090001@pol.net>
Date: Tue, 11 Jul 2006 15:22:55 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: "Antonino A. Daplas" <adaplas@gmail.com>,
       Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org>	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>	<m3u05p4mkx.fsf@defiant.localdomain> <44B26004.4050500@gmail.com>	<m3r70tqxmt.fsf@defiant.localdomain> <44B2808F.8000901@pol.net> <m3ac7h6vxy.fsf@defiant.localdomain>
In-Reply-To: <m3ac7h6vxy.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> "Antonino A. Daplas" <adaplas@pol.net> writes:
> 
>> This is no-man's land.  Basically X grabs the VT with KD_GRAPHICS mode
>> set.  When in KD_GRAPHICS mode, the framebuffer console will not
>> send any commands to the drivers. The problem is trying to do
>> framebuffer operation while in X, we don't have any guards on that.
>> Just try fbset mymode while in X.
> 
> You mean it will not bomb?

If you pray hard enough and you do the operation while in a VC, no it
won't :-). But it's almost guaranteed to bomb if you do the framebuffer
operations while in X.

> Good, but still there is I2C question
> - can I2C accesses to the graphics chip corrupt X11 and vice versa?

That I don't know, but I doubt it.

> I can't see anything preventing that, and while we can disable
> graphic operations while Xserver is running, we can't disable I2C
> (non-DDC).

No, there's nothing to prevent simultaneous access.

> 
> Probably X11 should be disallowed to use I2C directly? I should
> probably Cc: this to XOrg as well...

X has its own i2c functionality which is completely separate from the
kernel i2c layer.

Tony
