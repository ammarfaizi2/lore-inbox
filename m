Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVC2WdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVC2WdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVC2Wb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:31:57 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:5269 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261579AbVC2W37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:29:59 -0500
Subject: Re: [linux-pm] Re: swsusp 'disk' fails in bk-current - intel_agp
	at fault?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@suse.cz>
Cc: dtor_core@ameritech.net, Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>, Stefan Seyfried <seife@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Isaacson <adi@hexapodia.org>
In-Reply-To: <20050329214408.GH8125@elf.ucw.cz>
References: <4243D854.2010506@suse.de>
	 <d120d50005032908183b2f622e@mail.gmail.com>
	 <20050329181831.GB8125@elf.ucw.cz>
	 <d120d50005032911114fd2ea32@mail.gmail.com>
	 <20050329192339.GE8125@elf.ucw.cz>
	 <d120d50005032912051fee6e91@mail.gmail.com>
	 <20050329205225.GF8125@elf.ucw.cz>
	 <d120d500050329130714e1daaf@mail.gmail.com>
	 <20050329211239.GG8125@elf.ucw.cz>
	 <d120d50005032913331be39802@mail.gmail.com>
	 <20050329214408.GH8125@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1112135477.29392.16.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 30 Mar 2005 08:31:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-03-30 at 07:44, Pavel Machek wrote:
> We currently freeze processes for suspend-to-ram, too. I guess that
> disable_usermodehelper is probably better and that in_suspend() should
> only be used for sanity checks... go with disable_usermodehelper and
> sorry for the noise.

Here's another possibility: Freeze the workqueue that
call_usermodehelper uses (remember that code I didn't push hard enough
to Andrew?), and let invocations of call_usermodehelper block in
TASK_UNINTERRUPTIBLE. In refrigerating processes, don't choke on kernel
processes in that state. Of course if you won't want the freeze
processes for str, but do want to freeze call_usermodehelper, I guess
you'd still need the in_suspend() macro.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

