Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUHCAJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUHCAJr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264562AbUHCAIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:08:48 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:51811 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264609AbUHCAIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:08:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Norbert Preining <preining@logic.at>
Subject: Re: 2.6.8-rc2-mm2 with usb and input problems
Date: Mon, 2 Aug 2004 19:08:06 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-usb-devel@lists.sourceforge.net
References: <20040802162845.GA24725@gamma.logic.tuwien.ac.at>
In-Reply-To: <20040802162845.GA24725@gamma.logic.tuwien.ac.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408021908.07092.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 August 2004 11:28 am, Norbert Preining wrote:
> Hi Andrew, hi list!
> 
> I tried 2.6.8-rc2-mm2 and I still don't get it to work properly for me.
> The last kernel which really worked was 2.6.7-mm5. I experience the
> following problems:
> 
> - USB deadlocking
>   USB is still deadlocky, quite often process hang in D+ state.
>   Is there something similar to usb-deadlock.fix which I could
>   apply to 2.6.7-mm6, but which stumbles over 2.6.8-rc2-mm2?
> 
> - psmouse/synaptics
>   If I have usb as module, I cannot get synaptics to be recognized.
>   Dmitry recommended making psaux driver as modules, but I cannot
>   get it as module, because INPUT is automatically set to y, etc
>   How is it possible to have USB modular and still get synaptics
>   recognized? (or is a modular USB not necessary for S2R now that
>   we have CONFIG_USB_SUSPEND?)
>

You should be able to compile psmouse as a module:

[root@core dtor]# grep MOUSE_PS2 /misc/arc/dtor/.config
CONFIG_MOUSE_PS2=m

You need to select it like this:

[*] Mice
  <M>  PS/2 mouse

and load psmouse.ko after USB has been loaded.

Alternatively you can try patch made by Vojtech to take over USB
system early, even before USB host controller driver is loaded:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108953563609250&w=2

(use "Download message RAW" link to get the patch).

-- 
Dmitry
