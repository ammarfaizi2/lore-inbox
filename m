Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268397AbUHQUHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268397AbUHQUHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 16:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268401AbUHQUHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 16:07:04 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:18532 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268397AbUHQUHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 16:07:00 -0400
Message-ID: <41226512.9000405@microgate.com>
Date: Tue, 17 Aug 2004 15:05:38 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olh@suse.de
Subject: Re: 2.6.8.1-mm1 Tty problems?
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com> <2a4f155d040817124335766947@mail.gmail.com>
In-Reply-To: <2a4f155d040817124335766947@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ismail dönmez wrote:

>>That does not look right.
>>Char dev 3 is the pty major.
>>This could be left over from running with the controlling-tty patch.
>>
>>Try recreating /dev/tty as a char special file:
>>mknod -m 666 /dev/tty c 5 0
> 
> 
> Hmm I use udev and /dev/tty dir is created again at startup. So
> something else is broken too I think.

This is almost certainly related to the addition
of pty devices to devfs in bk-driver-core.patch
Change is by olh@suse.de

This explains why you are seein pty major devices
created in a /dev/tty directory.

Specifically the changes in drivers/char/tty_io.c
in function tty_register_device()

Try backing out that specific portion of bk-driver-core.patch

--
Paul Fulghum
paulkf@microgate.com
