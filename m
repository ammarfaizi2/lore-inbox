Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKNKhw>; Tue, 14 Nov 2000 05:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129163AbQKNKhc>; Tue, 14 Nov 2000 05:37:32 -0500
Received: from stm.lbl.gov ([131.243.16.51]:9992 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S129132AbQKNKhZ>;
	Tue, 14 Nov 2000 05:37:25 -0500
Date: Tue, 14 Nov 2000 02:04:50 -0800
To: Olaf Kirch <okir@caldera.de>
Cc: Michal Zalewski <lcamtuf@DIONE.IDS.PL>, BUGTRAQ@SECURITYFOCUS.COM,
        linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse.
Message-ID: <20001114020450.A834@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <Pine.LNX.4.21.0011132040160.1699-100000@ferret.lmh.ox.ac.uk> <Pine.LNX.4.21.0011132352550.31869-100000@dione.ids.pl> <20001114095921.E30730@monad.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001114095921.E30730@monad.caldera.de>; from okir@caldera.de on Tue, Nov 14, 2000 at 09:59:22AM +0100
From: David Schleef <ds@stm.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 09:59:22AM +0100, Olaf Kirch wrote:
> On Tue, Nov 14, 2000 at 12:06:32AM +0100, Michal Zalewski wrote:
> > Maybe I am missing something, but at least for me, modprobe
> > vulnerabilities are exploitable via privledged networking services,
> > nothing more.
> 
> Maybe not. ncpfs for instance has an ioctl that seems to allow
> unprivileged users to specify a character set (codepage in m$speak)
> that's requested via load_nls(), which in turn does a
> 
> 	sprintf(buf, "nls_%s", codepage);
> 	request_module(buf);
> 
> Yummy.

Then it looks like the driver is broken, not modutils.


> Everyone is fixing modutils right now. Fine, but what about next
> year's modutils rewrite?
> 
> This is why I keep repeating over and over again that we should make
> sure request_module _does_not_ accept funky module names. Why allow
> people to shoot themselves (and, by extension, all other Linux users
> out there) in the foot?

Although I agree that having request_module() do a sanity check
is the best place to do a sanity check, I think it should be
up to the driver to not be stupid.  The drivers are trusted with
copy_to/from_user(), so why can't they be trusted to not pass
bad strings.

An inline function module_name_sanity_check() would be convenient
for those cases where "it is just necessary."

Rogue request_module() calls are bad in general, not only because
they might have dangerous invalid strings, but also because they
might have dangerous _valid_ strings.  I can imagine a
not-too-unlikely scenario where repeatedly loading a module
causes a DoS.




dave...


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
