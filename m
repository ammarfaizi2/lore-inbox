Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290729AbSA3Xwv>; Wed, 30 Jan 2002 18:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290752AbSA3Xwl>; Wed, 30 Jan 2002 18:52:41 -0500
Received: from zok.sgi.com ([204.94.215.101]:58562 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S290746AbSA3Xw3>;
	Wed, 30 Jan 2002 18:52:29 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS 
In-Reply-To: Your message of "Wed, 30 Jan 2002 13:19:17 -0800."
             <3C586355.A396525B@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 31 Jan 2002 10:52:12 +1100
Message-ID: <6260.1012434732@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002 13:19:17 -0800, 
Andrew Morton <akpm@zip.com.au> wrote:
>"Eric W. Biederman" wrote:
>> In the short term shutting down devices is trivially handled by
>> umounting filesystems, downing ethernet devices, and calling the
>> reboot notifier chain.  Long term I need to call the module_exit
>> routines but they need a little sorting out before I can use them
>> during reboot.  In particular calling any module_exit routing that clears
>> pm_power_off is a no-no.
>
>module_exit() routines for statically-linked drivers often
>don't exist - they're in .text.exit.  I guess you can just
>move .text.exit out of the /DISCARD/ section in vmlinux.lds.

Sounds like a generalization of device hot plugging, which has already
solved this problem.  Turn on CONFIG_HOTPLUG and module_exit()
functions are in .text instead of .text.exit, no need to fiddle with
vmlinux.lds.

