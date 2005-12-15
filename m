Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbVLPCYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVLPCYR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:24:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVLPCYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:24:17 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:19056 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751287AbVLPCYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:24:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=R7A6yyK5gcrsv2SHW6xWN9unZ0jGaHuwsPl5e16su5T14mebJ/517xiujdebm9vPusSa0UjfTwIJ9st5bLupucIfUs1Alvs/uvNggY7QzDNBWkSAvtAoCtd9WwWdeKAvMiFQB530xTVQhKQGBhQXnzl6oHYVebrceRwgSVaAP5Q=
Message-ID: <43A11E89.2090805@gmail.com>
Date: Thu, 15 Dec 2005 15:43:05 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Kurt Wall <kwallinator@gmail.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Console Goes Blank When Booting 2.6.15-rc5
References: <200512132247.54341.kwallinator@gmail.com> <439FBDC5.5060609@gmail.com> <200512142027.00829.kwallinator@gmail.com>
In-Reply-To: <200512142027.00829.kwallinator@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Wall wrote:
> On Wednesday 14 December 2005 01:37 am, Antonino A. Daplas wrote:
>> Kurt Wall wrote:
>>> As Jesper Juhl has reported, if I boot 2.6.15-rc5 with vga=normal,
>>> everything is fine. If I boot using my preferred size (vga=794),
>>> the console goes blank. Because I'm a touch typist, I can login and
>>> start X and everything is copacetic, but as soon as I leave X, I'm
>>> back to the blank screen. From X, if I flip over to a VC, the VC
>>> display is garbled and has artifacts from the X display.
>>>
>>> This worked fine with 2.6.14.3, and I didn't change the console,
>>> framebuffer, or vesa options between the two kernels. Not sure how
>>> to proceed, but I sure would like my high res console screens back.
>> Can you recheck your .config and make sure that
>> CONFIG_FRAMEBUFFER_CONSOLE=y
> 
> Oops. It was defined as a module. Compiling it statically gave me
> the console back. Interestingly, I still lose the first 102 lines
> of console output. After the all-important boot logo displays, I see
> nothing until this line:

Yes, that should be expected behavior with vesafb.  The adapter was
set very early during the boot process, when machine is still in
real mode, vgacon will never load, and you will only see any semblance
of display until the framebuffer console is loaded.  You should
see different behavior with chipset-specific drivers, ie, you will
have vgacon momentarily until fbcon takes over.

Tony
