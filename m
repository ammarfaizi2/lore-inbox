Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277803AbRKAD5f>; Wed, 31 Oct 2001 22:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277728AbRKAD50>; Wed, 31 Oct 2001 22:57:26 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:20744 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277803AbRKAD5M>;
	Wed, 31 Oct 2001 22:57:12 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15328.50963.299395.630022@cargo.ozlabs.ibm.com>
Date: Thu, 1 Nov 2001 14:52:51 +1100 (EST)
To: <alex.buell@tahallah.demon.co.uk>
Cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
In-Reply-To: <Pine.LNX.4.33.0110311958040.20237-100000@tahallah.demon.co.uk>
In-Reply-To: <20011031.103241.45747017.davem@redhat.com>
	<Pine.LNX.4.33.0110311958040.20237-100000@tahallah.demon.co.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Buell writes:

> No, the ioctl numbers are correct, it's ESD that's fscked.
> 
>     /* set the sound driver audio format for playback */
> #if defined(__powerpc__)
>     value = test = ( (esd_audio_format & ESD_MASK_BITS) == ESD_BITS16 )
>         ? /* 16 bit */ AFMT_S16_NE : /* 8 bit */ AFMT_U8;
> #else /* #if !defined(__powerpc__) */
>     value = test = ( (esd_audio_format & ESD_MASK_BITS) == ESD_BITS16 )
>         ? /* 16 bit */ AFMT_S16_LE : /* 8 bit */ AFMT_U8;
> #endif /* #if !defined(__powerpc__) */
> 
> <sarcasm>
> This is such a lovely piece of code!
> <sarcasm>

Indeed...

> Anyway, I can fix it now by adding the appropriate AFMT_S16_BE statement
> guarded by a #ifdef but this sucks. Thanks to Peter Jones who spotted this
> one.

Why can't you just use AFMT_S16_NE on all platforms?  That is supposed
to be equal to AFMT_S16_BE on big-endian platforms and to AFMT_S16_LE
on little-endian platforms.  NE == native endian.

Paul.
