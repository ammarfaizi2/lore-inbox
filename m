Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSKNHwa>; Thu, 14 Nov 2002 02:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264788AbSKNHwa>; Thu, 14 Nov 2002 02:52:30 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:24033 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S264786AbSKNHw2>; Thu, 14 Nov 2002 02:52:28 -0500
Date: Thu, 14 Nov 2002 00:02:36 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.5.47bk2 + current modutils == broken hotplug
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Message-id: <3DD3589C.5000002@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <20021114032456.46D742C09E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>What's the plan for getting that back?  (And module.conf
>>params etc.)
> 
> 
> The question is whether to force an /sbin/hotplug change to use the
> module alias mechanism, or generate the modules.*map files at "make
> modules_install" time to avoid breakage.  I'm leaning towards #2, but
> I haven't written it yet (should be simple).

Yes, please.  The kmod style aliasing presumes the answer to
"what do I do with this device?" is "load these modules", which
makes answers like "mount the disk" or "start this daemon/driver"
needlessly hard to achieve.

Hotplugging may well change more in 2.5, but I'd rather have it do
so on a more flexible schedule than "quick, before 2.5.48 ships"!  :)


> 0.7 has preliminary /etc/modprobe.conf support, but it only does
> primitive aliases not options as yet.  That's next on my list for
> userspace, along with "modprobe -r".
> 
> 
>>"Changes" says version 2.4.2 is fine, which appears to be wrong...
> 
> 
> Thanks for the feedback,

Thanks for the info ... it didn't seem very visible, so I wanted
to know what the story was!  Heck, I'm just glad to see forward
motion in the module load/unload area.

Is it true that the infrastructure newly in place can easily be
made to provide (from user-space) the policy of "driver remains
loaded until the devices it's bound to are all unplugged"?

That'd be a user-friendly policy, but we'd still need to handle
today's developer-oriented "sysadmin can always remove module"
policy.  (Me, I'd run with the "user friendly" policy except
when hacking a driver.  Then I'd debug/rmmod/update/modprobe.)

- Dave



> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 



