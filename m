Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263269AbTCNHfX>; Fri, 14 Mar 2003 02:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263271AbTCNHfX>; Fri, 14 Mar 2003 02:35:23 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:5388 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S263269AbTCNHfR>; Fri, 14 Mar 2003 02:35:17 -0500
Date: Fri, 14 Mar 2003 08:45:30 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.64: ioremap_nocache() failes with 1 gigabyte memory, works with 512 Mb?
Message-ID: <20030314074530.GA1673@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I reported a problem with the tdfxfb framebuffer yesterday, where it
said:

fb: Can't remap 3Dfx Voodoo5 register area.

when loading the module. On compiling the framebuffer into the kernel,
it oopsed.

Andrew Morton advised
> 
> http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/cset-1.1068.1.17-to-1.1104.txt.gz
> 
That file doesn't exist, but there exists a cset-1.1104.txt file. That's
about the framepointer and gcc-2.96, whereas I use 

Reading specs from /usr/lib/gcc-lib/i386-linux/3.2.3/specs
<snip>
gcc version 3.2.3 20030309 (Debian prerelease)

a somewhat more advanced version :-)

Anyway, since it fails as a module, I think I just get a failed call to
ioremap_nocache() in drivers/video/tdfxfb.c.

Now I added some information to the printk, and I now know:

fb: Can't remap 3Dfx Voodoo5 register area. (start d0000000 length 8000000)

If I boot my kernel with 'mem=512M' I can use the framebuffer just fine
(well, it doesn't work and writes funky patters to the screen, but at
least ioremap_nocache() works fine).

What is the reason ioremap_nocache() fails? Is this something that can
be prevented? I am not entirely clear on what is happening anyway (real
memory, virtual memory, nocache-memory, io-memory - a little bit above
my head :-) ).

Kind regards,
Jurriaan
-- 
A stone makes a splash when it strikes the water, Lisseut had thought,
standing by this same shore on the day she'd arrived near the end of
autumn, but no sound at all as it sinks down to the lake's deep bed.
	Guy Gavriel Kay - A Song for Narbonne
GNU/Linux 2.5.64 SMP/ReiserFS 3948 bogomips load av: 0.21 0.22 0.20
