Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284258AbRLTGvx>; Thu, 20 Dec 2001 01:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285024AbRLTGvo>; Thu, 20 Dec 2001 01:51:44 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39245 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284258AbRLTGv2>; Thu, 20 Dec 2001 01:51:28 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>
	<m18zbzwp34.fsf@frodo.biederman.org> <3C205FBC.60307@zytor.com>
	<m1zo4fursh.fsf@frodo.biederman.org>
	<9vrlef$mat$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Dec 2001 23:31:08 -0700
In-Reply-To: <9vrlef$mat$1@cesium.transmeta.com>
Message-ID: <m1r8pqv1w3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Followup to:  <m1zo4fursh.fsf@frodo.biederman.org>
> By author:    ebiederm@xmission.com (Eric W. Biederman)
> In newsgroup: linux.dev.kernel
> > 
> > Which just goes to show what a fragile firmware design it is, to have
> > firmware callbacks doing device I/O.  I think the whole approach of
> > having firmware callbacks is fundamentally flawed but I'll do my best
> > to keep it working, for those things that care.  If it works over 50%
> > of the time I'm happy...
> > 
> 
> NAK.  You can make it perfectly robust thankyouverymuch, as long as
> you don't try to *mix* firmware and poking directly at the
> hardware... this is a classic "who owns what" class problem.

I agree that I could keep it working as well as it ever would.  Not
that x86 firmware or any software is ever perfectly working.

At this point in time I live in a world where 99+% of the time the
hardware is owned by the operating system, and the firmware is just
there to get the operating system loaded, and to hold details about
the motherboard that the operating system can not find out by probing
the hardware.

For the cases I find important I get better reliability and
portability by never involving the firmware at all.  If there is a
problem with a driver I can fix it.  If I want to switch cpus I can.
Admittedly the cost for native drivers is high, but if I don't have to
pay that cost twice and can actually reuse my OS drivers.  It isn't a
price I mind paying.

I care about not trashing the firmware so a newer probe routine can
find out more precisely or robustly what is on a motherboard.  Having
a reasonable chance that the firmware can also still drive the
hardware is a plus. 

I criticize firmware designers, not to attack anyones dependence on
the firmware.  But more to make certain I never implement anything
like that.  

I don't think I have seen a firmware design where someone has designed
it with the assumption that humans mess up.  Instead every firmware
interface I have seen seems to be designed by asking how can I include
every possible desirable feature.  Since it is painful to fix or
replace firmware this is a real issue. 

I have seen alpha firmware getting confused when the operating system
uses the hardware, when rebooting on the alpha.  Which is why I am
sensitive to it.

Eric
