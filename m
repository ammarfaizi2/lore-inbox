Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262023AbRETPBW>; Sun, 20 May 2001 11:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262024AbRETPBL>; Sun, 20 May 2001 11:01:11 -0400
Received: from smtp2.libero.it ([193.70.192.52]:16853 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id <S262023AbRETPBA>;
	Sun, 20 May 2001 11:01:00 -0400
Message-ID: <3B07DC23.F905DE7B@alsa-project.org>
Date: Sun, 20 May 2001 17:00:51 +0200
From: Abramo Bagnara <abramo@alsa-project.org>
Organization: Opera Unica
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: it, en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
In-Reply-To: <Pine.GSO.4.21.0105201034090.8940-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 20 May 2001, Abramo Bagnara wrote:
> 
> > > It may have several. Which one?
> >
> > Can you explain better this?
> 
> Example: console. You want to be able to pass font changes. I'm
> less than sure that putting them on the same channel as, e.g.,
> keyboard mapping changes is a good idea. We can do it, but I don't
> see why it's natural thing to do. Moreover, you already have
> /dev/vcs<n> and /dev/vcsa<n>. Can you explain what's the difference
> between them (per-VC channels) and keyboard mapping (also per-VC)?
> 
> Face it, we _already_ have more than one side band.

This does not imply it's necessarily a good idea.
We are comparing

echo "9600" > /proc/self/fd/0/speed (or /dev/ttyS0/speed)
echo "8" > /proc/self/fd/0/bits (or /dev/ttyS0/bits)

with 

echo -e "speed 9600\nbits 8" > /proc/self/fd/0/ioctl (or
/dev/ttyS0/ioctl).

My personal preference goes to the latter, but it's a matter of taste
(and convention choice)

(echo -n "keymap " ; cat keymap) > /dev/tty1/ioctl
(echo -n "font " ; cat font) > /dev/tty1/ioctl

This seems ugly to you?

> Moreover, we have channels that are not tied to a particular device -
> they are for a group of them. Example: setting timings for IDE controller.
> Sure, we can just say "open /dev/hda instead of /dev/hda5", but then we
> are back to the "find related file" problem you tried to avoid.

It does not seems appropriate to permit to change IDE timings using an
handle to a partition... nor it seems very safe under a permissions
point of view.

-- 
Abramo Bagnara                       mailto:abramo@alsa-project.org

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy

ALSA project               http://www.alsa-project.org
It sounds good!
