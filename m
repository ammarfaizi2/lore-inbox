Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292390AbSBBV1v>; Sat, 2 Feb 2002 16:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292393AbSBBV1m>; Sat, 2 Feb 2002 16:27:42 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:36108
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S292390AbSBBV12>; Sat, 2 Feb 2002 16:27:28 -0500
Message-Id: <5.1.0.14.2.20020202160450.00b05578@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Sat, 02 Feb 2002 16:23:03 -0500
To: linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: Re: apm.c and multiple battery slots
In-Reply-To: <1012656665.1379.15.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 08:30 AM 2/2/2002 -0500, you wrote:
>I am not the author, so the following is speculation.
>My guess is that apm_get_battery_status() was written to
>support multiple batteries (supported by APM 1.2 only) but
>that the authors never got around to providing a user
>interface to this functionality; so it remains ifdeffed out.
>(Hence the function never "stopped" being used.)
>
>The current official maintainer of the driver is Stephen Rothwell.
>
>Stephen: How do you think the info about the second battery
>might be furnished to the user?

I already thought about that a bit... what if we changed /proc/apm again, 
adding one line for each possible battery slot?

The current format is:

<driver version> <BIOS version> <APM flags> <AC status> <battery status> 
<battery flag> <battery left (%)> <remaining time> <remaining time units 
(min/sec)>

I suggest we change the first line to reflect an overall battery status 
(i.e. average of all slots in system). Then we could add one line for each 
battery slot, indicating
<battery status> <battery flag> <battery left % > <remaining time in seconds>

I suggest we always show the new stuff in seconds because I like easily 
parsed things, and even shell scripts can divide by 60 if they want to ;)

If there's no battery in this slot, we can show the usual of -1's, or just 
put "? ? ? ?".

So on my system, I would see this if I did

$ cat /proc/apm
1.16 1.2 0x03 0x01 0x03 0x09 94% 283 min
0x04 0x80 -1 -1
0x03 0x09 94 16980

Whoever manages apmd also probably has some suggestions...

(btw, "Stephen" is a really great name ;)


--
Stevie-O

Real programmers use COPY CON VMLINUZ then run LoadLin

