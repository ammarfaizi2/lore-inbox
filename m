Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266885AbUJBAhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266885AbUJBAhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 20:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266905AbUJBAhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 20:37:22 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:61651 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S266885AbUJBAhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 20:37:14 -0400
Message-ID: <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
In-Reply-To: <1096675930.27818.74.camel@krustophenia.net>
References: <1096675930.27818.74.camel@krustophenia.net>
Date: Sat, 2 Oct 2004 01:34:29 +0100 (WEST)
Subject: Re: [Alsa-devel] alsa-driver will not compile with kernel 
     2.6.9-rc2-mm4-S7
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 02 Oct 2004 00:37:12.0425 (UTC) FILETIME=[F52C4590:01C4A817]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> At first I thought my build was incorrect, but I reproduced this error
> with a clean build and ALSA CVS from today:
>
>   CC [M]  /home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3202:57: macro
> "io_remap_page_range" requires 5 arguments, but only 4 given
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c: In function
> `snd_pcm_lib_mmap_iomem':
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error:
> `io_remap_page_range' undeclared (first use in this function)
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error: (Each
> undeclared identifier is reported only once
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200: error: for
> each function it appears in.)
> make[3]: ***
> [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o] Error 1
> make[2]: *** [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore] Error 2
> make[1]: *** [_module_/home/rlrevell/cvs/alsa/alsa-driver/kbuild] Error 2
> make[1]: Leaving directory
> `/home/rlrevell/kernel-source/linux-2.6.9-rc2-mm4-S7'
> make: *** [compile] Error 2
>
> I am not sure if this is an ALSA issue or -mm4.  I suspect -mm4 because
> -mm3-S6 worked.  The VP patch does not seem to be involved.
>
> Lee
>

Good grief! I'm having this too, and I was desperate thinking I was the
only one, and ultimately offering the blame to gcc 3.4.1 which is what I'm
test-driving now on my laptop (Mdk 10.1c).

Now I remember that -mm4 has some issue about remap_page_range kernel
symbol being renamed to something else, which is breaking the build of
outsider modules (i.e. not the ones bundled under the kernel source tree).
Or so it seems.

Maybe someone on the lkml may have a clue and help here?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


