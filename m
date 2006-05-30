Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWE3RBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWE3RBw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 13:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWE3RBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 13:01:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:6527 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932337AbWE3RBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 13:01:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=L875RkD/S9/aQiVDvNPIsOrHe+I4yrebl8F+XXHR4VaQ3h8hgqOHo5qEDJb8s6uhAy75wmJgZlOgKDqIk8yEH3dCPqa+9wS/KTftAwvoahkxY5m5o2S9Xp5imm+hFxUmf80G1/KIoyLGeJIR8c4Z9reShazX3IbAirZGjtDMpPY=
Message-ID: <447C7AA7.4080001@gmail.com>
Date: Tue, 30 May 2006 19:02:31 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: searching for pci busses
References: <4478DCF1.8080608@gmail.com> <20060529214753.GD10875@kroah.com>	 <447B6ECB.9080207@pobox.com> <20060530163821.GC7146@suse.de> <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
In-Reply-To: <9e4733910605300952v1cf56beasc2a907cc77b8a09f@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jon Smirl napsal(a):
> On 5/30/06, Greg KH <gregkh@suse.de> wrote:
>> On Mon, May 29, 2006 at 05:59:39PM -0400, Jeff Garzik wrote:
>> > Greg KH wrote:
>> > >On Sun, May 28, 2006 at 01:12:26AM +0159, Jiri Slaby wrote:
>> > >>Hello,
>> > >>
>> > >>I want to ask, if there is any function to call (as we debated with
>> > >>Jeff), which
>> > >>does something like this:
>> > >>1) I have some vendor/device ids in table
>> > >>2) I want to traverse raws of the table and compare to system
>> devices,
>> > >>and if
>> > >>found, stop and return pci_dev struct (or raw in the table).
>> > >
>> > >What's wrong with pci_match_id()?
>> > >
>> > >Or just using the pci_register_driver() function properly, which
>> handles
>> > >all of this logic for you?
>> >
>> > These aren't PCI devices proper.  These are embedded non-PCI devices,
>> > which must search for an unrelated PCI device to figure out what
>> type of
>> > platform they are on.
>>
>> Ok, then use pci_match_id() or pci_get_device().
> 
> This is how DRM does it...
> 
>        for (i = 0; driver->pci_driver.id_table[i].vendor != 0; i++) {
>                pid = (struct pci_device_id
> *)&driver->pci_driver.id_table[i];
> 
>                pdev = NULL;
>                /* pass back in pdev to account for multiple identical
> cards */
>                while ((pdev =
>                        pci_get_subsys(pid->vendor, pid->device,
> pid->subvendor,
>                                       pid->subdevice, pdev)) != NULL) {
>                        /* stealth mode requires a manual probe */
>                        pci_dev_get(pdev);
>                        drm_get_dev(pdev, pid, driver);
>                }
>        }
>        return 0;
> 
> 
It's similar to code in my root post, so thanks for replies, it's maybe the best
way.

thanks,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEfHqnMsxVwznUen4RAkQKAKCTZqlxtJwKTjlDP07ZAes9Jk5KOACgkSzt
zxyv1TitUGpv6rnppOiPyEI=
=3pfI
-----END PGP SIGNATURE-----
