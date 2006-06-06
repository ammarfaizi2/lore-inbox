Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWFFWMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWFFWMW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWFFWMW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:12:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32662 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751139AbWFFWMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:12:21 -0400
Date: Tue, 6 Jun 2006 15:12:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] Detaching fbcon: Add capability to attach/detach
 fbcon
Message-Id: <20060606151210.22751bce.akpm@osdl.org>
In-Reply-To: <4485624C.9070707@gmail.com>
References: <4485624C.9070707@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jun 2006 19:09:00 +0800
"Antonino A. Daplas" <adaplas@gmail.com> wrote:

> Add the ability to detach and attach the framebuffer console to and from
> the vt layer. This is done by echo'ing any value to sysfs attributes located
> in class/graphics/fbcon. The two attributes are:
> 
>       attach - bind fbcon to the vt layer
>       detach - unbind fbcon from the vt layer

That's a bit unusual.  Normally a bind or unbind operation will operate
primarily upon the thing which is bound to, not upon the thing which is
bound.

I assume it makes sense this way, given the way the vt layer operates.  But
it rather rules out binding the fbcon layer to anything apart from the vt
layer (just thinking about it design-wise).

ummm, expressing it differently:

	echo "bind fbcon" > /sys/whatever/some-vt-file
	echo "unbind fbcon" > /sys/whatever/some-vt-file

would be more typical usage.

> Once fbcon is detached from the vt layer, fbcon can be unloaded if compiled as
> a module. This feature is quite useful for developers who work on the
> framebuffer or console subsystem. This is also useful for users who want to
> go to text mode or graphics mode without having to reboot.

Do we have a place where this can be documented?

> Directly unloading the fbcon module is not possible because the vt layer
> increments the module reference count for all bound consoles.  Detaching fbcon
> decrements the module reference count to zero so unloading becomes possible.

Right.  So the vt layer should be told to let go of the fbcon layer.  It's
a vt operation, not an fbcon one, yes?
