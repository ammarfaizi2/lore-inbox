Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSDIStg>; Tue, 9 Apr 2002 14:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310749AbSDIStf>; Tue, 9 Apr 2002 14:49:35 -0400
Received: from mail.scs.ch ([212.254.229.5]:35303 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S310517AbSDISte>;
	Tue, 9 Apr 2002 14:49:34 -0400
Message-ID: <3CB337B4.EE569F52@scs.ch>
Date: Tue, 09 Apr 2002 20:49:24 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Thomas Sailer <sailer@ife.ee.ethz.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: USB audio device - ABIT UA11 dual toslink I/O
In-Reply-To: <E16ujqZ-0000W2-00@hoffman.vilain.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:

> usbaudio: unit 8: invalid PROCESSING_UNIT descriptor

Aparently this is due to a superfluous test in the audiocontrol
parsing...

> [pid  1892] ioctl(4, SNDCTL_DSP_RESET, 0) = 0
> [pid  1892] ioctl(4, SNDCTL_DSP_SYNC, 0) = 0
> [pid  1892] ioctl(4, SNDCTL_DSP_GETFMTS, 0xbffffc04) = 0
> [pid  1892] ioctl(4, SOUND_PCM_READ_BITS, 0xbffffc04) = 0
> [pid  1892] ioctl(4, SNDCTL_DSP_STEREO, 0xbffffc04) = 0
> [pid  1892] ioctl(4, SOUND_PCM_READ_RATE, 0xbffffc04) = 0
> [pid  1892] write(2, "sox: ", 5sox: )        = 5
> [pid  1892] write(2, "Unable to set audio speed to 441"..., 45Unable to set audio speed to 44100 (set to 0)) = 45

Spooky. It doesn't even try to set the sampling rate but complains...
somehow cannot be...

> ioctl(3, SOUND_PCM_READ_BITS, 0xbffffab0) = -1 EINVAL (Invalid argument)

Again spooky, I don't see how audio.o ioctl handler could return EINVAL
at
that call. EFAULT yes, but EINVAL??

Tom
