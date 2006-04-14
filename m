Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWDNXaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWDNXaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWDNXaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:30:20 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:17464 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751424AbWDNXaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:30:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DpfdayWJtZmVjRIwlM6AFaFm0zAjbwFag/uSp78mR0mQaCt0UaWd5Za/Jn+ETOow/3cS0urKcJ1OGBlLnj7MUOaYXetKMrQ5Ue4U5rnV/rKWjwLkVdU3RtGEHrF8wyJSa88gMxaeCARh2J4W+hCInGl4N7FVnQGPWy2UNj5+qxg=
Message-ID: <44403068.3020909@gmail.com>
Date: Sat, 15 Apr 2006 07:29:44 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [Linux-fbdev-devel] Behaviour change of /dev/fb0?
References: <1145009768.6179.7.camel@localhost.localdomain>
In-Reply-To: <1145009768.6179.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> Ignoring whether this is a good idea or not, under 2.6.15 you could run
> 
> dd if=/dev/zero of=/dev/fb0
> 
> which would clear the framebuffer. It would end up saying "dd: /dev/fb0:
> No space left on device".
> 
> Under 2.6.16 (and a recent git kernel), the same command clears the
> screen but then hangs. Was the change in behaviour intentional? 
> 
> I've noticed this on a couple of ARM based Zaurus handhelds under both
> w100fb and pxafb.
> 

There is a change in behavior of fb_read and fb_write committed Jan 2006.
They return the number of bytes read or written if the requested size
is bigger than the remaining space.  Previously, they returned -ENOSPC.

But I haven't experienced hangs...

Tony
