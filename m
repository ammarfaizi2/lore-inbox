Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132600AbRDKPLB>; Wed, 11 Apr 2001 11:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132603AbRDKPKv>; Wed, 11 Apr 2001 11:10:51 -0400
Received: from m382-mp1-cvx1c.col.ntl.com ([213.104.77.126]:39552 "EHLO
	[213.104.77.126]") by vger.kernel.org with ESMTP id <S132602AbRDKPKc>;
	Wed, 11 Apr 2001 11:10:32 -0400
To: Pavel Machek <pavel@suse.cz>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>
	<20010411142012.C32104@atrey.karlin.mff.cuni.cz>
From: John Fremlin <chief@bandits.org>
Date: 11 Apr 2001 16:10:24 +0100
In-Reply-To: Pavel Machek's message of "Wed, 11 Apr 2001 14:20:13 +0200"
Message-ID: <m2bsq3h3q7.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Pavel Machek <pavel@suse.cz> writes:

> Hi!
> 
> > This is not correct, because we want the power button to be
> > configurable.  The user should be able to redefine the power
> > button's action, perhaps to only sleep the system. We currently
> > surface button events to acpid, which then can do the right thing,
> > including a shutdown -h now (which I assume notifies init).
> 
> There's no problem with configurability -- you can configure init as
> well. I saw it pretty much analogic to situation with Ctrl-Alt-Del:
> it also sends signal to init. Init then decides what to do. [I
> believe requiring acpid for such easy stuff is not neccessary...]

Using a signal to hit init with is a bit dubious because most signals
are hooked up for something else already. For example, SIGTERM sent to
my init (http://john.snoop.dk/programs/linux/jinit) would shutdown and
start sulogin, which is probably not what you want when you press the
off button. The FreeBSD init is similar FWIW (goes to single user
mode).

Some PM interfaces (e.g. APM) require a descision to be made by
software on such an event (to turn off or to "reject"). IMHO the best
way to do this is to exec a small script from kernelspace to get the
user's preferred policy; this is lighter weight than a daemon, doesn't
require some nasty magic number interface, and can be easily
programmed by any admin knowing sh or perl or whatever.

[...]

-- 

	http://www.penguinpowered.com/~vii
