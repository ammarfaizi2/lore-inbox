Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbUFPHe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbUFPHe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 03:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266209AbUFPHe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 03:34:59 -0400
Received: from [217.73.129.129] ([217.73.129.129]:35212 "EHLO
	car.linuxhacker.ru") by vger.kernel.org with ESMTP id S261984AbUFPHe6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 03:34:58 -0400
Date: Wed, 16 Jun 2004 10:34:35 +0300
Message-Id: <200406160734.i5G7YZwV002051@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: mode data=journal in ext3. Is it safe to use?
To: pla@morecom.no, linux-kernel@vger.kernel.org
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan> <1087322976.1874.36.camel@pla.lokal.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Petter Larsen <pla@morecom.no> wrote:

PL> Can anybody of you acknowledge or not if mode data=journal in ext3 is
PL> safe to use in Linux kernel 2.6.x?
PL> Wee need to have a very consistent and integrity for our filesystem, and
PL> it would then be desired to journal both data and metadata.

Actually data=journal mode would gain you mostly zero extra consistency compared
to data=ordered mode. (the only more consistency bit that you get is
correct mtime on files that have their pages overwritten, I think).
You have zero control over transaction boundaries in ext3, so you still need
to design your applications in such a way that they have their own
sort of transactions (if this is needed).

PL> Data integrity is much more important for us than speed.

It is not clear what sort of extra data integrity do you expect from data
journaling mode and why do you think it is there.

Garbage in files should not happen in data ordered mode as data pages are
written first before metadata updates are committed.

Bye,
    Oleg
