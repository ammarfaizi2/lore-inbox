Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317268AbSGCWTJ>; Wed, 3 Jul 2002 18:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317270AbSGCWTI>; Wed, 3 Jul 2002 18:19:08 -0400
Received: from [216.33.1.194] ([216.33.1.194]:28421 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317268AbSGCWTH>; Wed, 3 Jul 2002 18:19:07 -0400
Message-Id: <200207032221.g63MLOp02570@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Pete Zaitcev <zaitcev@redhat.com>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.22] simple ide-tape.c and ide-floppy.c cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jul 2002 18:21:24 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >[...]
> > To be honest - why keep ide-[cd,floppy,tape] when they can be almost
> > completely replaced with ide-scsi?

> James Bottomley was going to take care of this, so I did not
> even bother with ide-tape cleanups in 2.5. Good riddance for
> that crap.

Hey, you mean it's suddenly become my problem...?

I think I can clean up the SCSI upper layer drivers so they speak request prep 
functions which would translate the request (or ioctl) into the correct SCSI 
command and hand it back as a REQ_SPECIAL by 2.6

In order for this type of thing to be acceptable to the IDE subsystem, the 
attachment can't be a Scsi_Cmnd structure like it is now.  The plans I have to 
take a struct request all the way down to a SCSI host adapter and get rid of 
Scsi_Cmnd will probably finally make it possible to attach the st driver 
directly to an IDE device but this definitely won't make it in time for 2.6.

James


