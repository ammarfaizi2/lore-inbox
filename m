Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285451AbRLGLHO>; Fri, 7 Dec 2001 06:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285455AbRLGLHG>; Fri, 7 Dec 2001 06:07:06 -0500
Received: from [195.63.194.11] ([195.63.194.11]:22803 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S285451AbRLGLG4>; Fri, 7 Dec 2001 06:06:56 -0500
Message-ID: <3C10A057.BD8E1252@evision-ventures.com>
Date: Fri, 07 Dec 2001 11:56:23 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: dalecki@evision.ag, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16CINX-0005MC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > For example please grep for the MINOR() macro in the scsi layer...
> > Most of the places where it's used should be replaced by a simple
> > driver instance enumerator. I did this once already, so this is for
> > sure.
> 
> it become block_device->instance or ->minor

Well if all the infromation those functions are needing would
be already in block_device in place, that it could become as easy
as just passing &block_device there.
However please note that replacing kdev_t in the scsi layer
with just passing the minor can be done already *now* without
any pain. The same applies to the excessive MINOR lookups in the
v4l code. I did this already some time ago  (patch was here - about one
year ago)
 
> major/minors for old stuff still end up leaking into user space and
> mattering there. I'm not sure the best option for that

Thta's no problem. But they should be used as hash values no the
syscall implementation level and nowhere else.

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
