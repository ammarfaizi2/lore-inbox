Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRJNMDG>; Sun, 14 Oct 2001 08:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRJNMC4>; Sun, 14 Oct 2001 08:02:56 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32523 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275097AbRJNMCo>; Sun, 14 Oct 2001 08:02:44 -0400
Subject: Re: [RFC] "Text file busy" when overwriting libraries
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 14 Oct 2001 13:08:28 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        viro@math.psu.edu (Alexander Viro), linux-kernel@vger.kernel.org
In-Reply-To: <m1het2r6nm.fsf@frodo.biederman.org> from "Eric W. Biederman" at Oct 14, 2001 02:02:21 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15sk4C-0007Be-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My big question is how to correctly define O_EXEC for every
> architecture.  But I would like to know if there are objectionable
> parts as well.

It looks totally unworkable. Open() has side effects on a large number of
platforms, and being able to open an exec only file might trigger them
as well as all sorts of other potential problems where files are
marked rwx by accident as is very common.

You narrow the DoS vulnerability and add a whole new set of open based
ones.

This isnt a problem worth solving. Shared libraries are managed by the
superuser. The shared library tools already do the right thing. The
superuser can equally reboot the machine or reformat the disk by accident
anyway.
