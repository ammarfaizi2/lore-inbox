Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWE1Qfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWE1Qfn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWE1Qfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:35:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:4326 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750794AbWE1Qfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:35:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=c8RR7qb7Qr+B3e6JGCRAveA1boYNKrWMHcKBK04CdWRkdZZ+k+v7UJgCFumAunkZ5SN+9kM6+cjyjBmyzCq6hhsK/Pksxt/BuIUIZtkM3ZXRL72fRBXZtgX6CZIck9Lnmzz1nMjcHLKQJ1zT0yIcx1OA4aQK3NfVmaKOqEOsOZM=
Message-ID: <4479D167.4020203@gmail.com>
Date: Sun, 28 May 2006 18:35:28 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Christer Weinigel <christer@weinigel.se>
CC: Jiri Slaby <jirislaby@gmail.com>, Nathan Laredo <laredo@gnu.org>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com> <m3slmui1cr.fsf@zoo.weinigel.se>
In-Reply-To: <m3slmui1cr.fsf@zoo.weinigel.se>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christer Weinigel napsal(a):
 > I'm running the stock Fedora Core 5 kernels, and for some reason the
> stradis driver is loaded.  I suppose there's some magic in the FC5
> hotplug scripts that tries to load all device drivers that claim to
> support a certain PCI device.
Userspace now knows, that stradis can take control of this hardware, so US loads
it, because MODULE_DEVICE_TABLE is present in the driver (you may compare old
and new /lib/modules/`uname -r`/modules.pcimap). It shows us the next way, how
to solve this -- delete this TABLE line from the driver, to not advertise "I can
take control of it".
> 
> I have blacklisted the stradis driver on my system, which fixes it for
> me, but it does feels as a workaround for a problem that ought to be
> fixed in the driver.  If the card doesn't have a subvendor/subdevice,
> is there some way of doing a sanity check on the board to see if it
> actually is a stradis card and then release the board if it isn't?
Unfortunately not.
> 
> If the driver isn't fixed I'll file a bug report on the Fedora
> bugzilla asking them to blacklist or just not compile that driver.
It is the best short-term solution, I think.

So, what to do now, Mauro, Nathan? Fix it in US (i.e. blacklist) or KS (i.e.
delete TABLE entry -- hope this helps) for the time until the driver will be
integrated?

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEedFnMsxVwznUen4RAnv3AKCthKpF67t+R+iAu0cs31icG1KH2ACgnwXw
UKrSzuXdr/sBAr+rDmAdPIk=
=2R9i
-----END PGP SIGNATURE-----
