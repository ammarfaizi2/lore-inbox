Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285618AbRLWJKN>; Sun, 23 Dec 2001 04:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285629AbRLWJKE>; Sun, 23 Dec 2001 04:10:04 -0500
Received: from pcow034o.blueyonder.co.uk ([195.188.53.122]:29712 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S285618AbRLWJJ6>;
	Sun, 23 Dec 2001 04:09:58 -0500
Message-ID: <T57ff5f6967ac1785ec1ea@pcow034o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: dcinege@psychosis.com, "Grover, Andrew" <andrew.grover@intel.com>,
        "'Alexander Viro'" <viro@math.psu.edu>
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sun, 23 Dec 2001 09:10:23 +0000
X-Mailer: KMail [version 1.3.1]
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D804@orsmsx111.jf.intel.com> <T57eadc70a6ac1785e2316@pcow024o.blueyonder.co.uk> <E16Hx23-000220-00@schizo.psychosis.com>
In-Reply-To: <E16Hx23-000220-00@schizo.psychosis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 December 2001 1:02 am, Dave Cinege wrote:
> On Wednesday 19 December 2001 4:34, James A Sutherland wrote:
> > Initramfs will do this, it seems. Alternatively, you might have to copy
> > some files into a tarball - oh, the stress! Oh, wait - you just compiled
> > 100+Mb of C source to make that kernel and the modules. Somehow, making a
> > tarball out of the modules doesn't seem too stressful to me.
>
> Do it for 15 production systems, each with varying hardware.
> Now do it again for kernel revision 2. Now again for rev 3. Now
> again for rev 1 of 2.4.17...

i.e. build kernel image and associated modules (you need to do that anyway). 
Then have a configuration file on each machine which drops the modules you 
need into a tarball.

Or have a configuration file which does precisely the same thing at boottime, 
with extra overhead in the boot loader.

> OR
>
> List the names of the modules for boot ONCE in the systems 'grub.conf'
> file, and just create a 'current' symlink each time you install
> a new kernel and modules. A simple user land util can parge depmod to
> give you to right order...no bloat needed.

Which you could also do with a standard shellscript in your initfs, thus 
avoiding any extra bootloader complexity at all.
 
> FYI I only ned create a 'vmlinuz' for new kernel install as it is.
> If I could do the same for modules, I wouldn't have a 1.3MB
> 'catch all' bzImage.

Eh? WTF does bzImage have to do with this? You can also standardise your set 
of modules: just build all the ones you need.

> > OK, make the conf file a shell script which copies the modules into a
> > tarball or initrd image.
>
> Oh that's nice, clean, and standardized! Again do it for 15 machines...

Remembering that in most cases loading drivers for hardware you don't have is 
harmless, I doubt the 15 all REQUIRE different sets of modules. You could 
probably get away with attempting to load a single set; the unneeded drivers 
will just fail to load.

> Many of you people spouting about 'kernel design' really need to get
> a clue about putting these things into real world practise, across
> mutiple machines, that must stay running...

If nonstop uptime is a requirement, you can't change kernel anyway, so what's 
the problem? :-)

(And here, at least, most of the hardware is deliberately homogenous: of the 
couple of thousand PCs in use, there are only half a dozen distinct hardware 
setups.)


James.
