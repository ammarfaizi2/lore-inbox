Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262041AbRENB2O>; Sun, 13 May 2001 21:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262043AbRENB2F>; Sun, 13 May 2001 21:28:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8744 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S262041AbRENB17>; Sun, 13 May 2001 21:27:59 -0400
To: "H . J . Lu" <hjl@lucon.org>
Cc: "David S. Miller" <davem@redhat.com>, alan@lxorguk.ukuu.org.uk,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8
In-Reply-To: <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <m1y9s1jbml.fsf@frodo.biederman.org> <20010513181006.A10057@lucon.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 May 2001 19:24:31 -0600
In-Reply-To: "H . J . Lu"'s message of "Sun, 13 May 2001 18:10:06 -0700"
Message-ID: <m1sni8k9io.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H . J . Lu" <hjl@lucon.org> writes:

> On Sun, May 13, 2001 at 01:24:18PM -0600, Eric W. Biederman wrote:
> > "H . J . Lu" <hjl@lucon.org> writes:
> > 
> > > It doesn't make any senses. When I specify CONFIG_IP_PNP and
> > > BOOTP/DHCP, I want a kernel with IP config using BOOTP/DHCP. I would
> > > expect IP config is turned for BOOTP/DHCP by default. You can turn
> > > it off by passing "ip=off" to kernel. Did I miss something?
> > 
> > Since you have to set the command line anyway ip=dhcp is no extra
> > burden and it lets you use the same kernel to boot of the harddrive etc.
> 
> Why do I have to set "ip=dhcp"? If I have selected CONFIG_IP_PNP and
> DHCP in my kernel configuration, should it be on by default?

I agree it isn't intuitive, and if nfsroot=xxx is specified it should
probably turn on if there is missing information.

But if you have to select the command line anyway....

Mostly I like the situation where I can compile it in and turn it on
when I need it, instead of having to do thing differently if it is
compiled in or not.

ip=on is all it really takes.

> > > > This same situation exists for 2.2.18 & 2.2.19 as well.
> > > > 
> > > > The only way to get long term stability out of this is to write
> > > > a user space client, you can put in a ramdisk.  One of these days...
> > > 
> > > It doesn't work with diskless machines which don't support ramdisk
> > > during boot.
> > 
> > I don't believe that is a real world situation.
> > 
> > I boot diskless all of time and supporting a ramdisk is trivial.  You
> > just a have a program that slaps a kernel a ramdisk, and some command
> > line arguments into a single image, along with a touch of adapter code
> > to set the kernel parameters correctly and then boot that.
> 
> Let me guess. Your diskless machines are mostly x86. 
Mostly, but not exclusively.

> Have you tried
> ramdisk on diskless alpha, arm, m68k, mips, ppc, sh, sparc, booting
> over network?

First the booting situation on linux with respect to multiple platform
sucks.  We pass parameters in weird ways on every platform.  The command
line is the only thing that stays mostly the same.  I'm looking at what
it takes to clean that up, so we can have multiplatform bootloaders.

I have implemented what it takes to attach a ramdisk, and if you can
boot an arbitrary kernel it isn't hard to have a program that attaches
a ramdisk.  

Now although I believe this is the right direction to go, you will
notice I ported the dhcp IP auto configuration from 2.2.19 to to 2.4.x
Buying a little more time to get this working.

Eric
