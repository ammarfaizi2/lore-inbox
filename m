Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267364AbUHRGYd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267364AbUHRGYd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUHRGYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:24:33 -0400
Received: from cantor.suse.de ([195.135.220.2]:24982 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267364AbUHRGYb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:24:31 -0400
Date: Wed, 18 Aug 2004 08:22:10 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: ismail =?utf-8?Q?d=C3=B6nmez?= <ismail.donmez@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Message-ID: <20040818062210.GB22332@suse.de>
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com> <2a4f155d040817124335766947@mail.gmail.com> <41226512.9000405@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41226512.9000405@microgate.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Aug 17, Paul Fulghum wrote:

> ismail dönmez wrote:
> 
> >>That does not look right.
> >>Char dev 3 is the pty major.
> >>This could be left over from running with the controlling-tty patch.
> >>
> >>Try recreating /dev/tty as a char special file:
> >>mknod -m 666 /dev/tty c 5 0
> >
> >
> >Hmm I use udev and /dev/tty dir is created again at startup. So
> >something else is broken too I think.
> 
> This is almost certainly related to the addition
> of pty devices to devfs in bk-driver-core.patch
> Change is by olh@suse.de
> 
> This explains why you are seein pty major devices
> created in a /dev/tty directory.

/dev/tty is supposed to be char c 5 0, /class/tty/tty/dev will tell udev
how to create it, see man 4 tty.
No idea who came up with the bright idea to put legacy bsd devices in a
subdir. Documentation/devices.txt shows that my patch is ok, it handles
up to 256 device nodes.
If you are using udev, file a bugreport for your distros package. In the
meantime, remove the offending line from your udev.rules file.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
