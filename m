Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbTEISDX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTEISDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:03:23 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:14028 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263383AbTEISDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:03:16 -0400
Message-ID: <3EBBF00D.8040108@hotmail.com>
Date: Fri, 09 May 2003 11:14:37 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Torrey Hoffman <thoffman@arnor.net>
CC: Giuliano Pochini <pochini@shiny.it>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA busted in 2.5.69
References: <fa.j6n4o02.sl813a@ifi.uio.no> <fa.juutvqv.1inovpj@ifi.uio.no>
In-Reply-To: <fa.juutvqv.1inovpj@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman wrote:
> On Fri, 2003-05-09 at 01:09, Giuliano Pochini wrote:
> 
>>On 08-May-2003 Torrey Hoffman wrote:
>>
>>>ALSA isn't working for me in 2.5.69.  It appears to be because
>>>/proc/asound/dev is missing the control devices.
> 
> ...
> 
>>If you are not using devfs, you need to create the devices. There is a
>>script in the ALSA-driver package to do that. Otherwise I can't help
>>you because I never tried devfs and linux 2.5.x.
> 
> 
> No.  /dev/snd is a symbolic link to /proc/asound/dev,
> and that symbolic link was created by the script you mention.
> (I am not using devfs.)
> 
> So the missing "/dev/snd/controlC0" should actually be created
> by the ALSA modules in the proc filesystem as
> "/proc/asound/dev/controlC0".  But only the timer device is there.

Warning:  I'm no expert on any of this -- but -- I'm listening to sound
right now using 2.5.69 (with devfs) and this is what I see:

There are NO symlinks from /dev to /proc.  None.

/dev/snd and /dev/sound are real directories -- neither is a symlink.

#ls -l /dev/snd
total 0
crw-------    1 wa1ter   audio    116,   0 Dec 31  1969 controlC0
crw-------    1 wa1ter   audio    116,  32 Dec 31  1969 controlC1
crw-------    1 wa1ter   audio    116,  64 Dec 31  1969 controlC2
crw-------    1 wa1ter   audio    116,  96 Dec 31  1969 controlC3
crw-------    1 wa1ter   audio    116, 128 Dec 31  1969 controlC4
crw-------    1 wa1ter   audio    116, 160 Dec 31  1969 controlC5
crw-------    1 wa1ter   audio    116, 192 Dec 31  1969 controlC6
crw-------    1 wa1ter   audio    116, 224 Dec 31  1969 controlC7
crw-------    1 wa1ter   audio    116,  24 Dec 31  1969 pcmC0D0c
crw-------    1 wa1ter   audio    116,  16 Dec 31  1969 pcmC0D0p
crw-------    1 wa1ter   audio    116,  25 Dec 31  1969 pcmC0D1c
crw-------    1 wa1ter   audio    116,  17 Dec 31  1969 pcmC0D1p
crw-------    1 wa1ter   audio    116,   1 Dec 31  1969 seq
crw-------    1 wa1ter   audio    116,  33 Dec 31  1969 timer

#ls -l /dev/sound
total 0
crw-------    1 wa1ter   audio     14,  12 Dec 31  1969 adsp
crw-------    1 wa1ter   audio     14,   4 Dec 31  1969 audio
crw-------    1 wa1ter   audio     14,   3 Dec 31  1969 dsp
crw-------    1 wa1ter   audio     14,   0 Dec 31  1969 mixer
crw-------    1 wa1ter   audio     14,   1 Dec 31  1969 sequencer
crw-------    1 wa1ter   audio     14,   8 Dec 31  1969 sequencer2

#ls -l /dev/dsp
lr-xr-xr-x    1 root     root            9 May  9 10:33 /dev/dsp -> sound/dsp
#ls -l /dev/adsp
lr-xr-xr-x    1 root     root           10 May  9 10:33 /dev/adsp -> sound/adsp


Seems to me that any symlinks to /proc don't really belong in /dev.
Any opinions to the contrary?  (Remember:  my sound is working just fine.)




