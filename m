Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWFFXRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWFFXRj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 19:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWFFXRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 19:17:39 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:3187 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751346AbWFFXRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 19:17:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=aijxNOsF+A8h50oZfpUj4ff2kAAEwQa6xc4ECUhiMQZ+j9jv3YV2vNFQtajVi4ATAAnurImX8AVcdx8Ce343mPOZSvROu2e/gwcF7Hm3bhUFzT7bVGJDiKBfqyqbMewZWlUP3iGYZrE/fh3rnuIRRG7eSfgPxTn5eEdvrT4ov+s=
Message-ID: <44860CFA.4040409@gmail.com>
Date: Wed, 07 Jun 2006 07:17:14 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Detaching fbcon: Add capability to attach/detach
 fbcon
References: <4485624C.9070707@gmail.com> <20060606151210.22751bce.akpm@osdl.org>
In-Reply-To: <20060606151210.22751bce.akpm@osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 06 Jun 2006 19:09:00 +0800
> "Antonino A. Daplas" <adaplas@gmail.com> wrote:
> 
>> Add the ability to detach and attach the framebuffer console to and from
>> the vt layer. This is done by echo'ing any value to sysfs attributes located
>> in class/graphics/fbcon. The two attributes are:
>>
>>       attach - bind fbcon to the vt layer
>>       detach - unbind fbcon from the vt layer
> 
> That's a bit unusual.  Normally a bind or unbind operation will operate
> primarily upon the thing which is bound to, not upon the thing which is
> bound.

I'm not against this.

> 
> I assume it makes sense this way, given the way the vt layer operates.  But
> it rather rules out binding the fbcon layer to anything apart from the vt
> layer (just thinking about it design-wise).

The vt-layer is different in that the device themselves bind to it, not
the other way around.  As I've told Jon, if someone change the vt-layer so
it behaves in a standard way, I'm all for it (that someone is probably me).

But thinking about it, it is probably not very difficult to change the
vt-layer.  We just make the vt-layer keep a list of registered drivers. And 
we already have /sys/class/tty/console, so I can put the attribute there
for bind and unbind.

> 
> ummm, expressing it differently:
> 
> 	echo "bind fbcon" > /sys/whatever/some-vt-file
> 	echo "unbind fbcon" > /sys/whatever/some-vt-file
> 
> would be more typical usage.
> 
>> Once fbcon is detached from the vt layer, fbcon can be unloaded if compiled as
>> a module. This feature is quite useful for developers who work on the
>> framebuffer or console subsystem. This is also useful for users who want to
>> go to text mode or graphics mode without having to reboot.
> 
> Do we have a place where this can be documented?

In Documentation/fb/fbcon.txt.

> 
>> Directly unloading the fbcon module is not possible because the vt layer
>> increments the module reference count for all bound consoles.  Detaching fbcon
>> decrements the module reference count to zero so unloading becomes possible.
> 
> Right.  So the vt layer should be told to let go of the fbcon layer.  It's
> a vt operation, not an fbcon one, yes?

Yes. I'll take a stab at doing it this way. 

Tony
 


