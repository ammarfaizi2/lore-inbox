Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSKUABA>; Wed, 20 Nov 2002 19:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSKUABA>; Wed, 20 Nov 2002 19:01:00 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61874 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S264665AbSKUAA7>;
	Wed, 20 Nov 2002 19:00:59 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 21 Nov 2002 01:07:25 +0100 (MET)
Message-Id: <UTC200211210007.gAL07Pa07926.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: kill i_dev
Cc: torvalds@transmeta.com, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One disadvantage of enlarging the size of dev_t is
that struct inode grows. Bad.
We used to have i_dev and i_rdev; today i_rdev has split into
i_rdev, i_bdev and i_cdev. Bad.

It looks like these four fields can be replaced by a single one,
making struct inode smaller. Not bad.

The first step would be to delete the field i_dev, and
all assignments to it, and replace all remaining occurrences
by i_sb->s_dev.

Roughly speaking, the only use of this field is in the stat
system call.

Any objections?

Andries

