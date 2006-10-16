Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422883AbWJPTsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbWJPTsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 15:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWJPTsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 15:48:24 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:36530 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1422704AbWJPTsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 15:48:23 -0400
Date: Mon, 16 Oct 2006 15:29:38 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: raw1394 problems galore
In-reply-to: <4533B889.5060302@s5r6.in-berlin.de>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org,
       For users of Fedora Core releases 
	<fedora-list@redhat.com>,
       linux1394-user@lists.sourceforge.net
Message-id: <4533DDA2.2050008@verizon.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <4532DF11.9060704@verizon.net> <4533B889.5060302@s5r6.in-berlin.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> On 10/16/2006, Gene Heskett wrote to lkml and fedora-list:
>> Greetings all;
>>
>> After about 4 days of snooping around trying to get kino, either 08.xx 
>> or 0.9.2, to run here, I'm getting noplace at a very high rate of speed.
>>
>> System is an HP dv5120us lappy, with ddual boot of xp and FC5, with FC5 
>> about as uptodate as can be managed when the kmod stuff is always 1 or 2 
>> versions behind the kernel, so I'm still running 2.6.17-1.2174_FC5 for a 
>> kernel.
>>
>> Specifically, kino-0.8.0-2.lvn5.i386.rpm can receive and record a/v from 
>> my camera, a Sony TRV-460, but cannot control it via the av/c controls 
>> as it cannot 'see' a device to do the controls in the prefs->ieee1394 
>> screen.
> 
> Could be version problems between kernel--library--app. Maybe somebody
> else knows more about it. But it's more probably the same problem as the
> following:
> 
>> Then kino-0.9.2-1.lvn5.i386.rpm cannot even see the raw1394 interface, 
>> reporting on its screen that the raw1394 kernel module isn't loaded, or 
>> that it cannot read/write /dev/raw1394.
> 
> HP dv5120us is based on Turion 64. Do you run a 64bit kernel on it? Then
> the following bug may prevent access:
> http://bugzilla.kernel.org/show_bug.cgi?id=4779
> The bug has been fixed for read and write operations on /dev/raw1394 in
> Linux 2.6.17 (actually 2.6.16-git11).

No 64 bit kernels ever, this has always been a 32 bit install.

> The bug has _not_ been fixed yet for "ioctl" operations. The so-called
> rawiso interface for isochronous transmission and reception uses ioctls.
> I suppose the older Kino version could have slightly more success for
> you simply because it uses a different interface for iso transmission
> and reception.
> 
> My last comment in the bugzilla entry points to explanations on
> 64bit<-->32bit compatibility code for ioctls, in case anybody feels up
> to hack the kernel and contribute the rest of the fix.
> 
> Gene, if you run a 64bit kernel, check if you could switch to a 32bit
> kernel --- if only to confirm or deny that this is indeed the bug that
> is biting your setup. Another thing to try is to test whether gscanbus
> or 1394commander can work with raw1394. But as the _very first step_,
> check the kernel log for messages from the 1394 drivers.
After last reboot, having reset udev.conf for err only, as debug is so 
verbose it prevents booting if wlan0 is enabled.

Oct 16 11:16:31 diablo kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI): 
IRQ=[10]  MMIO=[c0209000-c02097ff]  Max Packet=[2048]  IR/IT contexts=[
4/8]

Then, manually loaded via 'modprobe raw1394':

Oct 16 11:50:11 diablo kernel: ieee1394: raw1394: /dev/raw1394 device 
initialized
Oct 16 11:50:11 diablo kernel: audit(1161013811.874:4): avc:  denied  { 
getattr } for  pid=2753 comm="pam_console_app" name="raw1394" dev=tmpfs
  ino=10625 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255 
tcontext=system_u:object_r:device_t:s0 tclass=chr_file
Oct 16 11:50:11 diablo kernel: audit(1161013811.874:5): avc:  denied  { 
setattr } for  pid=2753 comm="pam_console_app" name="raw1394" dev=tmpfs
  ino=10625 scontext=system_u:system_r:pam_console_t:s0-s0:c0.c255 
tcontext=system_u:object_r:device_t:s0 tclass=chr_file

SELinux is in permissive mode, and /dev/raw1394 has perms of:
[root@diablo ~]# ls -l /dev/raw1394
crw-rw-rw- 1 root root 171, 0 Oct 16 11:50 /dev/raw1394

As I had given up, the camera is packed away, but I'll get it out and 
connect it again for grins:

And no further messages were logged when I plugged it in and turned it on.

kino-0.8 receives video from it in real time and is doing so right now, 
and can capture it to file, and then play/edit that file, or could 
saturday when I last tried it.  I ASSume that kino-0.9.2 could also 
play/edit that file, but have not verified that by reinstalling 0.9.2.

>> The module is loaded when the cable is plugged in, and the 
>> /etc/security/console.perms.d/50-defaults has been edited so that 
>> /dev/raw1394 as created by the hotplug event now has these perms:
>> crw-rw-rw- 1 root root 171, 0 Oct 15 20:20 /dev/raw1394
>>
>> This has had no effect on the performance of either version of kino.
>>
>> So when do we actually get a functioning firewire interface, which we 
>> DID have 18 months ago in FC2,
> 
> Did you run FC2 as 32bit environment on 32bit kernel?

Yes, and kino-0.7.5 died with kernel changes in the ieee1394 code 
someplace at about 2.6.9 IIRC.  That FC2 box is my kernel test box, is 
950 miles SE of me in West Virginia and powered down ATM, but its 
running 2.6.19-rc1 just fine except for the ieee1394 problems.  That was 
why I thought I'd see if I could make it work here on my lappy with FC5 
and release kernels. I upgraded from kernel-2.6.17-1.2174_FC5 to 
kernel-2.6.17-1.2187_FC5 this morning with no detectable difference.

>> before someone just had to rewrite the 1394 stuff again?
> 
> The 1394 kernel drivers are not being rewritten.

I was told it was a total rewrite of bad code when I complained about a 
year ago.  My reply at the time was that it worked, and I don't often 
fix things that are working.  I'm getting lazy in my dotage I guess.

  We just discover old
> bugs, try to fix them on a rather slow rate, and sometimes introduce
> regressions along with bug fixes. (We try not to do so, but there is
> weird hardware out there.) I think similar things can be said about the
> status quo of libraw1394's development; minus the regressions I hope. I
> don't know about the other libraries and about the status of the
> application software. The last big "rewrite" concerning the whole stack
> from kernel to apps was the addition of the rawiso programming
> interface, which was quite a long time ago, but migration of application
> programs to it seems to be a still ongoing process, including
> deployment. (Even Linux 2.4 has the rawiso interface.)
> 
> (I added linux1394-user to the Cc list. You don't need to subscribe
> there; just keep all Ccs during the discussion.)

As for 1394commander or gscanbus, I have not managed to find rpms of 
those in any of the repos yumex or SPM shows me.  They apparently are 
not part of the FC5 tree.  I'd love to see what those 2 might have to 
say about the system.  The only thing I do have is dvcont, which reports 
this:

[root@diablo ~]# dvcont dev 0 play
Could not find any AV/C devices on the 1394 bus.

The camera is still plugged in and powered up.

Thanks Stefan.  Silly Q though, are you any kin to Thomas, a math prof 
at math-tu?  I've known him since back in my amiga days.

-- 
Cheers, Gene

