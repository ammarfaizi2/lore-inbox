Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263312AbTCNNWf>; Fri, 14 Mar 2003 08:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263314AbTCNNWf>; Fri, 14 Mar 2003 08:22:35 -0500
Received: from hera.cwi.nl ([192.16.191.8]:39825 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263312AbTCNNWe>;
	Fri, 14 Mar 2003 08:22:34 -0500
From: Andries.Brouwer@cwi.nl
Date: Fri, 14 Mar 2003 14:33:21 +0100 (MET)
Message-Id: <UTC200303141333.h2EDXL602770.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, t_benk@web.de
Subject: Re: [util-linux] cfdisk bug?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	From: Timo Benk <t_benk@web.de>

	[report on cfdisk failure where other *fdisk work,
	where things are fine with different size partitions,
	where things are fine when the bootable bit is set]

Ha - I see what happens. You have CONFIG_ACORN_PARTITION_POWERTEC
set. The Acorn code checks an 8-bit checksum over block 0,
and believes that you have an Acorn partition when that
checksum is OK.
So, everybody has a chance of 1 in 256 of having her block 0
recognized as a POWERTEC partition. And indeed, minor changes
will fix the situation.

Assuming that you do not actually have an Acorn, you can
switch off this configuration option.

I'll cc this to linux-kernel, so that problem and solution
are documented on a public list.

And maybe someone who knows about Acorns can add a test
to make it less likely that an Acorn is recognized by accident.

Andries
