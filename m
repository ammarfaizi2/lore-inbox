Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279997AbRJ3QSf>; Tue, 30 Oct 2001 11:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279998AbRJ3QSZ>; Tue, 30 Oct 2001 11:18:25 -0500
Received: from hermes.toad.net ([162.33.130.251]:28131 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S279997AbRJ3QSW>;
	Tue, 30 Oct 2001 11:18:22 -0500
Subject: Re: apm suspend broken ?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 30 Oct 2001 11:18:17 -0500
Message-Id: <1004458698.4243.118.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a question related to this.

If a driver ioctl handler requires
    (filp->f_mode) & FMODE_WRITE
to be set before processing a request, and if only
root has write permission to the device file, does this
make it unnecessary to check for
     capable(CAP_SYS_ADMIN)
?

If we were to use the write permission bit to control
access, then it would not be necessary for the apm
command to be setuid root to give the non-root user
the ability to suspend the machine.  Instead we could
    chgrp apm /dev/apm_bios
    chmod g+w /dev/apm_bios
and add the trusted user to the 'apm' group.

Am I missing something here?

--
Thomas

