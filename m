Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWH1VGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWH1VGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWH1VGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:06:25 -0400
Received: from lucidpixels.com ([66.45.37.187]:1174 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932121AbWH1VGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:06:24 -0400
Date: Mon, 28 Aug 2006 17:06:23 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       debian-user@lists.debian.org
Subject: Re: 2.6.17.6 i810 + drm:810_wait_ring - kernel crash, help?
In-Reply-To: <20060828194545.GA24282@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.64.0608281705050.30867@p34.internal.lan>
References: <Pine.LNX.4.64.0608281515250.29490@p34.internal.lan>
 <Pine.LNX.4.64.0608281520120.29490@p34.internal.lan>
 <20060828194545.GA24282@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 28 Aug 2006, Andreas Mohr wrote:

> Hi,
>
> On Mon, Aug 28, 2006 at 03:20:32PM -0400, Justin Piszcz wrote:
>> Alan, you seemed to have worked with this issue before?
>>
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0303.0/0644.html
>>
>> Any idea to its root cause?
>
> This is an old issue that has been discussed too many times on the
> internet ("i810_wait_ring": 542 results). It's simply broken OpenGL/3D
> SMP locking in the i810 AGP or DRI/DRM (whatever) driver module
> which thus fails catastrophically sometimes on SMT/SMP machines
> after OpenGL got invoked.
>
> The solution IIRC is to not load the kernel module named i810something,
> but (if you need that functionality at all) the new, properly working
> i865(?) instead.
>
> Why I know all this? Don't ask, it's obvious... ;{
>
> Or are you asking what to *really* do about this unfortunate
> situation to make sure it can never happen again on any box?
>
> Andreas Mohr
>
>
> -- 
> To UNSUBSCRIBE, email to debian-user-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org
>

Strange, I am using the i810 in DRM option.  However, I am not using 
OpenGL anything and it is an older box that this problem occurred on.  A 
Dell Optiplex GX1 700MHZ P3 I believe.  Anyhow, I tried this work-around:

https://bugs.freedesktop.org/show_bug.cgi?id=1467

Will see if it crashes again..

------- Additional comment #4  from Tobias Preclik on 2005-01-01 07:55 
[reply] -------

Further investigations revealed that adding
Option "NoAccel" "true" to xorg.conf resolves the problem which means it's 
a dri
problem.

The following dmesg output occurs when the X server crashs:
[drm:i810_wait_ring] *ERROR* space: 65512 wanted 65528
[drm:i810_wait_ring] *ERROR* lockup
[drm:i810_wait_ring] *ERROR* space: 65504 wanted 65528
[drm:i810_wait_ring] *ERROR* lockup

And from time to time (I think it's when i'm switching consoles while the 
X
server hangs with a black screen):
[drm:i810_unlock] *ERROR* Process 6632 using kernel context 0

/var/log/Xorg.0.log contains one warning but no errors:
(WW) I810(0): Bad V_BIOS checksum

I'm allocating 12288KB VideoRam otherwise DRI does not work for me (at 
least not
with 8192 or no VideoRam setting in xorg.conf).

If you need further informations tell me please. Happy new year besides...
