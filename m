Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVHBUdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVHBUdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 16:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbVHBUdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 16:33:08 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:17523 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261766AbVHBU3y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 16:29:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lLwECDItrd7zkGDkoQYcrymXWKcm5JGRJ1pSYGEOPqaaF2gJ/FJyEstttMVb4XmJjoAgcUjTbxySvw1OtTEmso9Fygm3TEA3D6CRvDdTJsEqicix5J5b7o7TsDfyRbbDZiyhUSrF1z1L8fal8v78nmIJAX1Ik1eqPCjhAykcfvA=
Message-ID: <d120d50005080213296fac871e@mail.gmail.com>
Date: Tue, 2 Aug 2005 15:29:49 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Dmitrij Bogush <dmitrij.bogush@gmail.com>
Subject: Re: Touchpad errors
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <2ac89c700508021314f42da6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42EF633B.6080209@blueyonder.co.uk>
	 <d120d500050802072256a4d7ee@mail.gmail.com>
	 <2ac89c700508021314f42da6a@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/05, Dmitrij Bogush <dmitrij.bogush@gmail.com> wrote:
> Hi.
> I have the same issue on Acer Aspire 1520 notebook. On SuSE 9.3 system
> can not boot with acpi=off.
> In 2.6.13-rc4-git4 this crazy touchpad jumps reports as:
> 
> warning: many lost ticks.
> Your time source seems to be instable or some driver is hogging interupts
> rip handler_IRQ_event+0x20/0x60
> 
> and sometimes I can see
> 
> psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte N
> 
> This happens when some software check battery state or current cpu
> rate too often.
> 

Yes, that would do it. psmouse module drops received byte if it is
delayed for more than 0.5 sec. On some machines getting batetry info
takes a long time and all the time is spent in BIOS with interrupts
disabled. That is why the data is split between state and info - one
is static and takes much longer to access and other is more "dynamic"
and is cheaper to access. Unfortunately some usespace tools check both
and do that like every second.

You may try to talk to ACPI people; also I recommend setting battery
polling interval to something sane, like 1 minute, and make sure your
tool does not touch  "info" file - that should help a bit.

-- 
Dmitry
