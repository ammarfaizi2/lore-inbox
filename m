Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266196AbUI0OhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266196AbUI0OhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 10:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266273AbUI0OhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 10:37:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:12958 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266196AbUI0Oe4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 10:34:56 -0400
Message-ID: <4158250E.9020005@suse.de>
Date: Mon, 27 Sep 2004 16:34:54 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <20040927141652.GF28865@dualathlon.random>
In-Reply-To: <20040927141652.GF28865@dualathlon.random>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Sep 27, 2004 at 08:16:43AM +0200, Stefan Seyfried wrote:

>>Why not ask on every boot? (and yes, the passphrase could be stored on a

> because I never use suspend/resume on my desktop, I never shutdown my
> desktop. I don't see why should I spend time typing a password when
> there's no need to. Every single guy out there will complain at linux
> hanging during boot asking for password before reaching kdm.

Well, there is more than one use case -> probably we need more than one 
implementation :-)

> I figured out how to make the swap encryption completely transparent to
> userspace, and even to swap suspend, so I think it's much better than
> having userspace asking the user for a password, or userspace choosing a
> random password.

That's fine for the never-enter-a-password case, but for the 
suspend-case, it's not so good since i want to close the lid and pack 
away the notebook. Two scenarios, two implementations.
> 
> 
>>And a resume is - in the beginning - a boot, so just ask early enough
>>(maybe the bootloader could do this?)
>  
> yes, but the bootloader passes the paramters via /proc/cmdline, and it's
> not nice to show the password in cleartext there.

We could mask it in /proc/cmdline or think of other mechanisms for 
passing the secret. Or just ask from the initramfs and start resuming 
after that.

> Keep in mind the password cannot be stored on the harddisk, or it would
> be trivial to find it for an attacker stoling the laptop.

> suspend/resume is just unusable for me on the laptop until we fix the
> crypto issues.

Well, as long as you need your entire $HOME or / encrypted, it's not 
easy. If you just need e.g. /secret/ encrypted userspace could umount it 
before suspend and remount it after resume (we also lock X etc, adding a 
umount / mount should be trivial).
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX AG Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
