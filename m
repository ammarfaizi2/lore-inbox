Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWEREbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWEREbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWEREbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:31:23 -0400
Received: from web81108.mail.mud.yahoo.com ([68.142.199.100]:2145 "HELO
	web81108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750700AbWEREbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:31:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ameritech.net;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=q4SovUJ/csStWJTa1F09x34rf1U+10rtBXAOzzP+2c4ZsjSlWIT3ruqbw7qxNxwbTco80hoicCgR4wSwF5H35Br5qaGMd7oc6HTGi1HELrTreShcP5SkhyByFl/wTA15/tM+959tgBGNyCOejWiXWC5EvKoIl1Z8+Wa6wBmDu0U=  ;
Message-ID: <20060518043121.39140.qmail@web81108.mail.mud.yahoo.com>
Date: Wed, 17 May 2006 21:31:21 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [patch] add input_enable_device()
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <446BF398.80507@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Stas Sergeev <stsp@aknet.ru> wrote:

> Dmitry Torokhov wrote:
> >> Why does it have the INPUT_DEVICE_ID_MATCH_BUS after all?
> > For userspace benefits.
> How exactly does the userspace benefit from the
> INPUT_DEVICE_ID_MATCH_BUS thing?
> And, by the way, why doesn't the input have the
> capability of disabling/enabling the device?
> 

What for? If you do not want to get events form a device do not
read it. Or do not compile/load the driver. You can do a lot of
things from userspace.

Your problem is that you want to one piece of kernel to take over
another kernel piece instead of making it work together. With
your enable/disable scheme what happens where there is 3rd module
that wants to do stuff with speaker? Does it also disable snd-pcsp?

> > While you are fine with
> > disabling beeps while music is playing otherpeoplr might still want
> > to hear them.
> The only possibility to do this, was to have the grabbing
> capability *in input layer*, which you already rejected too.
> With this, it was possible to have such a behaviour run-time
> configurable, but now my best bet would be to resort to the
> Kconfig games, making a note for users that the uinput is now
> an only possibility to route the terminal beeps to the snd-pcsp.
> 

You just do not want to implement proper access control for the
hardware, that's it. 

--
Dmitry
