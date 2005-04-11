Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbVDKQco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbVDKQco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDKQco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:32:44 -0400
Received: from hermes.domdv.de ([193.102.202.1]:28179 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261828AbVDKQ2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:28:43 -0400
Message-ID: <425AA5B7.4000900@domdv.de>
Date: Mon, 11 Apr 2005 18:28:39 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: folkert@vanheusden.com,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH encrypted swsusp 1/3] core functionality
References: <4259B474.4040407@domdv.de> <20050411102550.GD1353@elf.ucw.cz> <20050411103608.GA5610@vanheusden.com> <20050411110152.GD1373@elf.ucw.cz>
In-Reply-To: <20050411110152.GD1373@elf.ucw.cz>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> I'd like to retain ability to read suspend image in any order (so that
> code can be reused for swap encryption, etc).
> 								Pavel

This is not possible with cipher block chaining as used right now. One
would have to use a non-random iv set needs to set for every page. And
this leads to exactly the same problem why dm-crypt now offers the
'essiv' mode. I don't know if a random access feature is worth this
effort as sequential disk access (sequential write, sequential read) is
usally the fastest method anyway.

For regular swap encryption I do hope that the initrd feature of swsup2
will eventually find its way into the mainline kernel. This way you can
have an external key for dm-crypt to access the encrypted swap partition.

dm-crypt thus would guard the system during suspend/poweroff while the
encrypted suspend image guards against data gathering after
resume/reboot (the latter when mkswap is used).
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
