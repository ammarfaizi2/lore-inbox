Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbUAKGNP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 01:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUAKGNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 01:13:14 -0500
Received: from smtpq3.home.nl ([213.51.128.198]:40940 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S265779AbUAKGNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 01:13:13 -0500
Message-ID: <4000E8AA.5040108@keyaccess.nl>
Date: Sun, 11 Jan 2004 07:09:46 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: trelane@digitasaru.net
CC: linux-kernel@vger.kernel.org
Subject: Re: SoundBlaster 64 AWE and 2.6.1-mm1?
References: <20040110191950.GD5002@digitasaru.net>
In-Reply-To: <20040110191950.GD5002@digitasaru.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Pingenot wrote:

> For some reason, while pnp detects the SoundBlaster card, it's not
>   recognized by ALSA for some reason, exactly as the CS4236 card was
>   (different machine, tho).
> Am I missing something?  Anyone using SoundBlaster 64 AWE under 2.6?

Yes, I am. If ALSA comletely ignores the card, it's likely that it
simply does not know it _should_ be driving it, that is, that it doesn't
list your card's PnP ID. You can check your card's ID(s) at:

cat /sys/bus/pnp/devices/01:??.O{0,1,2}

Example for my AWE64:

rene@7ixe4:~$ cat /sys/bus/pnp/devices/01:01.00/id
CTL0044
rene@7ixe4:~$ cat /sys/bus/pnp/devices/01:01.01/id
CTL7002
PNPb02f
rene@7ixe4:~$ cat /sys/bus/pnp/devices/01:01.02/id
CTL0023

That second device is the gameport and will be picked up by ns558.c
through the "compatible device" PNPb02f ID, but you'll need the 00
(SB/MPU/OPL part) and the 02 ID (wavetable) listed in
sound/isa/sb/sb16.c. Add them to the snd_sb16_pnpids[] table in that file.

Hope this helps,
Rene.


