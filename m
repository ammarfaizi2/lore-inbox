Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280459AbRJaUAk>; Wed, 31 Oct 2001 15:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280461AbRJaUAb>; Wed, 31 Oct 2001 15:00:31 -0500
Received: from tahallah.demon.co.uk ([158.152.175.193]:14324 "EHLO
	tahallah.demon.co.uk") by vger.kernel.org with ESMTP
	id <S280459AbRJaUAU>; Wed, 31 Oct 2001 15:00:20 -0500
Date: Wed, 31 Oct 2001 20:00:22 +0000 (GMT)
From: Alex Buell <alex.buell@tahallah.demon.co.uk>
X-X-Sender: <alex@tahallah.demon.co.uk>
Reply-To: <alex.buell@tahallah.demon.co.uk>
To: "David S. Miller" <davem@redhat.com>
cc: <alex.buell@tahallah.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [sparc] Weird ioctl() bug in 2.2.19 (fwd)
In-Reply-To: <20011031.103241.45747017.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0110311958040.20237-100000@tahallah.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, David S. Miller wrote:

> I'm pretty sure the ioctl numbers are wrong, and that is what is
> causing the problem.

No, the ioctl numbers are correct, it's ESD that's fscked.

    /* set the sound driver audio format for playback */
#if defined(__powerpc__)
    value = test = ( (esd_audio_format & ESD_MASK_BITS) == ESD_BITS16 )
        ? /* 16 bit */ AFMT_S16_NE : /* 8 bit */ AFMT_U8;
#else /* #if !defined(__powerpc__) */
    value = test = ( (esd_audio_format & ESD_MASK_BITS) == ESD_BITS16 )
        ? /* 16 bit */ AFMT_S16_LE : /* 8 bit */ AFMT_U8;
#endif /* #if !defined(__powerpc__) */

<sarcasm>
This is such a lovely piece of code!
<sarcasm>

Anyway, I can fix it now by adding the appropriate AFMT_S16_BE statement
guarded by a #ifdef but this sucks. Thanks to Peter Jones who spotted this
one.

-- 
Come the revolution, humourless gits'll be first up against the wall.

http://www.tahallah.demon.co.uk

