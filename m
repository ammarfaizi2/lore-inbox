Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280840AbRKTDU7>; Mon, 19 Nov 2001 22:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280845AbRKTDUt>; Mon, 19 Nov 2001 22:20:49 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:38286 "EHLO
	ihemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S280840AbRKTDUj>; Mon, 19 Nov 2001 22:20:39 -0500
Message-ID: <3BF9CC1B.70105@lucent.com>
Date: Mon, 19 Nov 2001 22:20:59 -0500
From: John Ellson <ellson@lucent.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011014
X-Accept-Language: en-us
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] "make modules_install" breaks with new /bin/cp
In-Reply-To: <3BF980F6.6080503@lucent.com> <200111192228.fAJMSUD32747@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

>John Ellson writes:
>
>>linux-2.4.15-pre6, fileutils-4.1.1-1.i386.rpm
>>
>>With my configuration (details not important), "make modules_install" results in:
>>
>>mkdir -p /lib/modules/2.4.15-pre6/kernel/drivers/sound/
>>cp soundcore.o sound.o cs4232.o ad1848.o pss.o ad1848.o mpu401.o cs4232.o uart401.o ad1848.o mpu401.o uart6850.o 
>>v_midi.o btaudio.o /lib/modules/2.4.15-pre6/kernel/drivers/sound/
>>cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/ad1848.o' with `ad1848.o'
>>cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/cs4232.o' with `cs4232.o'
>>cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/ad1848.o' with `ad1848.o'
>>cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/sound/mpu401.o' with `mpu401.o'
>>make[2]: *** [_modinst__] Error 1
>>
>>This hasn't been a problem with earlier version of /bin/cp (upto
>>fileutils-4.1-4.i386.rpm in RH7.2), but /bin/cp from
>>fileutils-4.1.1-1.i386.rpm (in the Rawhide collection) is more
>>pedantic about multiple copies of the same file.
>>
>>This patch works around this "feature".  It would be better if the
>>Makefiles were changed to only install modules once, but thats a
>>deeper problem.
>>
>
>No, the fix is to upgrade to fileutils-4.1-4.i386.rpm. cp should not
>be complaining unless you ask it to. The default should be to do what
>you ask. For the same reason, cp does not have "cp -i" as the default
>behaviour.
>

Unfortunately 4.1.1 comes after 4.1, so what you suggest is a downgrade.

If you want to argue with the fileutils maintainers, please go ahead. 
 I'm just giving a heads-up to
linux-kernel folks that this problem is coming and offering a work-around.

I could agree that any behavior change to a 30 year old utility is a 
bug, even if some argue that
it is an improvement.  However, this is not the place to argue about cp.

I'm more concerned about the Makefile bug that installs modules multiple 
times.  Perhaps this is
fixed by Eric's CML, in which case all that is needed is a work-around 
for a while.

John



