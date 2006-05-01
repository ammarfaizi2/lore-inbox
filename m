Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbWEAF0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbWEAF0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWEAF0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:26:07 -0400
Received: from xproxy.gmail.com ([66.249.82.198]:5569 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750857AbWEAF0F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:26:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=WSoyNK18bbgmTndfUXLlZ1ftLtuyWzz5D/1bBWf+fYQp9F1bG+XzvcbsRYzKatJimQw6JCdg1GnlIEK3UTPMRSLC652JA9jTG9zZlUoBHHKk9JghSQnQYM2MeKspD547YyYxcZj7Vb3NhKbMHndLI470Wawicdrwks2KiBdn6QE=
Message-ID: <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com>
Date: Mon, 1 May 2006 00:26:05 -0500
From: "Circuitsoft Development" <circuitsoft.devel@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Extended Volume Manager API
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Question:

How hard would it be to implement a volume manager with an extended
API? I want to write a tightly-integrated volume manager/distributed
lock manager to arbitrate lock-free, atmoic read/compare/write
operations with other computers on the network. Also, I have a need to
have this API available to user-space applications. How would I do
this?

Details follow, if you're curious.

The idea is to make a distributed filesystem that won't hiccup when a
client node crashes. I've decided to implement all the gritty work in
the volume manager, and just design the filesystem to take advantage
of it.

Having done my own tests, I've determined that a 5msec timeout to
determine if a host has crashed would be appropriate. (My test was
basically looking at ping time over a saturated network - averaged
about 600 microseconds, topped at 3msec over 10 minutes) I figure that
5msec timeout won't add any noticeable lag to the volume manager, as
most disk seek times are in that range.

Anyway, we basically have the volume manager asking around for
everyone else on the network, to see if they have a particular area
locked. If so, wait for it to be unlocked. If not, record and
broadcast the lock, then do the atomic read/compare/write operation
while locked, and unlock before we return to the client (filesystem).

I need the API to this code to be available to userspace due to an
application that I cannot mention because of an informal NDA.

Thank you,
- Alex Austin, Circuitsoft Computer Services
"From Windows to MacOS, and the Linux in between"
