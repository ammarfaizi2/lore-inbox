Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbUKLKpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUKLKpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUKLKpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:45:42 -0500
Received: from main.gmane.org ([80.91.229.2]:23958 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262522AbUKLKo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:44:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Juergen Stuber <juergen@jstuber.net>
Subject: Re: USB-1.1 fails with USB 2.0 Hub
Date: Fri, 12 Nov 2004 11:44:19 +0100
Message-ID: <86d5yjtkho.fsf@jstuber.net>
References: <6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com> <200411112003.43598.Gregor.Jasny@epost.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-082-083-092-212.arcor-ip.net
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:4Yprz6xziizFZmPPPAP3UV6k49Q=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gregor,

Gregor Jasny <Gregor.Jasny@epost.de> writes:
>
> Just a simple me, too. 

I don't think it is the same problem.

> I've got the problem with a TerraCAM USB Pro. Plugged 
> into my Apple Keyboard it works (with a warning about high power 
> consumption). But if I plug it into my Belkin F5U237 the driver complains 
> with: "drivers/usb/media/ov511.c: init isoc: usb_submit_urb(0) ret -38".

-38 is -ENOSYS which means "Function not implemented"
(see include/asm-generic/errno.h in the kernel sources).
To support USB 1.1 devices over a 2.0 hub the hub contains
a so-called transaction translator that needs special support
in the USB driver, and which works differently for isochronous
transfers (note the isoc in the error message).
This is usually implemented after the other transfer types.

> Have you already tried another USBv2 hub?

I don't think you can cure it with a different 2.0 hub.
You can either use only 1.1 hubs on the path to the device,
like with the keyboard, or try a newer kernel version
(but then 2.6.9 is already rather new).


Hope this helps

Jürgen

-- 
Jürgen Stuber <juergen@jstuber.net>
http://www.jstuber.net/
gnupg key fingerprint = 2767 CA3C 5680 58BA 9A91  23D9 BED6 9A7A AF9E 68B4

Looking for consulting and project work in Mozart/Oz, Linux kernel, USB

