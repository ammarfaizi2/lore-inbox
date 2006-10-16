Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWJPViq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWJPViq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 17:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161104AbWJPViq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 17:38:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:49388 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1161101AbWJPVip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 17:38:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4533FBD8.7050101@s5r6.in-berlin.de>
Date: Mon, 16 Oct 2006 23:38:32 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
CC: linux-kernel@vger.kernel.org,
       For users of Fedora Core releases 
	<fedora-list@redhat.com>,
       linux1394-user@lists.sourceforge.net
Subject: Re: raw1394 problems galore
References: <4532DF11.9060704@verizon.net> <4533B889.5060302@s5r6.in-berlin.de> <4533DDA2.2050008@verizon.net>
In-Reply-To: <4533DDA2.2050008@verizon.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Stefan Richter wrote:
>> HP dv5120us is based on Turion 64. Do you run a 64bit kernel on it? Then
>> the following bug may prevent access:
>> http://bugzilla.kernel.org/show_bug.cgi?id=4779
...
> No 64 bit kernels ever, this has always been a 32 bit install.

Hmm.

...
> Oct 16 11:16:31 diablo kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
> IRQ=[10]  MMIO=[c0209000-c02097ff]  Max Packet=[2048]  IR/IT contexts=[
> 4/8]

There should be a message like "ieee1394: Host added: ID:BUS[0-00:1023]
 GUID..." shortly later. It's logged at kern.debug level though.

> Then, manually loaded via 'modprobe raw1394':
> 
> Oct 16 11:50:11 diablo kernel: ieee1394: raw1394: /dev/raw1394 device
> initialized

OK.

> Oct 16 11:50:11 diablo kernel: audit(1161013811.874:4): avc:  denied  {
> getattr } for  pid=2753 comm="pam_console_app" name="raw1394" dev=tmpfs
>  ino=10625 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
> tcontext=system_u:object_r:device_t:s0 tclass=chr_file
> Oct 16 11:50:11 diablo kernel: audit(1161013811.874:5): avc:  denied  {
> setattr } for  pid=2753 comm="pam_console_app" name="raw1394" dev=tmpfs
>  ino=10625 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255
> tcontext=system_u:object_r:device_t:s0 tclass=chr_file

I don't get what this is about. Who denies what?

> SELinux is in permissive mode, and /dev/raw1394 has perms of:
> [root@diablo ~]# ls -l /dev/raw1394
> crw-rw-rw- 1 root root 171, 0 Oct 16 11:50 /dev/raw1394
> 
> As I had given up, the camera is packed away, but I'll get it out and
> connect it again for grins:
> 
> And no further messages were logged when I plugged it in and turned it on.

There should be something like "ieee1394: Node added: ID:BUS[0-00:1023]
 GUID..." and that the host changed from 0-00 to 1-00 at kern.debug level.

> kino-0.8 receives video from it in real time and is doing so right now,
> and can capture it to file, and then play/edit that file, or could
> saturday when I last tried it.  I ASSume that kino-0.9.2 could also
> play/edit that file, but have not verified that by reinstalling 0.9.2.
...
>> Did you run FC2 as 32bit environment on 32bit kernel?
> 
> Yes, and kino-0.7.5 died with kernel changes in the ieee1394 code
> someplace at about 2.6.9 IIRC.
...
>>> before someone just had to rewrite the 1394 stuff again?
>>
>> The 1394 kernel drivers are not being rewritten.
> 
> I was told it was a total rewrite of bad code when I complained about a
> year ago.  My reply at the time was that it worked, and I don't often
> fix things that are working.  I'm getting lazy in my dotage I guess.

I don't remember what was changed at that time. Maybe that was the
addition of the new isochronous interface that I mentioned. The old one
was (is?) still there but maybe there were interactions... However this
is not related to the inability to issue AV/C commands, which are issued
asynchronously. I think though that your kino 0.8.x package is
configured to work isochronously via video1394(?) but asynchronously via
raw1394, and the kino 0.9.x package to do both via raw1394. But don't
take my word on it, I keep mistaking one interface for another. I never
used video cameras on FireWire myself.

> As for 1394commander or gscanbus, I have not managed to find rpms of
> those in any of the repos yumex or SPM shows me.  They apparently are
> not part of the FC5 tree.  I'd love to see what those 2 might have to
> say about the system.  The only thing I do have is dvcont, which reports
> this:
> 
> [root@diablo ~]# dvcont dev 0 play
> Could not find any AV/C devices on the 1394 bus.
> 
> The camera is still plugged in and powered up.

Anything under /sys/bus/ieee1394/devices?

It might be not too difficult to compile 1394commander since it doesn't
have many library dependencies; just libraw1394 (probably as -devel
package) and optionally readline. Gscanbus would show a bit more about
attached devices without resorting to magic commands but it is a bit
harder to compile, as a GUI program.
-- 
Stefan Richter
-=====-=-==- =-=- =----
http://arcgraph.de/sr/
