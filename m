Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269615AbUJGAN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269615AbUJGAN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269540AbUJGAN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:13:27 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:13323 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269511AbUJGAKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:10:21 -0400
Date: Thu, 7 Oct 2004 02:10:17 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PS2 mouse/kbd problems (gremlins?)
Message-ID: <20041007001017.GF4523@pclin040.win.tue.nl>
References: <1096998302l.5347l.0l@werewolf.able.es> <200410052332.34837.dtor_core@ameritech.net> <1097101822l.5054l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097101822l.5054l.0l@werewolf.able.es>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 10:30:22PM +0000, J.A. Magallon wrote:
> 
> On 2004.10.06, Dmitry Torokhov wrote:
> >On Tuesday 05 October 2004 12:45 pm, J.A. Magallon wrote:
> >> Hi all...
> >> 
> >> I got time to track my ps2 problems. I run 2.6.9-rc2-mm[123] (that was
> >> enough).
> >> 
> >> Results:
> >> - mm1: mouse and kbd work ok, both in console and X
> >> - mm2: mouse works, no kbd. I had to unplug/plug the keyboard to get it
> >>   responding.
> >> - mm3: kbd ok, but ps2 mouse is sluggish.
> >> 
> >> In latest -rc3-mm2, behavior is like mm3 and above.
> >> 
> >
> >What about vanilla -rc3 and vanilla -rc3 with bk-input patch applied (if 
> >you
> >have some time of course). Do they exibit the same symptoms as -mm tree?
> >
> 
> Both rc3 and rc3-bk.input work. Even rc3-mm2 works, depending on how I boot 
> ;).
> This is getting really strange....look:
> 
> lrwxrwxrwx  1 root root      21 2004.10.05 14:16 vmlinuz -> 
> vmlinuz-2.6.9-rc3-mm2
> 
> lilo.conf:
> default="linux"
> append="psmouse.proto=exps"
> image=/boot/vmlinuz
>    label="linux"
> ...
> image=/boot/vmlinuz-2.6.9-rc3-mm2
>    label="linux-2.6.9-rc3-mm2"
> 
> If I boot with the default entry, mouse does not work. If I boot with
> the specific entry in lilo for rc3-mm2, it works.
> 
> dmesg diff:
> -Kernel command line: BOOT_IMAGE=linux ro root=801 psmouse.proto=exps 3
> +Kernel command line: BOOT_IMAGE=linux-2.6.9-rc3-mm2 ro root=801 
> 
> Somebody understands this ? Are there gremlins in my box ?

A week or so ago I had a problem and couldnt see which changeset
caused it. After a binary search it turned out to be the changeset
that changed the (length of the) kernel version string.
A wild pointer was harmless at first, but after shifting everything
by a few bytes it caused crashes.

Probably (hopefully) your problem is something entirely different,
but it is not impossible that kernel behaviour depends on kernel name.
