Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTBPQM6>; Sun, 16 Feb 2003 11:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267203AbTBPQM6>; Sun, 16 Feb 2003 11:12:58 -0500
Received: from 12-237-214-24.client.attbi.com ([12.237.214.24]:14620 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S267184AbTBPQMz>;
	Sun, 16 Feb 2003 11:12:55 -0500
Message-ID: <3E4FBAD0.4040808@acm.org>
Date: Sun, 16 Feb 2003 10:22:40 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021204
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Corey Minyard <cminyard@mvista.com>,
       Werner Almesberger <wa@almesberger.net>,
       Zwane Mwaikambo <zwane@holomorphy.com>, suparna@in.ibm.com,
       Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E4914CA.6070408@mvista.com> <m1of5ixgun.fsf@frodo.biederman.org>	<3E4A578C.7000302@mvista.com> <m13cmty2kq.fsf@frodo.biederman.org>	<3E4A70EA.4020504@mvista.com> <20030214001310.B2791@almesberger.net>	<3E4CFB11.1080209@mvista.com> <20030214151001.F2092@almesberger.net>	<3E4D3419.1070207@mvista.com>	<Pine.LNX.4.50.0302141420220.3518-100000@montezuma.mastecende.com>	<20030214164436.H2092@almesberger.net> <3E4D4ADF.3070109@mvista.com> <m17kc26pxs.fsf@frodo.biederman.org>
In-Reply-To: <m17kc26pxs.fsf@frodo.biederman.org>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Eric W. Biederman wrote:

|Corey Minyard <cminyard@mvista.com> writes:
|
|>|
|>|(So adding a special mode to the power management code may
|>|be too much overhead. Besides, sometimes, you can just pull
|>|a reset line, and don't have to do anything even remotely
|>|related to power management.)
|>
|>True, I didn't mean the high-level power management code directly.  
But the
|>PCI API defines a suspend operation that could take a special mode for 
this.
|
|
|The generic device api has a shutdown method for this.  And in the non 
panic
|case we use it.  Not a lot of devices have it implemented but it exists.
|
|And except that it doesn't have a restriction that it can't block is pretty
|much what you want.

That's a pretty big restriction.  Plus, you can't claim spinlocks.

The panic shutdown is different from an orderly shutdown.  What the 
current shutdown does is probably not what you want.

|
|>Or maybe a new field in the PCI structure (and equivalent for other 
things, if
|>there are any).  But the suspend and resume operations should at least 
give
|>a good idea where its needed and how to use it.
|
|
|The API is already done...

The API is not done for panics.  There's no call that has the proper 
semantics.

|
|
|We just don't trust the dying kernel enough to use it during a panic.

I don't understand this.  If you can't trust a dying kernel to properly 
shut down devices, how can you trust it to boot a new kernel?  And (much 
worse) if you don't shut down the devices, how can you trust the new 
kernel to execute properly?  I know there are levels of trust here, but 
I'd much rather have the kernel lockup during the reboot than have a 
chance of a new kernel booting that could behave incorrectly.  In 
general, the chance of behaving incorrectly is MUCH worse than a sure 
lockup, especially in systems that must be reliable.

- -Corey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+T7rOIXnXXONXERcRAksfAJ9kVRD2S9OK5siBqAPMkbfi2iS2fgCeM3hw
Fjp2LXiNEURU+HNrByOGVBQ=
=5sxh
-----END PGP SIGNATURE-----


