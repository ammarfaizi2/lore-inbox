Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311577AbSDCPzQ>; Wed, 3 Apr 2002 10:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312136AbSDCPzH>; Wed, 3 Apr 2002 10:55:07 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:9671 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S311577AbSDCPyu>; Wed, 3 Apr 2002 10:54:50 -0500
Date: Wed, 3 Apr 2002 18:54:49 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Evan Harris <eharris@puremagic.com>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with scsi tape drives (2.4.18) and soft error count
 (BusLogic, AIC7xxx)
In-Reply-To: <Pine.LNX.4.33.0204021513050.1454-100000@kinison.puremagic.com>
Message-ID: <Pine.LNX.4.44.0204031841010.1145-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002, Evan Harris wrote:

>
> Only one problem, I'm using devfs, so the major/minor means nothing.  But
> from looking at online docs, the normal name for the high bit devices is
> nst0, and that just happens to be the device I am using.
>
> But that does explain why the soft error count is always 0 after doing a
> tar, since tar closes the device when it's done, and you stated that it
> loses all history after that.  A subsequent call to mt would therefore
> report 0.
>
> I guess the only way to get the info is to hack a call to retrieve the soft
> errors into tar, but I was hoping to avoid that.
>
Quoting from README.st:

        The number of recovered errors since the previous status call
        is stored in the lower word of the field mt_erreg.

i.e., the number of recovered error is cleared when it is read with
MTIOCGET (e.g., mt status). It does not matter which one of the device
nodes pointing to the same drive you use.

Quoting from 'man st':

       mt_erreg   The only field defined in mt_erreg is the recovered error count
                  in the low 16  bits  (as  defined  by  MT_ST_SOFTERR_SHIFT  and
                  MT_ST_SOFTERR_MASK).   Due to inconsistencies in the way drives
                  report recovered errors, this count  is  often  not  maintained
                  (most  drives do not by default report soft errors but this can
                  be changed with a SCSI MODE SELECT command).

You should check that your drive is configured to report the soft errors.
This can be done using the mode page 01h (read-write error recovery page,
bit PER). Some drives don't support setting this bit to one. You should be
able to see the value of the bit and change it using the scsi tools
probably included in your distribution.

	Kai



