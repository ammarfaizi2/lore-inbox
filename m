Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVLKTtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVLKTtx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbVLKTtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:49:53 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:8375 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750850AbVLKTtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:49:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=Bl8sN25nY+G7mu6f4CQlffQ2QBPX4z/wVxCx7bYr3s7t1PD0f2ii17+qOyYrKXBUduHy/419WkdyuqxwBUspyPApn7lzfI6vYjrs3nCBI83hv9M8YW+F/yOPzgeC1nc7NL81R4ObSNU6QgL4pbo9mUVoS6AW3XZqXw/StvUljiQ=
Message-ID: <9a8748490512111149l358f18abuc7f0685413f75c06@mail.gmail.com>
Date: Sun, 11 Dec 2005 20:49:51 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Mouse stalls with 2.6.5-rc5-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
In-Reply-To: <200512111327.40578.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14029_11430063.1134330591593"
References: <9a8748490512110548h22889559ld81374f2626c3ed2@mail.gmail.com>
	 <200512111327.40578.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_14029_11430063.1134330591593
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 12/11/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Sunday 11 December 2005 08:48, Jesper Juhl wrote:
> > With 2.6.5-rc5-mm2 I'm getting regular mouse stalls for short periods
> > of time ~1sec
> > I'm also seeing this in dmesg :
> >
> > [  117.308573] psmouse.c: resync failed, issuing reconnect request
> > [  157.100063] psmouse.c: resync failed, issuing reconnect request
> > [  167.583936] psmouse.c: resync failed, issuing reconnect request
> > [  278.986267] psmouse.c: resync failed, issuing reconnect request
> > [  328.320242] psmouse.c: resync failed, issuing reconnect request
> > [  358.117414] psmouse.c: resync failed, issuing reconnect request
> > [  472.814321] psmouse.c: resync failed, issuing reconnect request
> > [  492.781941] psmouse.c: resync failed, issuing reconnect request
> > [  525.788327] psmouse.c: resync failed, issuing reconnect request
> > [  542.843044] psmouse.c: resync failed, issuing reconnect request
> > [  552.129681] psmouse.c: resync failed, issuing reconnect request
> >
> > The times correspond nicely to the mouse stalls, every time it stalls
> > I get a new line, so they are definately related.
> >
> > 2.6.5-rc5-git1 works flawlessly.
> > No hardware has changed.
> > Mouse is a Logitech MouseMan Wheel (M/N: M-BD53) connected to a
> > "Master View PRO" KVM switch.
> >
> > Comlete dmesg output, .config, ver_linux output, lspci output, lsusb
> > output and cat /proc/cpuinfo output attached. Please just ask if
> > anything else is needed.
> >
>
> Could you please do the following:
>
Sure thing.

> 1. echo 1 > /sys/modules/i8042/parameters/debug
> 2. switch away from your linux box
> 3. wait 5 seconds
> 4. Switch back to Linux box
> 5. Move mouse slightly
> 6. echo 0 > /sys/modules/i8042/parameters/debug
> 7. Send me dmesg
>
Find dmesg.txt attached.

> Also, does the resync fail if you are not using KVM and plug the mouse
> directly into the box.
>
well, unplugging the mouse from the KVM and plugging it into the PC's
PS/2 port directly resulted in this in dmesg :

[  567.297724] psmouse.c: Explorer Mouse at isa0060/serio1/input0 lost
synchronization, throwing 1 bytes away.
[  567.807251] psmouse.c: resync failed, issuing reconnect request
[  568.015721] logips2pp: Detected unknown logitech mouse model 87

and after that I see no more resync failed messages and the mouse doesn't s=
tall.


> To stop resync attempts do:
>
>         echo -n 0 > /sys/bus/serio/devices/serioX/resync_time
>
> where serioX is serio port asociated with your mouse.
>
This cures the problem nicely with no obvious ill effects with the
mouse plugged into the KVM...


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

