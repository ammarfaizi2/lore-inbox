Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132414AbRAKWlH>; Thu, 11 Jan 2001 17:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132474AbRAKWk5>; Thu, 11 Jan 2001 17:40:57 -0500
Received: from hera.cwi.nl ([192.16.191.1]:6574 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S132414AbRAKWkp>;
	Thu, 11 Jan 2001 17:40:45 -0500
Date: Thu, 11 Jan 2001 23:34:36 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200101112234.XAA98877.aeb@ark.cwi.nl>
To: sorisor@hell.wh8.tu-dresden.de, viro@math.psu.edu
Subject: Re: Strange umount problem in latest 2.4.0 kernels
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The "none" bit puzzles me the most.

It is a common misconfiguration. Given a line

  device  dir  type  options  garbage

in /etc/fstab, some umount versions will complain "device busy"
when the umount fails. Thus, it is better to use

  proc    /proc     proc
  devpts  /dev/pts  devpts

instead of

  none    /proc     proc
  none    /dev/pts  devpts

so as to avoid this silly "none busy".
But many distributions come misconfigured like this.

These days umount is done by directory, not by device,
since a device may be mounted multiple times, so
I expect the silly message is gone.
(Is your umount recent?)

[But this is only about the "none". I don't know what is
wrong in your situation.]

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
