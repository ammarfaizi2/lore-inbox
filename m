Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVKXHo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVKXHo4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 02:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVKXHo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 02:44:56 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:33232 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932562AbVKXHoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 02:44:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=NVwC7pE4JfeRxI+DEooWw8/psrxM3g6L5OBqxkodEUJsVhv5YPcLsLrpOouXjnY+fxRQq0dGaA779tnTGHxlR0WwpPjmw+krLofp/XLj4KrsbSQnH8uDhg+d52GwSWdauiUhT96M7JXtM708/qZgdF0MiU6gBTWw9Bz/0ppO6FQ=
Message-ID: <43856F3B.2090305@gmail.com>
Date: Thu, 24 Nov 2005 15:43:55 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Nathan Cline <nathan.cline@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch to framebuffer
References: <656113ee0511232208n6948c364ke6103b3ef0a54f@mail.gmail.com>
In-Reply-To: <656113ee0511232208n6948c364ke6103b3ef0a54f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Cline wrote:
> Hello, this is my first time posting to this list so please forgive me
> if I'm violating protocol in some way. :)  I've written a patch to the
> framebuffer code to modify its behavior a bit. I am running on a
> dual-headed system and I noticed when I was working in one console on
> one monitor, the console on the other monitor was "frozen", not
> updating itself. After some digging through the code I realized this
> is because the two framebuffer drivers share the same framebuffer code
> which stores a single pointer to the "current" virtual console. If a
> VC is not current it is considered invisible and is not updated. 

Yes, there is only 1 active console at one time.  And many multi-head
users has been asking (and confused) about this for some time now.

> So I
> patched the code to store a pointer for each framebuffer to the
> "foreground" VC on each one.

Well, you really don't need to store currcon_ptr in fbcon_ops.  Using
vc_cons[ops->currcon].d should be enough to get the current vc attached
to the framebuffer.  It will also make your patch smaller, and hopefully
easier to spot regressions.

> It seems to work well but I'd like to get
> others' input as this is my first time writing any kernel code, and to
> be honest there is so much code it's difficult to get a clear picture
> in my head of how the whole system works.

Yes, the console code is very confusing.  I have been looking at it for
a long time and I still don't know every code pathway it's going to take.

Anyway, with single-head systems, I can't really see your patch causing
regressions, so that's good.  With multi-head, I don't know.

Anyway, maybe Andrew can give this a whirl in the -mm tree?  Just resubmit
the patch without the currcon_ptr from fbcon_ops. And add a
Signed-off-by: line.  See:

http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Tony 
