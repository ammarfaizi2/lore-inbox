Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWDZF4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWDZF4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 01:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWDZF4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 01:56:03 -0400
Received: from wproxy.gmail.com ([64.233.184.236]:32851 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750750AbWDZF4C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 01:56:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lyiEV0O2MLyqJGC43E/qyPNXOgYpYDcMxnjHhDEy3qSllfKFVyO1/LGX2IA0kCwKWyIc0WSMefDqnqmYN+wwtWJGcnzbD66WPpy1U10EDHUVolSkftTNK4Dl+ISYraps5QHuNXlTBL5zs7sOJYvitjXVx+9uFoikVcSl196P0NA=
Message-ID: <21d7e9970604252256m7192ffeboa47c890fef4e4623@mail.gmail.com>
Date: Wed, 26 Apr 2006 15:56:01 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: PCI ROM resource allocation issue with 2.6.17-rc2
Cc: "Andrew Morton" <akpm@osdl.org>, "Matthew Reppert" <arashi@sacredchao.net>,
       linux-kernel@vger.kernel.org, "Dave Airlie" <airlied@linux.ie>,
       "Antonino A. Daplas" <adaplas@pol.net>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0604252158460.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1145851361.3375.20.camel@minerva>
	 <20060423222122.498a3dd2.akpm@osdl.org>
	 <Pine.LNX.4.64.0604240949330.3701@g5.osdl.org>
	 <21d7e9970604252028k2cb302fdr78cfc894b4678b02@mail.gmail.com>
	 <Pine.LNX.4.64.0604252158460.3701@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Note that the "transparent" really means that it forwards all IO resources
> even outside the windows, and the windows are really just for show.
>
> The kernel even used to totally ignore them, now it uses them as a hint
> and will _preferably_ put stuff inside the window for such bridges, if the
> windows have been set up (not all systems will even set up the windows at
> all).

Well X has support for it, but something like the quirk in the i386
fixups is needed to make it detect the Intel PCI bridge as a
transparent one..
> >
>
> It really shouldn't even matter where it ends up being enabled. Trying to
> move it into the bridge window is as good as anything else, since it was
> disabled to begin with (which means that you can't necessarily trust the
> location that it was disabled _at_ - the ffff0000 value could even be just
> what the firmware left it at after doing PCI BAR sizing, although I
> suspect that it's a perfectly valid address).

Well it does, as modprobing the DRM enables the device, and we store
the values in the DRM, X then goes and moves it... and the drm gets
annoyed later,

I still haven't tracked down the problem with the BIOS but I'm on its
trail now that I've fixed the PCI resource allocation..

Dave.
