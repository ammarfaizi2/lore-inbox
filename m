Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130758AbQKISTB>; Thu, 9 Nov 2000 13:19:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130751AbQKISSw>; Thu, 9 Nov 2000 13:18:52 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:7955 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129886AbQKISSo>; Thu, 9 Nov 2000 13:18:44 -0500
Date: Thu, 9 Nov 2000 19:18:43 +0100
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: Used space in bytes
Message-ID: <20001109191843.B11373@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello.

  I sent similar email a few weeks ago but discussion ended without
any useful results if I rememeber well.

  Quota in reiserfs is (and needs to be) accounted in bytes not in blocks.
I modified quota system to allow such thing so in kernel there's no
problem. But also 'quotacheck' needs to know how many space does given
file use. Currently it uses st_blocks from stat(2) to compute the space
used but for reiserfs we need precision in bytes, not in 512 byte blocks...
My proposal is to alter stat64() syscall to return also number of bytes
used (I tried to contact Ulrich Drepper <drepper@redhat.com> who should
be right person to ask about such things (at least I was said so) but go
no answer...). Does anybody have any better solution?
  I know about two others - really ugly ones:
   1) fs specific ioctl()
   2) compute needed number of bytes from st_size and st_blocks, which is
      currently possible but won't be in future

						Bye

							Honza
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
