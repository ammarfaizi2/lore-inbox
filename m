Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311079AbSCMT3J>; Wed, 13 Mar 2002 14:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311072AbSCMT2x>; Wed, 13 Mar 2002 14:28:53 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:60677 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310990AbSCMT22>; Wed, 13 Mar 2002 14:28:28 -0500
Subject: Re: your mail
To: rlievin@free.fr (=?ISO-8859-1?Q?Romain_Li=E9vin?=)
Date: Wed, 13 Mar 2002 19:43:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Kernel List),
        torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), tim@cyberelk.net (Tim Waugh)
In-Reply-To: <1016047267.3c8fa6a3660e3@imp3-1.free.fr> from "=?ISO-8859-1?Q?Romain_Li=E9vin?=" at Mar 13, 2002 08:21:07 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lEeq-0007F3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It has been tested on x86 for almost 2 years and on Alpha & Sparc too with 
> various calculators.

One oddity - some other comments

> +static int tipar_open(struct inode *inode, struct file *file)
> +{
> +       unsigned int minor = minor(inode->i_rdev) - TIPAR_MINOR_0;
> +
> +       if (minor >= PP_NO)
> +               return -ENXIO;  
> +       
> +       init_ti_parallel(minor);
> +
> +       MOD_INC_USE_COUNT;

You should remove these and use in 2.4 + . Also what stops multiple
simultaneous runs of init_ti_parallel if two people open it at once ?


> +static unsigned int tipar_poll(struct file *file, poll_table * wait)
> +{
> +       unsigned int mask=0;
> +       return mask;
> +}

That seems unfinished ??

> +static int tipar_ioctl(struct inode *inode, struct file *file,
> +                      unsigned int cmd, unsigned long arg)
> +       case O_NONBLOCK:
> +               file->f_flags |= O_NONBLOCK;
> +               return 0;

O_NDELAY is set by fcntl - your driver never needs this.

> +       default:
> +               retval = -EINVAL;

SuS says -ENOTTY here (lots of drivers get this wrong still)

> +static long long tipar_lseek(struct file * file, long long offset, int origin)
> +{
> +       return -ESPIPE;
> +}

There is a generic no_llseek function

> +/* Major & minor number for character devices */
> +#define TIPAR_MAJOR   61

These don't appear to be officially assigned via lanana ?
