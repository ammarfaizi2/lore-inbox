Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWGJMdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWGJMdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 08:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWGJMdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 08:33:21 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:19307 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964983AbWGJMdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 08:33:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=dLho6Dxp5m79xPtxujBTIBtF2bUe8Jl0XNbeo+xMDKHKB+vJ70TTZk9dtGzrxTGfvOdNHOvCG8Iw+2S17IU7Aqy97hPfwGp+DOKgFMfokwPPUSZesOcLHpr2q8WhuQddNGHc1FKKsHb0UFPkqnl7rZ6Gtufvq9jtN7BACCSa0t8=
Message-ID: <44B248E4.2020506@pol.net>
Date: Mon, 10 Jul 2006 20:32:36 +0800
From: "Antonino A. Daplas" <adaplas@pol.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Jean Delvare <khali@linux-fr.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>	<20060705165255.ab7f1b83.khali@linux-fr.org>	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net> <m3ejwt65of.fsf@defiant.localdomain>
In-Reply-To: <m3ejwt65of.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> "Antonino A. Daplas" <adaplas@pol.net> writes:
> 
>>> Feel free to add another patch, while I don't see a need I have nothing
>>> against :-)
>> No, you fix the patch.
> 
> Look, I don't feel my patch needs such "fix". So if you think it does,
> you have to do it.

Eventually, I'm the one who's going to maintain the code, most
of the drivers in the video directory are practically abandoned. 
Additionally, this is mentioned in Documentation/CodingStyle.

2) #ifdefs are ugly

Code cluttered with ifdefs is difficult to read and maintain.  Don't do
it.  Instead, put your ifdefs in a header, and conditionally define
'static inline' functions, or macros, which are used in the code.
Let the compiler optimize away the "no-op" case.

Simple example, of poor code:

	dev = alloc_etherdev (sizeof(struct funky_private));
	if (!dev)
		return -ENODEV;
	#ifdef CONFIG_NET_FUNKINESS
	init_funky_net(dev);
	#endif

> 
>> And while your at it, check your Kconfig
>> dependencies, ie check for impossible combinations such as CONFIG_I2C=m,
>> CONFIG_FB_CIRRUS=y.
> 
> You're right here, I don't know why I assumed DEPENDS does it
> automatically.

Use select.

Tony