------=_Part_14029_11430063.1134330591593
Content-Type: text/plain; name=dmesg.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.txt"

2.c: 00 <- i8042 (interrupt, AUX, 12) [245059]
[  268.723209] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245062]
[  268.727211] drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [245066]
[  268.729521] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245068]
[  268.732167] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245071]
[  268.734511] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245073]
[  268.738589] drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, AUX, 12) [245077]
[  268.741536] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245080]
[  268.743954] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245082]
[  268.746594] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245085]
[  268.750683] drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, AUX, 12) [245089]
[  268.753074] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245091]
[  268.755800] drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [245094]
[  268.758166] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245097]
[  268.762243] drivers/input/serio/i8042.c: 38 <- i8042 (interrupt, AUX, 12) [245101]
[  268.765188] drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12) [245104]
[  268.767606] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245106]
[  268.770243] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245109]
[  268.774328] drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [245113]
[  268.776719] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245115]
[  268.779446] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245118]
[  268.781805] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245120]
[  268.785807] drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [245124]
[  268.788128] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245127]
[  268.790744] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245129]
[  268.793115] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245132]
[  268.805335] drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [245144]
[  268.807592] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245146]
[  268.810065] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245148]
[  268.812687] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245151]
[  268.832976] drivers/input/serio/i8042.c: 28 <- i8042 (interrupt, AUX, 12) [245171]
[  268.835442] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245174]
[  268.837914] drivers/input/serio/i8042.c: ff <- i8042 (interrupt, AUX, 12) [245176]
[  268.840536] drivers/input/serio/i8042.c: 00 <- i8042 (interrupt, AUX, 12) [245179]
[  269.663493] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [246002]
[  269.666174] drivers/input/serio/i8042.c: 48 <- i8042 (interrupt, KBD, 1) [246005]
[  269.790491] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [246130]
[  269.795865] drivers/input/serio/i8042.c: c8 <- i8042 (interrupt, KBD, 1) [246135]
[  270.071305] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [246411]
[  270.073989] drivers/input/serio/i8042.c: 47 <- i8042 (interrupt, KBD, 1) [246413]
[  270.190480] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [246530]
[  270.195851] drivers/input/serio/i8042.c: c7 <- i8042 (interrupt, KBD, 1) [246535]
[  270.408755] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [246748]
[  270.411434] drivers/input/serio/i8042.c: 4d <- i8042 (interrupt, KBD, 1) [246751]
[  270.826578] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [247166]
[  270.829261] drivers/input/serio/i8042.c: 4d <- i8042 (interrupt, KBD, 1) [247169]
[  270.850274] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [247190]
[  270.855647] drivers/input/serio/i8042.c: cd <- i8042 (interrupt, KBD, 1) [247195]
[  271.181472] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [247522]
[  271.184159] drivers/input/serio/i8042.c: 4d <- i8042 (interrupt, KBD, 1) [247524]
[  271.285046] drivers/input/serio/i8042.c: e0 <- i8042 (interrupt, KBD, 1) [247625]
[  271.290420] drivers/input/serio/i8042.c: cd <- i8042 (interrupt, KBD, 1) [247631]
[  271.544161] drivers/input/serio/i8042.c: 0e <- i8042 (interrupt, KBD, 1) [247884]
[  271.625990] drivers/input/serio/i8042.c: 8e <- i8042 (interrupt, KBD, 1) [247966]
[  271.797235] drivers/input/serio/i8042.c: 0b <- i8042 (interrupt, KBD, 1) [248138]
[  271.886895] drivers/input/serio/i8042.c: 8b <- i8042 (interrupt, KBD, 1) [248227]
[  272.340276] drivers/input/serio/i8042.c: 1c <- i8042 (interrupt, KBD, 1) [248681]
[  322.148576] psmouse.c: resync failed, issuing reconnect request
[  376.604151] psmouse.c: resync failed, issuing reconnect request




------=_Part_14029_11430063.1134330591593--
