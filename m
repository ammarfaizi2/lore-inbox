Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264923AbSJPGim>; Wed, 16 Oct 2002 02:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264914AbSJPGim>; Wed, 16 Oct 2002 02:38:42 -0400
Received: from tantale.fifi.org ([216.27.190.146]:17792 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S264923AbSJPGil>;
	Wed, 16 Oct 2002 02:38:41 -0400
To: ebuddington@wesleyan.edu
Cc: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org
Subject: Re: can chroot be made safe for non-root?
References: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
From: Philippe Troin <phil@fifi.org>
Date: 15 Oct 2002 23:44:32 -0700
In-Reply-To: <20021016015106.E30836@ma-northadams1b-3.bur.adelphia.net>
Message-ID: <87n0pevq5r.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Buddington <eric@ma-northadams1b-3.bur.adelphia.net> writes:

> I am eager to be able to sandbox my processes on a system without the
> help of suid-root programs (as I prefer to have none of these on my
> system).

Probably an impossible task...

> Would it be reasonable to allow non-root processes to chroot(), if the
> chroot syscall also changed the cwd for non-root processes?

No.

  fd = open("/", O_RDONLY);
  chroot("/tmp");
  fchdir(fd);

and you're out of the chroot.

> Is there a reason besides standards compliance that chroot() does not
> already change directory to the chroot'd directory for root processes?
> Would it actually break existing apps if it did change the directory?

Probably not. Make that: change the directory to chroot'd directory if
the current working directory is outside the chroot. That is, leave
the cwd alone if it is already inside the chroot.

Phil.
