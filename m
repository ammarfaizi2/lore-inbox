Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264139AbVBEA7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264139AbVBEA7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 19:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVBEAys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 19:54:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:48088 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264326AbVBEAvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 19:51:47 -0500
X-Authenticated: #26200865
Message-ID: <420418C7.5010309@gmx.net>
Date: Sat, 05 Feb 2005 01:52:23 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de>	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>	 <1107474198.5727.9.camel@desktop.cunninghams>	 <4202DF7B.2000506@gmx.net>	 <1107485504.5727.35.camel@desktop.cunninghams>	 <9e4733910502032318460f2c0c@mail.gmail.com>	 <20050204074454.GB1086@elf.ucw.cz> <9e473391050204093837bc50d3@mail.gmail.com>
In-Reply-To: <9e473391050204093837bc50d3@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl schrieb:
> On Fri, 4 Feb 2005 08:44:54 +0100, Pavel Machek <pavel@ucw.cz> wrote:
> 
>>We already try to do that, but it hangs on 70% of machines. See
>>Documentation/power/video.txt.
> 
> We know that all of these ROMs are run at power on so they have to
> work. This implies that there must be something wrong with the
> environment the ROM are being run in. Video ROMs make calls into the
> INT vectors of the system BIOS. If these haven't been set up yet
> running the VBIOS is sure to hang.  Has someone with ROM source and
> the appropriate debugging tools tried to debug one of these hangs?
> Alternatively code could be added to wakeup.S to try and set these up
> or dump the ones that are there and see if they are sane.

My problem (Samsung P35) is that the BIOS wants to call code which
is no longer mapped because the BIOS is too big to fit into the
standard area. Since that additional area has been overwritten, we
are out of luck. Maybe if we did something like backing up all
untouched real mode memory immediately after switching to protected
mode, it could work. But I don't know whether that is feasible on
boot. Anyways, you don't want to run possibly buggy closed source
bios code in an environment where a single random memory write
may corrupt the kernel without debuggability.

And sometimes there is BIOS code which is can't be run twice.
Period.
Don't believe that one? I have a machine where calling EDD code
in the BIOS twice will hang the second time. See boot parameter
edd=off for reference :-(

So I agree that we could try to preserve the state better, but
I also can guarantee you it won't help everywhere.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
