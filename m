Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291544AbSBTBvS>; Tue, 19 Feb 2002 20:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291533AbSBTBvJ>; Tue, 19 Feb 2002 20:51:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33029 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291578AbSBTBux>; Tue, 19 Feb 2002 20:50:53 -0500
Subject: Re: Moving fasync_struct into struct file?
To: kuznet@ms2.inr.ac.ru
Date: Wed, 20 Feb 2002 02:04:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au,
        davem@redhat.com, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
In-Reply-To: <200202191917.WAA28452@ms2.inr.ac.ru> from "kuznet@ms2.inr.ac.ru" at Feb 19, 2002 10:17:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dM74-0002Do-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We already clean up fasync structures on close,
> We do not.

Then fix your driver. All the drivers I looked at do stuff like this...
which seems to do the job nicely

static int close_pad(struct inode * inode, struct file * file)
{
        lock_kernel();
        fasync_pad(-1, file, 0);
        if (!--active)
                outb(0x30, current_params.io+2);  /* switch off digitiser */
        unlock_kernel();
        return 0;
}
