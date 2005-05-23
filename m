Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVEWX6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVEWX6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 19:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVEWX5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 19:57:54 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261199AbVEWXpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 19:45:24 -0400
Date: Tue, 24 May 2005 01:44:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: Valdis.Kletnieks@vt.edu, James Morris <jmorris@redhat.com>,
       Toml@us.ibm.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org, Emilyr@us.ibm.com, Kylene@us.ibm.com
Subject: Re: [PATCH 2 of 4] ima: related Makefile compile order change and Readme
Message-ID: <20050523234454.GB1940@elf.ucw.cz>
References: <Pine.WNT.4.63.0505231657140.2372@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505231657140.2372@laptop>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Actually, you "could" also cat /proc files, then verify the signature
> > by hand (using pen and paper :-).
> 
> Theoretically, yes. The signature is 2048bit and to validate the signed 
> aggregate requires recursively applying SHA1 over all measurements.

:-)

> > It seems to me that the mechanism is sound... it does what the docs
> > says. Another questions is "is it usefull"?

> We implemented some exemplary IMA-applications. If you like, visit our 
> project page and check out the references:
> http://www.research.ibm.com/secure_systems_department/projects/tcglinux/
> There you also find a complete  measurement list and a response of a measured 
> system replying to an authorized remote measurement-list-request.

To make this usefull, you need to:

* have TPM chip

* modify all the interpreters

* modify all the programs that security-relevant config files. I.e. if
	there's /etc/keylogger.conf with default

	# No keyboard logging enabled

	and attacker changes it to

	do_log_keys_to_remote evil.com

	... you need that config file to be hashed.

* remove all the buffer overflows. I.e. if grub contains buffer
	overflow in parsing menu.conf... that is not a security hole
	(as of now) because only administrator can modify menu.conf.
	With IMA enabled, it would make your certification useless...

[probably something more].

...seems to me you need to do quite a lot of work to make this
usefull...

[And now, remote-buffer-overrun in inetd probably breaks your
attestation, no? I'll just load my evil code over the network, without
changing any on-disk executables, then install my evil rootkit into
kernel by writing into /dev/kmem. How do you prevent that one?]
								Pavel

