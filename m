Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSJOEz1>; Tue, 15 Oct 2002 00:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbSJOEz1>; Tue, 15 Oct 2002 00:55:27 -0400
Received: from bgp01116664bgs.westln01.mi.comcast.net ([68.42.104.18]:15977
	"HELO blackmagik.dynup.net") by vger.kernel.org with SMTP
	id <S262148AbSJOEz0>; Tue, 15 Oct 2002 00:55:26 -0400
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not
	suspend devices
From: Eric Blade <eblade@blackmagik.dynup.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
In-Reply-To: <m1n0pgkcqi.fsf@frodo.biederman.org>
References: <200210141841.LAA19982@baldur.yggdrasil.com> 
	<m1n0pgkcqi.fsf@frodo.biederman.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8.99 
Date: 15 Oct 2002 00:55:52 -0400
Message-Id: <1034657752.1215.126.camel@cpq>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 16:05, Eric W. Biederman wrote:
> For myself I am happy that someone introduced 
> device_shutdown and it has reasonable semantics.
> 
> As for halting the system, we currently have two cases:
> 
> 
> 	case LINUX_REBOOT_CMD_HALT:
> 		notifier_call_chain(&reboot_notifier_list, SYS_HALT, NULL);
> 		system_running = 0;
> 		device_shutdown();
> 		printk(KERN_EMERG "System halted.\n");
> 		machine_halt();
> 		do_exit(0);
> 		break;
> 
> 	case LINUX_REBOOT_CMD_POWER_OFF:
> 		notifier_call_chain(&reboot_notifier_list, SYS_POWER_OFF, NULL);
> 		system_running = 0;
> 		device_shutdown();
> 		printk(KERN_EMERG "Power down.\n");
> 		machine_power_off();
> 		do_exit(0);
> 		break;
> 

  i see four occurences in my 2.5.42: LINUX_REBOOT_CMD_RESTART,
LINUX_REBOOT_CMD_HALT, LINUX_REBOOT_CMD_POWER_OFF, and
LINUX_REBOOT_CMD_RESTART2

> 
> But for the most part my impression is that we need to get devices
> drivers behaving properly in the 2.5.x   And that the basic model
> is o.k.  It just needs some pounding on the rough spots.

I agree on this point :)




