Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWFKWEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWFKWEZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 18:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWFKWEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 18:04:25 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:8124 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750956AbWFKWEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 18:04:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=T0Ir9BC4heBjC0eCA3ykyz8NdFixxSpQ0waLkTQP2quls9/qUPbliXrbafGBf2BdEaDEggLhplNNzhwv9CZXT0BtXJyslmSHPfrxtQePfULaUhlxWhP2uUjH1u4IM1z9lpK9egsXs43gRvY4aVKCdZqp3Hof/tnVfC7PaxjJxL8=
Message-ID: <448C83AD.9060200@gmail.com>
Date: Mon, 12 Jun 2006 04:57:17 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
In-Reply-To: <448C19D7.5010706@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:
> Antonino A. Daplas wrote:
> 
>> Overall, this feature is a great help for developers working in the
>> framebuffer or console layer.  
>>
> Well, it has long been possible to load / unload framebuffer hardware
> drivers using the vfb module as an intermediate step. It even has been
> possible to load both vesafb and another framebuffer driver for the same
> hardware, to assign vesafb to tty{a,b,c..}, the other framebuffer driver
> to tty{m,n,o...} and to switch between those drivers using the usual
> keyboard hotkeys.
> 
> So the main addition of your patchset is the possibility to replace
> fbcon and helper modules, a nice feature I missed in the past.
> 
> But should a framebuffer driver terminate and leave the hardware in
> graphics mode or in text mode? Up to now that was not a real question,
> as we all knew that another framebuffer driver would take over control.
> With your patches it is possible that a user really wants to switch to text
> mode and to remove the complete fbcon layer. So should we switch the
> hardware to text mode upon unloading a framebuffer driver?
> 
> Maybe unbinding of the framebuffer console is not followed by an
> unloading of the framebuffer module. You tell us that an
> "echo 1 > /sys/class/graphics/fbcon/detach" has the simple effect of a
> corrupt display unless vbetools is used. No, that´s not ok.
> 
> Think about an echo 1 > /sys/class/graphics/fbcon/detach inside of an
> xterm session.
> 
> I think we need new fbops, eg.
> 
>     int fb_fbcon_unbind(...)
>     int fb_fbcon_bind(...)
> 
> If these are not implemented, unbinding is not allowed. Any requests to do
> so will be ignored.

We'll use fb_restore_state and fb_save_state if available, yes, but I don't
think we need to implement unbind and bind.  For one, as Jon and Andrew
has pointed out, drivers should have no concept of binding. (That's why the
patch has escalated to VT binding).

And why force drivers to have an fb_restore_state/fb_save_state just to
unbind/bind?  This is going to penalize 10's of drivers that don't need
it.  Just make this feature an experimental kconfig option, or make this
available as a boot option.

This feature is in a state of flux, so this is definitely not its final
form, nor the last one in a series.  The main goal here is to make the fbdev
system synchronize with other tools/modules whether it be for state
preservation, assistance on mode setting, etc. We need this if we are going
to make the different architectures work together.

Tony

