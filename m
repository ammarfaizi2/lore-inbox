Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130378AbQJ1Po2>; Sat, 28 Oct 2000 11:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130410AbQJ1PoS>; Sat, 28 Oct 2000 11:44:18 -0400
Received: from [195.180.174.143] ([195.180.174.143]:16000 "EHLO
	ghanima.neukum.org") by vger.kernel.org with ESMTP
	id <S130378AbQJ1PoH>; Sat, 28 Oct 2000 11:44:07 -0400
From: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Date: Sat, 28 Oct 2000 17:42:50 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10010281042130.8717-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.10.10010281042130.8717-100000@coffee.psychology.mcmaster.ca>
Subject: Re: question on SMP and read()/write()
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <00102817425009.00773@ghanima>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 28 October 2000 16:43, you wrote:
> > I've noticed that sys_read() and sys_write() don't grab the big kernel
> > lock. As file descriptors may be shared, must device drivers provide SMP
> > safe read() and write() methods ?
>
> no.  FD's refer to files; block drivers don't, and the nontrivial
> code between sys_* and drivers deals with this sort of thing.

Sure block drivers need not do this, but how about drivers for character 
devices ? It seems that sys_read() calls a function provided by the
f_op table without any locking. Isn't this the function a driver for a 
character device must provide to the VFS ?

	TIA
		Oliver
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
