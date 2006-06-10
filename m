Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWFJFxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWFJFxm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 01:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWFJFxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 01:53:42 -0400
Received: from nz-out-0102.google.com ([64.233.162.199]:43596 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932398AbWFJFxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 01:53:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iHNP7RrddhhKsoZOWKtfieZhThEL5vV32MK9zNzUaPQyo9w9uxIsDIj5gr+n8bF9PUxygRR6TWFdTu/MPUFj/iDlmKMwVTAqHe3StSSF/2pqP/jzg3gXodTbjVh5+qVFzUVCinpymyWPyaaM0DpU8FkOOV9vWs1YnS97TGePuVI=
Message-ID: <9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
Date: Sat, 10 Jun 2006 01:53:41 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file describing the feature
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <44893407.4020507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44893407.4020507@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> - Describe the characteristics of 2 general types of console drivers
> - How to use the sysfs to unbind and bind console drivers
> - Uses for this feature

I like this new binding feature and that for doing the work to make it
happen. It is definitely something I will use in the future.

>From the docs I see a distinction between system consoles and modular
consoles, can't all consoles be created equally? The only rule would
be, that if there is only a single console registered it can't be
unbound or unregistered. It shouldn't matter which console is the last
one left.

We have these console systems: dummy, serial, vga, mda, prom, sti,
newport, sisusb, fb, network (isn't there some way to use the net for
console?)

All of these console system could follow the same protocol for
registering/binding as the modular consoles so we would end up with a
single class of console, not modular vs system.
Of course some of these consoles are built in and are never going to
unregister themselves, but that doesn't meant that their binding
sequence has to be different from the modular systems.

For example I can easily see VGA being converted from built-in to
modular. There have also been times when I was working on video
drivers that I wanted to switch to a serial console. For symmetry
dummycon should be built into all systems.

As for the way the sysfs attribute works, in a similar situation in fb
I used two attributes. Maybe 'backends' which is a read only list of
available console systems. And 'backend' which is read/write. Copy one
of the names from 'backends' to 'backend' to swtich the active/bound
console. Cat 'backend' to see the active console. Any idea on a better
name than 'backend'?

cat /sys/class/tty/console/backends
vga
serial
dummy
fb

cat /sys/class/tty/console/backend
vga

echo fb >/sys/class/tty/console/backend

cat /sys/class/tty/console/backend
fb

-- 
Jon Smirl
jonsmirl@gmail.com
