Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262424AbULOSBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbULOSBI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 13:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbULOSBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 13:01:07 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:18057 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262426AbULOR6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 12:58:19 -0500
Date: Wed, 15 Dec 2004 09:58:06 -0800
From: Greg KH <greg@kroah.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/rmap.c:480 in 2.6.10-rc3-bk7
Message-ID: <20041215175805.GA9207@kroah.com>
References: <20041215011132.GA16099@kroah.com> <Pine.LNX.4.44.0412151656010.2704-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0412151656010.2704-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 15, 2004 at 05:23:14PM +0000, Hugh Dickins wrote:
> On Tue, 14 Dec 2004, Greg KH wrote:
> 
> Great you can duplicate it, useful info, thanks a lot.
> 
> I think it very likely that your page_remove_rmap BUGs are caused by
> the first idea that occurred to me, months back, which intervening
> reports didn't seem to fit with: PageReserved(page) when the page is
> mapped into userspace, but !PageReserved(page) when it gets unmapped.
> 
> Which would suggest some kind of refcounting bug in drivers/char/drm/,
> such that the reserved pages get unreserved and freed before their
> last unmap.  I've started looking for that, but drivers/char/drm/ is
> unfamiliar territory to me, so I'd be glad for someone to beat me to it.

Yeah, that's some scary code...

> It would be sensible to test out whether that hypothesis fits, so please
> rebuild a kernel with the patch below (for testing, on i386, only), and
> try out your procedure above.  But while running gish, before killing X,
> please take a copy of /proc/$(pidof gish)/maps to mail me.  Then when
> you kill X, there should be a number (perhaps an irritatingly large
> number: but because pages have been wrongly freed so perhaps reused,
> relying on a single page report seems unwise) of "Bad rmap" messages.
> Please mail all those along with gish's maps to me (may well be too
> much for lkml), I'll report back whether they confirm or refute the
> hypothesis.

Here's the files.  gish.map has the map file and I've put the dmesg
output inline below.

If there's anything else I can do to help out, please let me know.

thanks,

greg k-h


CLASS: Unregistering class device. ID = 'vcs7'
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcs7'
class_hotplug - name = vcs7
kobject_hotplug: /sbin/hotplug vc seq=971 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcs7 SUBSYSTEM=vc
udev[8649]: removing device node '/dev/vcc/7'
kobject vcs7: cleaning up
device class 'vcs7': release.
CLASS: Unregistering class device. ID = 'vcsa7'
kobject_hotplug
fill_kobj_path: path = '/class/vc/vcsa7'
class_hotplug - name = vcsa7
kobject_hotplug: /sbin/hotplug vc seq=972 HOME=/ PATH=/sbin:/bin:/usr/sbin:/usr/bin ACTION=remove DEVPATH=/class/vc/vcsa7 SUBSYSTEM=vc
udev[8657]: removing device node '/dev/vcc/a7'
kobject vcsa7: cleaning up
device class 'vcsa7': release.
Bad rmap in gish: page c1279380 flags 20000014 count 3 mapcount 0 addr b6913000 vm_flags 800fb
Bad rmap in gish: page c12793a0 flags 20000014 count 2 mapcount 0 addr b6914000 vm_flags 800fb
Bad rmap in gish: page c12793c0 flags 20000014 count 2 mapcount 0 addr b6915000 vm_flags 800fb
Bad rmap in gish: page c12793e0 flags 20000014 count 2 mapcount 0 addr b6916000 vm_flags 800fb
Bad rmap in gish: page c1279400 flags 20000014 count 1 mapcount 0 addr b6917000 vm_flags 800fb
Bad rmap in gish: page c1279420 flags 20000014 count 1 mapcount 0 addr b6918000 vm_flags 800fb
Bad rmap in gish: page c1279440 flags 20000014 count 1 mapcount 0 addr b6919000 vm_flags 800fb
Bad rmap in gish: page c1279460 flags 20000014 count 1 mapcount 0 addr b691a000 vm_flags 800fb
Bad rmap in gish: page c1279480 flags 20000014 count 1 mapcount 0 addr b691b000 vm_flags 800fb
Bad rmap in gish: page c12794a0 flags 20000014 count 1 mapcount 0 addr b691c000 vm_flags 800fb
Bad rmap in gish: page c12794c0 flags 20000014 count 1 mapcount 0 addr b691d000 vm_flags 800fb
Bad rmap in gish: page c12794e0 flags 20000014 count 1 mapcount 0 addr b691e000 vm_flags 800fb
Bad rmap in gish: page c1279500 flags 20000014 count 1 mapcount 0 addr b691f000 vm_flags 800fb
Bad rmap in gish: page c1279520 flags 20000014 count 1 mapcount 0 addr b6920000 vm_flags 800fb
Bad rmap in gish: page c1279540 flags 20000014 count 1 mapcount 0 addr b6921000 vm_flags 800fb
Bad rmap in gish: page c1279560 flags 20000014 count 1 mapcount 0 addr b6922000 vm_flags 800fb
Bad rmap in gish: page c1279580 flags 20000014 count 2 mapcount 0 addr b6923000 vm_flags 800fb
Bad rmap in gish: page c12795a0 flags 20000014 count 2 mapcount 0 addr b6924000 vm_flags 800fb
Bad rmap in gish: page c12795c0 flags 20000014 count 2 mapcount 0 addr b6925000 vm_flags 800fb
Bad rmap in gish: page c12795e0 flags 20000014 count 2 mapcount 0 addr b6926000 vm_flags 800fb
Bad rmap in gish: page c1279600 flags 20000014 count 2 mapcount 0 addr b6927000 vm_flags 800fb
Bad rmap in gish: page c1279620 flags 20000014 count 2 mapcount 0 addr b6928000 vm_flags 800fb
Bad rmap in gish: page c1279640 flags 20000014 count 2 mapcount 0 addr b6929000 vm_flags 800fb
Bad rmap in gish: page c1279660 flags 20000014 count 2 mapcount 0 addr b692a000 vm_flags 800fb
Bad rmap in gish: page c1279680 flags 20000014 count 2 mapcount 0 addr b692b000 vm_flags 800fb
Bad rmap in gish: page c12796a0 flags 20000014 count 2 mapcount 0 addr b692c000 vm_flags 800fb
Bad rmap in gish: page c12796c0 flags 20000014 count 2 mapcount 0 addr b692d000 vm_flags 800fb
Bad rmap in gish: page c12796e0 flags 20000014 count 2 mapcount 0 addr b692e000 vm_flags 800fb
Bad rmap in gish: page c1279700 flags 20000014 count 2 mapcount 0 addr b692f000 vm_flags 800fb
Bad rmap in gish: page c1279720 flags 20000014 count 2 mapcount 0 addr b6930000 vm_flags 800fb
Bad rmap in gish: page c1279740 flags 20000014 count 2 mapcount 0 addr b6931000 vm_flags 800fb
Bad rmap in gish: page c1279760 flags 20000014 count 2 mapcount 0 addr b6932000 vm_flags 800fb
Bad rmap in gish: page c1279780 flags 20000014 count 2 mapcount 0 addr b6933000 vm_flags 800fb
Bad rmap in gish: page c12797a0 flags 20000014 count 2 mapcount 0 addr b6934000 vm_flags 800fb
Bad rmap in gish: page c12797c0 flags 20000014 count 2 mapcount 0 addr b6935000 vm_flags 800fb
Bad rmap in gish: page c12797e0 flags 20000014 count 2 mapcount 0 addr b6936000 vm_flags 800fb
Bad rmap in gish: page c1279800 flags 20000014 count 2 mapcount 0 addr b6937000 vm_flags 800fb
Bad rmap in gish: page c1279820 flags 20000014 count 2 mapcount 0 addr b6938000 vm_flags 800fb
Bad rmap in gish: page c1279840 flags 20000014 count 2 mapcount 0 addr b6939000 vm_flags 800fb
Bad rmap in gish: page c1279860 flags 20000014 count 2 mapcount 0 addr b693a000 vm_flags 800fb
Bad rmap in gish: page c1279880 flags 20000014 count 2 mapcount 0 addr b693b000 vm_flags 800fb
Bad rmap in gish: page c12798a0 flags 20000014 count 2 mapcount 0 addr b693c000 vm_flags 800fb
Bad rmap in gish: page c12798c0 flags 20000014 count 2 mapcount 0 addr b693d000 vm_flags 800fb
Bad rmap in gish: page c12798e0 flags 20000014 count 2 mapcount 0 addr b693e000 vm_flags 800fb
Bad rmap in gish: page c1279900 flags 20000014 count 2 mapcount 0 addr b693f000 vm_flags 800fb
Bad rmap in gish: page c1279920 flags 20000014 count 2 mapcount 0 addr b6940000 vm_flags 800fb
Bad rmap in gish: page c1279940 flags 20000014 count 2 mapcount 0 addr b6941000 vm_flags 800fb
Bad rmap in gish: page c1279960 flags 20000014 count 2 mapcount 0 addr b6942000 vm_flags 800fb
Bad rmap in gish: page c1279980 flags 20000014 count 2 mapcount 0 addr b6943000 vm_flags 800fb
Bad rmap in gish: page c12799a0 flags 20000014 count 2 mapcount 0 addr b6944000 vm_flags 800fb
Bad rmap in gish: page c12799c0 flags 20000014 count 2 mapcount 0 addr b6945000 vm_flags 800fb
Bad rmap in gish: page c12799e0 flags 20000014 count 2 mapcount 0 addr b6946000 vm_flags 800fb
Bad rmap in gish: page c1279a00 flags 20000014 count 2 mapcount 0 addr b6947000 vm_flags 800fb
Bad rmap in gish: page c1279a20 flags 20000014 count 2 mapcount 0 addr b6948000 vm_flags 800fb
Bad rmap in gish: page c1279a40 flags 20000014 count 2 mapcount 0 addr b6949000 vm_flags 800fb
Bad rmap in gish: page c1279a60 flags 20000014 count 2 mapcount 0 addr b694a000 vm_flags 800fb
Bad rmap in gish: page c1279a80 flags 20000014 count 2 mapcount 0 addr b694b000 vm_flags 800fb
Bad rmap in gish: page c1279aa0 flags 20000014 count 2 mapcount 0 addr b694c000 vm_flags 800fb
Bad rmap in gish: page c1279ac0 flags 20000014 count 2 mapcount 0 addr b694d000 vm_flags 800fb
Bad rmap in gish: page c1279ae0 flags 20000014 count 2 mapcount 0 addr b694e000 vm_flags 800fb
Bad rmap in gish: page c1279b00 flags 20000014 count 2 mapcount 0 addr b694f000 vm_flags 800fb
Bad rmap in gish: page c1279b20 flags 20000014 count 2 mapcount 0 addr b6950000 vm_flags 800fb
Bad rmap in gish: page c1279b40 flags 20000014 count 2 mapcount 0 addr b6951000 vm_flags 800fb
Bad rmap in gish: page c1279b60 flags 20000014 count 2 mapcount 0 addr b6952000 vm_flags 800fb
Bad rmap in gish: page c1279b80 flags 20000014 count 2 mapcount 0 addr b6953000 vm_flags 800fb
Bad rmap in gish: page c1279ba0 flags 20000014 count 2 mapcount 0 addr b6954000 vm_flags 800fb
Bad rmap in gish: page c1279bc0 flags 20000014 count 2 mapcount 0 addr b6955000 vm_flags 800fb
Bad rmap in gish: page c1279be0 flags 20000014 count 2 mapcount 0 addr b6956000 vm_flags 800fb
Bad rmap in gish: page c1279c00 flags 20000014 count 2 mapcount 0 addr b6957000 vm_flags 800fb
Bad rmap in gish: page c1279c20 flags 20000014 count 2 mapcount 0 addr b6958000 vm_flags 800fb
Bad rmap in gish: page c1279c40 flags 20000014 count 2 mapcount 0 addr b6959000 vm_flags 800fb
Bad rmap in gish: page c1279c60 flags 20000014 count 2 mapcount 0 addr b695a000 vm_flags 800fb
Bad rmap in gish: page c1279c80 flags 20000014 count 2 mapcount 0 addr b695b000 vm_flags 800fb
Bad rmap in gish: page c1279ca0 flags 20000014 count 2 mapcount 0 addr b695c000 vm_flags 800fb
Bad rmap in gish: page c1279cc0 flags 20000014 count 2 mapcount 0 addr b695d000 vm_flags 800fb
Bad rmap in gish: page c1279ce0 flags 20000014 count 2 mapcount 0 addr b695e000 vm_flags 800fb
Bad rmap in gish: page c1279d00 flags 20000014 count 2 mapcount 0 addr b695f000 vm_flags 800fb
Bad rmap in gish: page c1279d20 flags 20000014 count 2 mapcount 0 addr b6960000 vm_flags 800fb
Bad rmap in gish: page c1279d40 flags 20000014 count 2 mapcount 0 addr b6961000 vm_flags 800fb
Bad rmap in gish: page c1279d60 flags 20000014 count 2 mapcount 0 addr b6962000 vm_flags 800fb
Bad rmap in gish: page c1279d80 flags 20000014 count 2 mapcount 0 addr b6963000 vm_flags 800fb
Bad rmap in gish: page c1279da0 flags 20000014 count 2 mapcount 0 addr b6964000 vm_flags 800fb
Bad rmap in gish: page c1279dc0 flags 20000014 count 2 mapcount 0 addr b6965000 vm_flags 800fb
Bad rmap in gish: page c1279de0 flags 20000014 count 2 mapcount 0 addr b6966000 vm_flags 800fb
Bad rmap in gish: page c1279e00 flags 20000014 count 2 mapcount 0 addr b6967000 vm_flags 800fb
Bad rmap in gish: page c1279e20 flags 20000014 count 2 mapcount 0 addr b6968000 vm_flags 800fb
Bad rmap in gish: page c1279e40 flags 20000014 count 1 mapcount 0 addr b6969000 vm_flags 800fb
Bad rmap in gish: page c1279e60 flags 20000014 count 1 mapcount 0 addr b696a000 vm_flags 800fb
Bad rmap in gish: page c1279e80 flags 20000014 count 1 mapcount 0 addr b696b000 vm_flags 800fb
Bad rmap in gish: page c1279ea0 flags 20000014 count 1 mapcount 0 addr b696c000 vm_flags 800fb
Bad rmap in gish: page c1279ec0 flags 20000014 count 1 mapcount 0 addr b696d000 vm_flags 800fb
Bad rmap in gish: page c1279ee0 flags 20000014 count 1 mapcount 0 addr b696e000 vm_flags 800fb
Bad rmap in gish: page c1279f00 flags 20000014 count 1 mapcount 0 addr b696f000 vm_flags 800fb
Bad rmap in gish: page c1279f20 flags 20000014 count 1 mapcount 0 addr b6970000 vm_flags 800fb
Bad rmap in gish: page c1279f40 flags 20000014 count 1 mapcount 0 addr b6971000 vm_flags 800fb
Bad rmap in gish: page c1279f60 flags 20000014 count 1 mapcount 0 addr b6972000 vm_flags 800fb
Bad rmap in gish: page c1279f80 flags 20000014 count 2 mapcount 0 addr b6973000 vm_flags 800fb
Bad rmap in gish: page c1279fa0 flags 20000014 count 2 mapcount 0 addr b6974000 vm_flags 800fb
Bad rmap in gish: page c1279fc0 flags 20000014 count 2 mapcount 0 addr b6975000 vm_flags 800fb
Bad rmap in gish: page c1279fe0 flags 20000014 count 2 mapcount 0 addr b6976000 vm_flags 800fb
Bad rmap in gish: page c127a000 flags 20000014 count 2 mapcount 0 addr b6977000 vm_flags 800fb
Bad rmap in gish: page c127a020 flags 20000014 count 2 mapcount 0 addr b6978000 vm_flags 800fb
Bad rmap in gish: page c127a040 flags 20000014 count 2 mapcount 0 addr b6979000 vm_flags 800fb
Bad rmap in gish: page c127a060 flags 20000014 count 2 mapcount 0 addr b697a000 vm_flags 800fb
Bad rmap in gish: page c127a080 flags 20000014 count 2 mapcount 0 addr b697b000 vm_flags 800fb
Bad rmap in gish: page c127a0a0 flags 20000014 count 2 mapcount 0 addr b697c000 vm_flags 800fb
Bad rmap in gish: page c127a0c0 flags 20000014 count 2 mapcount 0 addr b697d000 vm_flags 800fb
Bad rmap in gish: page c127a0e0 flags 20000014 count 2 mapcount 0 addr b697e000 vm_flags 800fb
Bad rmap in gish: page c127a100 flags 20000014 count 2 mapcount 0 addr b697f000 vm_flags 800fb
Bad rmap in gish: page c127a120 flags 20000014 count 2 mapcount 0 addr b6980000 vm_flags 800fb
Bad rmap in gish: page c127a140 flags 20000014 count 2 mapcount 0 addr b6981000 vm_flags 800fb
Bad rmap in gish: page c127a160 flags 20000014 count 2 mapcount 0 addr b6982000 vm_flags 800fb
Bad rmap in gish: page c127a180 flags 20000014 count 2 mapcount 0 addr b6983000 vm_flags 800fb
Bad rmap in gish: page c127a1a0 flags 20000014 count 2 mapcount 0 addr b6984000 vm_flags 800fb
Bad rmap in gish: page c127a1c0 flags 20000014 count 2 mapcount 0 addr b6985000 vm_flags 800fb
Bad rmap in gish: page c127a1e0 flags 20000014 count 2 mapcount 0 addr b6986000 vm_flags 800fb
Bad rmap in gish: page c127a200 flags 20000014 count 2 mapcount 0 addr b6987000 vm_flags 800fb
Bad rmap in gish: page c127a220 flags 20000014 count 2 mapcount 0 addr b6988000 vm_flags 800fb
Bad rmap in gish: page c127a240 flags 20000014 count 2 mapcount 0 addr b6989000 vm_flags 800fb
Bad rmap in gish: page c127a260 flags 20000014 count 2 mapcount 0 addr b698a000 vm_flags 800fb
Bad rmap in gish: page c127a280 flags 20000014 count 2 mapcount 0 addr b698b000 vm_flags 800fb
Bad rmap in gish: page c127a2a0 flags 20000014 count 2 mapcount 0 addr b698c000 vm_flags 800fb
Bad rmap in gish: page c127a2c0 flags 20000014 count 2 mapcount 0 addr b698d000 vm_flags 800fb
Bad rmap in gish: page c127a2e0 flags 20000014 count 2 mapcount 0 addr b698e000 vm_flags 800fb
Bad rmap in gish: page c127a300 flags 20000014 count 2 mapcount 0 addr b698f000 vm_flags 800fb
Bad rmap in gish: page c127a320 flags 20000014 count 2 mapcount 0 addr b6990000 vm_flags 800fb
Bad rmap in gish: page c127a340 flags 20000014 count 2 mapcount 0 addr b6991000 vm_flags 800fb
Bad rmap in gish: page c127a360 flags 20000014 count 2 mapcount 0 addr b6992000 vm_flags 800fb
Bad rmap in gish: page c127a380 flags 20000014 count 2 mapcount 0 addr b6993000 vm_flags 800fb
Bad rmap in gish: page c127a3a0 flags 20000014 count 2 mapcount 0 addr b6994000 vm_flags 800fb
Bad rmap in gish: page c127a3c0 flags 20000014 count 2 mapcount 0 addr b6995000 vm_flags 800fb
Bad rmap in gish: page c127a3e0 flags 20000014 count 2 mapcount 0 addr b6996000 vm_flags 800fb
Bad rmap in gish: page c127a400 flags 20000014 count 2 mapcount 0 addr b6997000 vm_flags 800fb
Bad rmap in gish: page c127a420 flags 20000014 count 2 mapcount 0 addr b6998000 vm_flags 800fb
Bad rmap in gish: page c127a440 flags 20000014 count 2 mapcount 0 addr b6999000 vm_flags 800fb
Bad rmap in gish: page c127a460 flags 20000014 count 2 mapcount 0 addr b699a000 vm_flags 800fb
Bad rmap in gish: page c127a480 flags 20000014 count 2 mapcount 0 addr b699b000 vm_flags 800fb
Bad rmap in gish: page c127a4a0 flags 20000014 count 2 mapcount 0 addr b699c000 vm_flags 800fb
Bad rmap in gish: page c127a4c0 flags 20000014 count 2 mapcount 0 addr b699d000 vm_flags 800fb
Bad rmap in gish: page c127a4e0 flags 20000014 count 2 mapcount 0 addr b699e000 vm_flags 800fb
Bad rmap in gish: page c127a500 flags 20000014 count 2 mapcount 0 addr b699f000 vm_flags 800fb
Bad rmap in gish: page c127a520 flags 20000014 count 2 mapcount 0 addr b69a0000 vm_flags 800fb
Bad rmap in gish: page c127a540 flags 20000014 count 2 mapcount 0 addr b69a1000 vm_flags 800fb
Bad rmap in gish: page c127a560 flags 20000014 count 2 mapcount 0 addr b69a2000 vm_flags 800fb
Bad rmap in gish: page c127a580 flags 20000014 count 2 mapcount 0 addr b69a3000 vm_flags 800fb
Bad rmap in gish: page c127a5a0 flags 20000014 count 2 mapcount 0 addr b69a4000 vm_flags 800fb
Bad rmap in gish: page c127a5c0 flags 20000014 count 2 mapcount 0 addr b69a5000 vm_flags 800fb
Bad rmap in gish: page c127a5e0 flags 20000014 count 2 mapcount 0 addr b69a6000 vm_flags 800fb
Bad rmap in gish: page c127a600 flags 20000014 count 2 mapcount 0 addr b69a7000 vm_flags 800fb
Bad rmap in gish: page c127a620 flags 20000014 count 2 mapcount 0 addr b69a8000 vm_flags 800fb
Bad rmap in gish: page c127a640 flags 20000014 count 2 mapcount 0 addr b69a9000 vm_flags 800fb
Bad rmap in gish: page c127a660 flags 20000014 count 2 mapcount 0 addr b69aa000 vm_flags 800fb
Bad rmap in gish: page c127a680 flags 20000014 count 2 mapcount 0 addr b69ab000 vm_flags 800fb
Bad rmap in gish: page c127a6a0 flags 20000014 count 2 mapcount 0 addr b69ac000 vm_flags 800fb
Bad rmap in gish: page c127a6c0 flags 20000014 count 2 mapcount 0 addr b69ad000 vm_flags 800fb
Bad rmap in gish: page c127a6e0 flags 20000014 count 2 mapcount 0 addr b69ae000 vm_flags 800fb
Bad rmap in gish: page c127a700 flags 20000014 count 2 mapcount 0 addr b69af000 vm_flags 800fb
Bad rmap in gish: page c127a720 flags 20000014 count 2 mapcount 0 addr b69b0000 vm_flags 800fb
Bad rmap in gish: page c127a740 flags 20000014 count 2 mapcount 0 addr b69b1000 vm_flags 800fb
Bad rmap in gish: page c127a760 flags 20000014 count 2 mapcount 0 addr b69b2000 vm_flags 800fb
Bad rmap in gish: page c127a780 flags 20000014 count 2 mapcount 0 addr b69b3000 vm_flags 800fb
Bad rmap in gish: page c127a7a0 flags 20000014 count 2 mapcount 0 addr b69b4000 vm_flags 800fb
Bad rmap in gish: page c127a7c0 flags 20000014 count 2 mapcount 0 addr b69b5000 vm_flags 800fb
Bad rmap in gish: page c127a7e0 flags 20000014 count 1 mapcount 0 addr b69b6000 vm_flags 800fb
Bad rmap in gish: page c127a800 flags 20000014 count 1 mapcount 0 addr b69b7000 vm_flags 800fb
Bad rmap in gish: page c127a820 flags 20000014 count 1 mapcount 0 addr b69b8000 vm_flags 800fb
Bad rmap in gish: page c127a840 flags 20000014 count 1 mapcount 0 addr b69b9000 vm_flags 800fb
Bad rmap in gish: page c127a860 flags 20000014 count 1 mapcount 0 addr b69ba000 vm_flags 800fb
Bad rmap in gish: page c127a880 flags 20000014 count 1 mapcount 0 addr b69bb000 vm_flags 800fb
Bad rmap in gish: page c127a8a0 flags 20000014 count 1 mapcount 0 addr b69bc000 vm_flags 800fb
Bad rmap in gish: page c127a8c0 flags 20000014 count 1 mapcount 0 addr b69bd000 vm_flags 800fb
Bad rmap in gish: page c127a8e0 flags 20000014 count 1 mapcount 0 addr b69be000 vm_flags 800fb
Bad rmap in gish: page c127a900 flags 20000014 count 1 mapcount 0 addr b69bf000 vm_flags 800fb
Bad rmap in gish: page c127a920 flags 20000014 count 1 mapcount 0 addr b69c0000 vm_flags 800fb
Bad rmap in gish: page c127a940 flags 20000014 count 1 mapcount 0 addr b69c1000 vm_flags 800fb
Bad rmap in gish: page c127a960 flags 20000014 count 1 mapcount 0 addr b69c2000 vm_flags 800fb
Bad rmap in gish: page c127a980 flags 20000014 count 2 mapcount 0 addr b69c3000 vm_flags 800fb
Bad rmap in gish: page c127a9a0 flags 20000014 count 2 mapcount 0 addr b69c4000 vm_flags 800fb
Bad rmap in gish: page c127a9c0 flags 20000014 count 2 mapcount 0 addr b69c5000 vm_flags 800fb
Bad rmap in gish: page c127a9e0 flags 20000014 count 2 mapcount 0 addr b69c6000 vm_flags 800fb
Bad rmap in gish: page c127aa00 flags 20000014 count 2 mapcount 0 addr b69c7000 vm_flags 800fb
Bad rmap in gish: page c127aa20 flags 20000014 count 2 mapcount 0 addr b69c8000 vm_flags 800fb
Bad rmap in gish: page c127aa40 flags 20000014 count 2 mapcount 0 addr b69c9000 vm_flags 800fb
Bad rmap in gish: page c127aa60 flags 20000014 count 2 mapcount 0 addr b69ca000 vm_flags 800fb
Bad rmap in gish: page c127aa80 flags 20000014 count 2 mapcount 0 addr b69cb000 vm_flags 800fb
Bad rmap in gish: page c127aaa0 flags 20000014 count 2 mapcount 0 addr b69cc000 vm_flags 800fb
Bad rmap in gish: page c127aac0 flags 20000014 count 2 mapcount 0 addr b69cd000 vm_flags 800fb
Bad rmap in gish: page c127aae0 flags 20000014 count 2 mapcount 0 addr b69ce000 vm_flags 800fb
Bad rmap in gish: page c127ab00 flags 20000014 count 2 mapcount 0 addr b69cf000 vm_flags 800fb
Bad rmap in gish: page c127ab20 flags 20000014 count 2 mapcount 0 addr b69d0000 vm_flags 800fb
Bad rmap in gish: page c127ab40 flags 20000014 count 2 mapcount 0 addr b69d1000 vm_flags 800fb
Bad rmap in gish: page c127ab60 flags 20000014 count 2 mapcount 0 addr b69d2000 vm_flags 800fb
Bad rmap in gish: page c127ab80 flags 20000014 count 2 mapcount 0 addr b69d3000 vm_flags 800fb
Bad rmap in gish: page c127aba0 flags 20000014 count 2 mapcount 0 addr b69d4000 vm_flags 800fb
Bad rmap in gish: page c127abc0 flags 20000014 count 2 mapcount 0 addr b69d5000 vm_flags 800fb
Bad rmap in gish: page c127abe0 flags 20000014 count 2 mapcount 0 addr b69d6000 vm_flags 800fb
Bad rmap in gish: page c127ac00 flags 20000014 count 2 mapcount 0 addr b69d7000 vm_flags 800fb
Bad rmap in gish: page c127ac20 flags 20000014 count 2 mapcount 0 addr b69d8000 vm_flags 800fb
Bad rmap in gish: page c127ac40 flags 20000014 count 2 mapcount 0 addr b69d9000 vm_flags 800fb
Bad rmap in gish: page c127ac60 flags 20000014 count 2 mapcount 0 addr b69da000 vm_flags 800fb
Bad rmap in gish: page c127ac80 flags 20000014 count 2 mapcount 0 addr b69db000 vm_flags 800fb
Bad rmap in gish: page c127aca0 flags 20000014 count 2 mapcount 0 addr b69dc000 vm_flags 800fb
Bad rmap in gish: page c127acc0 flags 20000014 count 2 mapcount 0 addr b69dd000 vm_flags 800fb
Bad rmap in gish: page c127ace0 flags 20000014 count 2 mapcount 0 addr b69de000 vm_flags 800fb
Bad rmap in gish: page c127ad00 flags 20000014 count 2 mapcount 0 addr b69df000 vm_flags 800fb
Bad rmap in gish: page c127ad20 flags 20000014 count 2 mapcount 0 addr b69e0000 vm_flags 800fb
Bad rmap in gish: page c127ad40 flags 20000014 count 2 mapcount 0 addr b69e1000 vm_flags 800fb
Bad rmap in gish: page c127ad60 flags 20000014 count 2 mapcount 0 addr b69e2000 vm_flags 800fb
Bad rmap in gish: page c127ad80 flags 20000014 count 2 mapcount 0 addr b69e3000 vm_flags 800fb
Bad rmap in gish: page c127ada0 flags 20000014 count 2 mapcount 0 addr b69e4000 vm_flags 800fb
Bad rmap in gish: page c127adc0 flags 20000014 count 2 mapcount 0 addr b69e5000 vm_flags 800fb
Bad rmap in gish: page c127ade0 flags 20000014 count 2 mapcount 0 addr b69e6000 vm_flags 800fb
Bad rmap in gish: page c127ae00 flags 20000014 count 2 mapcount 0 addr b69e7000 vm_flags 800fb
Bad rmap in gish: page c127ae20 flags 20000014 count 2 mapcount 0 addr b69e8000 vm_flags 800fb
Bad rmap in gish: page c127ae40 flags 20000014 count 2 mapcount 0 addr b69e9000 vm_flags 800fb
Bad rmap in gish: page c127ae60 flags 20000014 count 2 mapcount 0 addr b69ea000 vm_flags 800fb
Bad rmap in gish: page c127ae80 flags 20000014 count 2 mapcount 0 addr b69eb000 vm_flags 800fb
Bad rmap in gish: page c127aea0 flags 20000014 count 2 mapcount 0 addr b69ec000 vm_flags 800fb
Bad rmap in gish: page c127aec0 flags 20000014 count 2 mapcount 0 addr b69ed000 vm_flags 800fb
Bad rmap in gish: page c127aee0 flags 20000014 count 2 mapcount 0 addr b69ee000 vm_flags 800fb
Bad rmap in gish: page c127af00 flags 20000014 count 2 mapcount 0 addr b69ef000 vm_flags 800fb
Bad rmap in gish: page c127af20 flags 20000014 count 2 mapcount 0 addr b69f0000 vm_flags 800fb
Bad rmap in gish: page c127af40 flags 20000014 count 2 mapcount 0 addr b69f1000 vm_flags 800fb
Bad rmap in gish: page c127af60 flags 20000014 count 2 mapcount 0 addr b69f2000 vm_flags 800fb
Bad rmap in gish: page c127af80 flags 20000014 count 2 mapcount 0 addr b69f3000 vm_flags 800fb
Bad rmap in gish: page c127afa0 flags 20000014 count 2 mapcount 0 addr b69f4000 vm_flags 800fb
Bad rmap in gish: page c127afc0 flags 20000014 count 2 mapcount 0 addr b69f5000 vm_flags 800fb
Bad rmap in gish: page c127afe0 flags 20000014 count 2 mapcount 0 addr b69f6000 vm_flags 800fb
Bad rmap in gish: page c127b000 flags 20000014 count 2 mapcount 0 addr b69f7000 vm_flags 800fb
Bad rmap in gish: page c127b020 flags 20000014 count 2 mapcount 0 addr b69f8000 vm_flags 800fb
Bad rmap in gish: page c127b040 flags 20000014 count 2 mapcount 0 addr b69f9000 vm_flags 800fb
Bad rmap in gish: page c127b060 flags 20000014 count 2 mapcount 0 addr b69fa000 vm_flags 800fb
Bad rmap in gish: page c127b080 flags 20000014 count 2 mapcount 0 addr b69fb000 vm_flags 800fb
Bad rmap in gish: page c127b0a0 flags 20000014 count 2 mapcount 0 addr b69fc000 vm_flags 800fb
Bad rmap in gish: page c127b0c0 flags 20000014 count 2 mapcount 0 addr b69fd000 vm_flags 800fb
Bad rmap in gish: page c127b0e0 flags 20000014 count 2 mapcount 0 addr b69fe000 vm_flags 800fb
Bad rmap in gish: page c127b100 flags 20000014 count 2 mapcount 0 addr b69ff000 vm_flags 800fb
Bad rmap in gish: page c127b120 flags 20000014 count 2 mapcount 0 addr b6a00000 vm_flags 800fb
Bad rmap in gish: page c127b140 flags 20000014 count 2 mapcount 0 addr b6a01000 vm_flags 800fb
Bad rmap in gish: page c127b160 flags 20000014 count 2 mapcount 0 addr b6a02000 vm_flags 800fb
Bad rmap in gish: page c127b180 flags 20000014 count 2 mapcount 0 addr b6a03000 vm_flags 800fb
Bad rmap in gish: page c127b1a0 flags 20000014 count 2 mapcount 0 addr b6a04000 vm_flags 800fb
Bad rmap in gish: page c127b1c0 flags 20000014 count 2 mapcount 0 addr b6a05000 vm_flags 800fb
Bad rmap in gish: page c127b1e0 flags 20000014 count 1 mapcount 0 addr b6a06000 vm_flags 800fb
Bad rmap in gish: page c127b200 flags 20000014 count 1 mapcount 0 addr b6a07000 vm_flags 800fb
Bad rmap in gish: page c127b220 flags 20000014 count 1 mapcount 0 addr b6a08000 vm_flags 800fb
Bad rmap in gish: page c127b240 flags 20000014 count 1 mapcount 0 addr b6a09000 vm_flags 800fb
Bad rmap in gish: page c127b260 flags 20000014 count 1 mapcount 0 addr b6a0a000 vm_flags 800fb
Bad rmap in gish: page c127b280 flags 20000014 count 1 mapcount 0 addr b6a0b000 vm_flags 800fb
Bad rmap in gish: page c127b2a0 flags 20000014 count 1 mapcount 0 addr b6a0c000 vm_flags 800fb
Bad rmap in gish: page c127b2c0 flags 20000014 count 1 mapcount 0 addr b6a0d000 vm_flags 800fb
Bad rmap in gish: page c127b2e0 flags 20000014 count 1 mapcount 0 addr b6a0e000 vm_flags 800fb
Bad rmap in gish: page c127b300 flags 20000014 count 1 mapcount 0 addr b6a0f000 vm_flags 800fb
Bad rmap in gish: page c127b320 flags 20000014 count 1 mapcount 0 addr b6a10000 vm_flags 800fb
Bad rmap in gish: page c127b340 flags 20000014 count 1 mapcount 0 addr b6a11000 vm_flags 800fb
Bad rmap in gish: page c127b360 flags 20000014 count 1 mapcount 0 addr b6a12000 vm_flags 800fb
Bad rmap in gish: page c127b380 flags 20000014 count 2 mapcount 0 addr b6a13000 vm_flags 800fb
Bad rmap in gish: page c127b3a0 flags 20000014 count 2 mapcount 0 addr b6a14000 vm_flags 800fb
Bad rmap in gish: page c127b3c0 flags 20000014 count 2 mapcount 0 addr b6a15000 vm_flags 800fb
Bad rmap in gish: page c127b3e0 flags 20000014 count 2 mapcount 0 addr b6a16000 vm_flags 800fb
Bad rmap in gish: page c127b400 flags 20000014 count 2 mapcount 0 addr b6a17000 vm_flags 800fb
Bad rmap in gish: page c127b420 flags 20000014 count 2 mapcount 0 addr b6a18000 vm_flags 800fb
Bad rmap in gish: page c127b440 flags 20000014 count 2 mapcount 0 addr b6a19000 vm_flags 800fb
Bad rmap in gish: page c127b460 flags 20000014 count 2 mapcount 0 addr b6a1a000 vm_flags 800fb
Bad rmap in gish: page c127b480 flags 20000014 count 2 mapcount 0 addr b6a1b000 vm_flags 800fb
Bad rmap in gish: page c127b4a0 flags 20000014 count 2 mapcount 0 addr b6a1c000 vm_flags 800fb
Bad rmap in gish: page c127b4c0 flags 20000014 count 2 mapcount 0 addr b6a1d000 vm_flags 800fb
Bad rmap in gish: page c127b4e0 flags 20000014 count 2 mapcount 0 addr b6a1e000 vm_flags 800fb
Bad rmap in gish: page c127b500 flags 20000014 count 2 mapcount 0 addr b6a1f000 vm_flags 800fb
Bad rmap in gish: page c127b520 flags 20000014 count 2 mapcount 0 addr b6a20000 vm_flags 800fb
Bad rmap in gish: page c127b540 flags 20000014 count 2 mapcount 0 addr b6a21000 vm_flags 800fb
Bad rmap in gish: page c127b560 flags 20000014 count 2 mapcount 0 addr b6a22000 vm_flags 800fb
Bad rmap in gish: page c127b580 flags 20000014 count 2 mapcount 0 addr b6a23000 vm_flags 800fb
Bad rmap in gish: page c127b5a0 flags 20000014 count 2 mapcount 0 addr b6a24000 vm_flags 800fb
Bad rmap in gish: page c127b5c0 flags 20000014 count 2 mapcount 0 addr b6a25000 vm_flags 800fb
Bad rmap in gish: page c127b5e0 flags 20000014 count 2 mapcount 0 addr b6a26000 vm_flags 800fb
Bad rmap in gish: page c127b600 flags 20000014 count 2 mapcount 0 addr b6a27000 vm_flags 800fb
Bad rmap in gish: page c127b620 flags 20000014 count 2 mapcount 0 addr b6a28000 vm_flags 800fb
Bad rmap in gish: page c127b640 flags 20000014 count 2 mapcount 0 addr b6a29000 vm_flags 800fb
Bad rmap in gish: page c127b660 flags 20000014 count 2 mapcount 0 addr b6a2a000 vm_flags 800fb
Bad rmap in gish: page c127b680 flags 20000014 count 2 mapcount 0 addr b6a2b000 vm_flags 800fb
Bad rmap in gish: page c127b6a0 flags 20000014 count 2 mapcount 0 addr b6a2c000 vm_flags 800fb
Bad rmap in gish: page c127b6c0 flags 20000014 count 2 mapcount 0 addr b6a2d000 vm_flags 800fb
Bad rmap in gish: page c127b6e0 flags 20000014 count 2 mapcount 0 addr b6a2e000 vm_flags 800fb
Bad rmap in gish: page c127b700 flags 20000014 count 2 mapcount 0 addr b6a2f000 vm_flags 800fb
Bad rmap in gish: page c127b720 flags 20000014 count 2 mapcount 0 addr b6a30000 vm_flags 800fb
Bad rmap in gish: page c127b740 flags 20000014 count 2 mapcount 0 addr b6a31000 vm_flags 800fb
Bad rmap in gish: page c127b760 flags 20000014 count 2 mapcount 0 addr b6a32000 vm_flags 800fb
Bad rmap in gish: page c127b780 flags 20000014 count 2 mapcount 0 addr b6a33000 vm_flags 800fb
Bad rmap in gish: page c127b7a0 flags 20000014 count 2 mapcount 0 addr b6a34000 vm_flags 800fb
Bad rmap in gish: page c127b7c0 flags 20000014 count 2 mapcount 0 addr b6a35000 vm_flags 800fb
Bad rmap in gish: page c127b7e0 flags 20000014 count 2 mapcount 0 addr b6a36000 vm_flags 800fb
Bad rmap in gish: page c127b800 flags 20000014 count 2 mapcount 0 addr b6a37000 vm_flags 800fb
Bad rmap in gish: page c127b820 flags 20000014 count 2 mapcount 0 addr b6a38000 vm_flags 800fb
Bad rmap in gish: page c127b840 flags 20000014 count 2 mapcount 0 addr b6a39000 vm_flags 800fb
Bad rmap in gish: page c127b860 flags 20000014 count 2 mapcount 0 addr b6a3a000 vm_flags 800fb
Bad rmap in gish: page c127b880 flags 20000014 count 2 mapcount 0 addr b6a3b000 vm_flags 800fb
Bad rmap in gish: page c127b8a0 flags 20000014 count 2 mapcount 0 addr b6a3c000 vm_flags 800fb
Bad rmap in gish: page c127b8c0 flags 20000014 count 2 mapcount 0 addr b6a3d000 vm_flags 800fb
Bad rmap in gish: page c127b8e0 flags 20000014 count 2 mapcount 0 addr b6a3e000 vm_flags 800fb
Bad rmap in gish: page c127b900 flags 20000014 count 2 mapcount 0 addr b6a3f000 vm_flags 800fb
Bad rmap in gish: page c127b920 flags 20000014 count 2 mapcount 0 addr b6a40000 vm_flags 800fb
Bad rmap in gish: page c127b940 flags 20000014 count 2 mapcount 0 addr b6a41000 vm_flags 800fb
Bad rmap in gish: page c127b960 flags 20000014 count 2 mapcount 0 addr b6a42000 vm_flags 800fb
Bad rmap in gish: page c127b980 flags 20000014 count 2 mapcount 0 addr b6a43000 vm_flags 800fb
Bad rmap in gish: page c127b9a0 flags 20000014 count 2 mapcount 0 addr b6a44000 vm_flags 800fb
Bad rmap in gish: page c127b9c0 flags 20000014 count 2 mapcount 0 addr b6a45000 vm_flags 800fb
Bad rmap in gish: page c127b9e0 flags 20000014 count 2 mapcount 0 addr b6a46000 vm_flags 800fb
Bad rmap in gish: page c127ba00 flags 20000014 count 2 mapcount 0 addr b6a47000 vm_flags 800fb
Bad rmap in gish: page c127ba20 flags 20000014 count 2 mapcount 0 addr b6a48000 vm_flags 800fb
Bad rmap in gish: page c127ba40 flags 20000014 count 2 mapcount 0 addr b6a49000 vm_flags 800fb
Bad rmap in gish: page c127ba60 flags 20000014 count 2 mapcount 0 addr b6a4a000 vm_flags 800fb
Bad rmap in gish: page c127ba80 flags 20000014 count 2 mapcount 0 addr b6a4b000 vm_flags 800fb
Bad rmap in gish: page c127baa0 flags 20000014 count 2 mapcount 0 addr b6a4c000 vm_flags 800fb
Bad rmap in gish: page c127bac0 flags 20000014 count 2 mapcount 0 addr b6a4d000 vm_flags 800fb
Bad rmap in gish: page c127bae0 flags 20000014 count 2 mapcount 0 addr b6a4e000 vm_flags 800fb
Bad rmap in gish: page c127bb00 flags 20000014 count 2 mapcount 0 addr b6a4f000 vm_flags 800fb
Bad rmap in gish: page c127bb20 flags 20000014 count 2 mapcount 0 addr b6a50000 vm_flags 800fb
Bad rmap in gish: page c127bb40 flags 20000014 count 2 mapcount 0 addr b6a51000 vm_flags 800fb
Bad rmap in gish: page c127bb60 flags 20000014 count 2 mapcount 0 addr b6a52000 vm_flags 800fb
Bad rmap in gish: page c127bb80 flags 20000014 count 2 mapcount 0 addr b6a53000 vm_flags 800fb
Bad rmap in gish: page c127bba0 flags 20000014 count 2 mapcount 0 addr b6a54000 vm_flags 800fb
Bad rmap in gish: page c127bbc0 flags 20000014 count 2 mapcount 0 addr b6a55000 vm_flags 800fb
Bad rmap in gish: page c127bbe0 flags 20000014 count 2 mapcount 0 addr b6a56000 vm_flags 800fb
Bad rmap in gish: page c127bc00 flags 20000014 count 2 mapcount 0 addr b6a57000 vm_flags 800fb
Bad rmap in gish: page c127bc20 flags 20000014 count 2 mapcount 0 addr b6a58000 vm_flags 800fb
Bad rmap in gish: page c127bc40 flags 20000014 count 2 mapcount 0 addr b6a59000 vm_flags 800fb
Bad rmap in gish: page c127bc60 flags 20000014 count 2 mapcount 0 addr b6a5a000 vm_flags 800fb
Bad rmap in gish: page c127bc80 flags 20000014 count 2 mapcount 0 addr b6a5b000 vm_flags 800fb
Bad rmap in gish: page c127bca0 flags 20000014 count 2 mapcount 0 addr b6a5c000 vm_flags 800fb
Bad rmap in gish: page c127bcc0 flags 20000014 count 2 mapcount 0 addr b6a5d000 vm_flags 800fb
Bad rmap in gish: page c127bce0 flags 20000014 count 2 mapcount 0 addr b6a5e000 vm_flags 800fb
Bad rmap in gish: page c127bd00 flags 20000014 count 2 mapcount 0 addr b6a5f000 vm_flags 800fb
Bad rmap in gish: page c127bd20 flags 20000014 count 2 mapcount 0 addr b6a60000 vm_flags 800fb
Bad rmap in gish: page c127bd40 flags 20000014 count 2 mapcount 0 addr b6a61000 vm_flags 800fb
Bad rmap in gish: page c127bd60 flags 20000014 count 2 mapcount 0 addr b6a62000 vm_flags 800fb
Bad rmap in gish: page c127bd80 flags 20000014 count 2 mapcount 0 addr b6a63000 vm_flags 800fb
Bad rmap in gish: page c127bda0 flags 20000014 count 2 mapcount 0 addr b6a64000 vm_flags 800fb
Bad rmap in gish: page c127bdc0 flags 20000014 count 2 mapcount 0 addr b6a65000 vm_flags 800fb
Bad rmap in gish: page c127bde0 flags 20000014 count 2 mapcount 0 addr b6a66000 vm_flags 800fb
Bad rmap in gish: page c127be00 flags 20000014 count 2 mapcount 0 addr b6a67000 vm_flags 800fb
Bad rmap in gish: page c127be20 flags 20000014 count 2 mapcount 0 addr b6a68000 vm_flags 800fb
Bad rmap in gish: page c127be40 flags 20000014 count 2 mapcount 0 addr b6a69000 vm_flags 800fb
Bad rmap in gish: page c127be60 flags 20000014 count 2 mapcount 0 addr b6a6a000 vm_flags 800fb
Bad rmap in gish: page c127be80 flags 20000014 count 2 mapcount 0 addr b6a6b000 vm_flags 800fb
Bad rmap in gish: page c127bea0 flags 20000014 count 2 mapcount 0 addr b6a6c000 vm_flags 800fb
Bad rmap in gish: page c127bec0 flags 20000014 count 2 mapcount 0 addr b6a6d000 vm_flags 800fb
Bad rmap in gish: page c127bee0 flags 20000014 count 2 mapcount 0 addr b6a6e000 vm_flags 800fb
Bad rmap in gish: page c127bf00 flags 20000014 count 2 mapcount 0 addr b6a6f000 vm_flags 800fb
Bad rmap in gish: page c127bf20 flags 20000014 count 2 mapcount 0 addr b6a70000 vm_flags 800fb
Bad rmap in gish: page c127bf40 flags 20000014 count 2 mapcount 0 addr b6a71000 vm_flags 800fb
Bad rmap in gish: page c127bf60 flags 20000014 count 2 mapcount 0 addr b6a72000 vm_flags 800fb
Bad rmap in gish: page c127bf80 flags 20000014 count 2 mapcount 0 addr b6a73000 vm_flags 800fb
Bad rmap in gish: page c127bfa0 flags 20000014 count 2 mapcount 0 addr b6a74000 vm_flags 800fb
Bad rmap in gish: page c127bfc0 flags 20000014 count 2 mapcount 0 addr b6a75000 vm_flags 800fb
Bad rmap in gish: page c127bfe0 flags 20000014 count 2 mapcount 0 addr b6a76000 vm_flags 800fb
Bad rmap in gish: page c127c000 flags 20000014 count 2 mapcount 0 addr b6a77000 vm_flags 800fb
Bad rmap in gish: page c127c020 flags 20000014 count 2 mapcount 0 addr b6a78000 vm_flags 800fb
Bad rmap in gish: page c127c040 flags 20000014 count 2 mapcount 0 addr b6a79000 vm_flags 800fb
Bad rmap in gish: page c127c060 flags 20000014 count 2 mapcount 0 addr b6a7a000 vm_flags 800fb
Bad rmap in gish: page c127c080 flags 20000014 count 2 mapcount 0 addr b6a7b000 vm_flags 800fb
Bad rmap in gish: page c127c0a0 flags 20000014 count 2 mapcount 0 addr b6a7c000 vm_flags 800fb
Bad rmap in gish: page c127c0c0 flags 20000014 count 2 mapcount 0 addr b6a7d000 vm_flags 800fb
Bad rmap in gish: page c127c0e0 flags 20000014 count 2 mapcount 0 addr b6a7e000 vm_flags 800fb
Bad rmap in gish: page c127c100 flags 20000014 count 2 mapcount 0 addr b6a7f000 vm_flags 800fb
Bad rmap in gish: page c127c120 flags 20000014 count 2 mapcount 0 addr b6a80000 vm_flags 800fb
Bad rmap in gish: page c127c140 flags 20000014 count 2 mapcount 0 addr b6a81000 vm_flags 800fb
Bad rmap in gish: page c127c160 flags 20000014 count 2 mapcount 0 addr b6a82000 vm_flags 800fb
Bad rmap in gish: page c127c180 flags 20000014 count 2 mapcount 0 addr b6a83000 vm_flags 800fb
Bad rmap in gish: page c127c1a0 flags 20000014 count 2 mapcount 0 addr b6a84000 vm_flags 800fb
Bad rmap in gish: page c127c1c0 flags 20000014 count 2 mapcount 0 addr b6a85000 vm_flags 800fb
Bad rmap in gish: page c127c1e0 flags 20000014 count 2 mapcount 0 addr b6a86000 vm_flags 800fb
Bad rmap in gish: page c127c200 flags 20000014 count 2 mapcount 0 addr b6a87000 vm_flags 800fb
Bad rmap in gish: page c127c220 flags 20000014 count 2 mapcount 0 addr b6a88000 vm_flags 800fb
Bad rmap in gish: page c127c240 flags 20000014 count 2 mapcount 0 addr b6a89000 vm_flags 800fb
Bad rmap in gish: page c127c260 flags 20000014 count 2 mapcount 0 addr b6a8a000 vm_flags 800fb
Bad rmap in gish: page c127c280 flags 20000014 count 2 mapcount 0 addr b6a8b000 vm_flags 800fb
Bad rmap in gish: page c127c2a0 flags 20000014 count 2 mapcount 0 addr b6a8c000 vm_flags 800fb
Bad rmap in gish: page c127c2c0 flags 20000014 count 2 mapcount 0 addr b6a8d000 vm_flags 800fb
Bad rmap in gish: page c127c2e0 flags 20000014 count 2 mapcount 0 addr b6a8e000 vm_flags 800fb
Bad rmap in gish: page c127c300 flags 20000014 count 2 mapcount 0 addr b6a8f000 vm_flags 800fb
Bad rmap in gish: page c127c320 flags 20000014 count 2 mapcount 0 addr b6a90000 vm_flags 800fb
Bad rmap in gish: page c127c340 flags 20000014 count 2 mapcount 0 addr b6a91000 vm_flags 800fb
Bad rmap in gish: page c127c360 flags 20000014 count 2 mapcount 0 addr b6a92000 vm_flags 800fb
Bad rmap in gish: page c127c380 flags 20000014 count 2 mapcount 0 addr b6a93000 vm_flags 800fb
Bad rmap in gish: page c127c3a0 flags 20000014 count 2 mapcount 0 addr b6a94000 vm_flags 800fb
Bad rmap in gish: page c127c3c0 flags 20000014 count 2 mapcount 0 addr b6a95000 vm_flags 800fb
Bad rmap in gish: page c127c3e0 flags 20000014 count 2 mapcount 0 addr b6a96000 vm_flags 800fb
Bad rmap in gish: page c127c400 flags 20000014 count 2 mapcount 0 addr b6a97000 vm_flags 800fb
Bad rmap in gish: page c127c420 flags 20000014 count 2 mapcount 0 addr b6a98000 vm_flags 800fb
Bad rmap in gish: page c127c440 flags 20000014 count 2 mapcount 0 addr b6a99000 vm_flags 800fb
Bad rmap in gish: page c127c460 flags 20000014 count 2 mapcount 0 addr b6a9a000 vm_flags 800fb
Bad rmap in gish: page c127c480 flags 20000014 count 2 mapcount 0 addr b6a9b000 vm_flags 800fb
Bad rmap in gish: page c127c4a0 flags 20000014 count 2 mapcount 0 addr b6a9c000 vm_flags 800fb
Bad rmap in gish: page c127c4c0 flags 20000014 count 2 mapcount 0 addr b6a9d000 vm_flags 800fb
Bad rmap in gish: page c127c4e0 flags 20000014 count 2 mapcount 0 addr b6a9e000 vm_flags 800fb
Bad rmap in gish: page c127c500 flags 20000014 count 2 mapcount 0 addr b6a9f000 vm_flags 800fb
Bad rmap in gish: page c127c520 flags 20000014 count 2 mapcount 0 addr b6aa0000 vm_flags 800fb
Bad rmap in gish: page c127c540 flags 20000014 count 2 mapcount 0 addr b6aa1000 vm_flags 800fb
Bad rmap in gish: page c127c560 flags 20000014 count 2 mapcount 0 addr b6aa2000 vm_flags 800fb
Bad rmap in gish: page c127c580 flags 20000014 count 2 mapcount 0 addr b6aa3000 vm_flags 800fb
Bad rmap in gish: page c127c5a0 flags 20000014 count 2 mapcount 0 addr b6aa4000 vm_flags 800fb
Bad rmap in gish: page c127c5c0 flags 20000014 count 2 mapcount 0 addr b6aa5000 vm_flags 800fb
Bad rmap in gish: page c127c5e0 flags 20000014 count 2 mapcount 0 addr b6aa6000 vm_flags 800fb
Bad rmap in gish: page c127c600 flags 20000014 count 2 mapcount 0 addr b6aa7000 vm_flags 800fb
Bad rmap in gish: page c127c620 flags 20000014 count 2 mapcount 0 addr b6aa8000 vm_flags 800fb
Bad rmap in gish: page c127c640 flags 20000014 count 2 mapcount 0 addr b6aa9000 vm_flags 800fb
Bad rmap in gish: page c127c660 flags 20000014 count 2 mapcount 0 addr b6aaa000 vm_flags 800fb
Bad rmap in gish: page c127c680 flags 20000014 count 2 mapcount 0 addr b6aab000 vm_flags 800fb
Bad rmap in gish: page c127c6a0 flags 20000014 count 2 mapcount 0 addr b6aac000 vm_flags 800fb
Bad rmap in gish: page c127c6c0 flags 20000014 count 2 mapcount 0 addr b6aad000 vm_flags 800fb
Bad rmap in gish: page c127c6e0 flags 20000014 count 2 mapcount 0 addr b6aae000 vm_flags 800fb
Bad rmap in gish: page c127c700 flags 20000014 count 2 mapcount 0 addr b6aaf000 vm_flags 800fb
Bad rmap in gish: page c127c720 flags 20000014 count 2 mapcount 0 addr b6ab0000 vm_flags 800fb
Bad rmap in gish: page c127c740 flags 20000014 count 2 mapcount 0 addr b6ab1000 vm_flags 800fb
Bad rmap in gish: page c127c760 flags 20000014 count 2 mapcount 0 addr b6ab2000 vm_flags 800fb
Bad rmap in gish: page c127c780 flags 20000014 count 2 mapcount 0 addr b6ab3000 vm_flags 800fb
Bad rmap in gish: page c127c7a0 flags 20000014 count 2 mapcount 0 addr b6ab4000 vm_flags 800fb
Bad rmap in gish: page c127c7c0 flags 20000014 count 2 mapcount 0 addr b6ab5000 vm_flags 800fb
Bad rmap in gish: page c127c7e0 flags 20000014 count 2 mapcount 0 addr b6ab6000 vm_flags 800fb
Bad rmap in gish: page c127c800 flags 20000014 count 2 mapcount 0 addr b6ab7000 vm_flags 800fb
Bad rmap in gish: page c127c820 flags 20000014 count 2 mapcount 0 addr b6ab8000 vm_flags 800fb
Bad rmap in gish: page c127c840 flags 20000014 count 2 mapcount 0 addr b6ab9000 vm_flags 800fb
Bad rmap in gish: page c127c860 flags 20000014 count 2 mapcount 0 addr b6aba000 vm_flags 800fb
Bad rmap in gish: page c127c880 flags 20000014 count 2 mapcount 0 addr b6abb000 vm_flags 800fb
Bad rmap in gish: page c127c8a0 flags 20000014 count 2 mapcount 0 addr b6abc000 vm_flags 800fb
Bad rmap in gish: page c127c8c0 flags 20000014 count 2 mapcount 0 addr b6abd000 vm_flags 800fb
Bad rmap in gish: page c127c8e0 flags 20000014 count 2 mapcount 0 addr b6abe000 vm_flags 800fb
Bad rmap in gish: page c127c900 flags 20000014 count 2 mapcount 0 addr b6abf000 vm_flags 800fb
Bad rmap in gish: page c127c920 flags 20000014 count 2 mapcount 0 addr b6ac0000 vm_flags 800fb
Bad rmap in gish: page c127c940 flags 20000014 count 2 mapcount 0 addr b6ac1000 vm_flags 800fb
Bad rmap in gish: page c127c960 flags 20000014 count 2 mapcount 0 addr b6ac2000 vm_flags 800fb
Bad rmap in gish: page c127c980 flags 20000014 count 2 mapcount 0 addr b6ac3000 vm_flags 800fb
Bad rmap in gish: page c127c9a0 flags 20000014 count 2 mapcount 0 addr b6ac4000 vm_flags 800fb
Bad rmap in gish: page c127c9c0 flags 20000014 count 2 mapcount 0 addr b6ac5000 vm_flags 800fb
Bad rmap in gish: page c127c9e0 flags 20000014 count 1 mapcount 0 addr b6ac6000 vm_flags 800fb
Bad rmap in gish: page c127ca00 flags 20000014 count 1 mapcount 0 addr b6ac7000 vm_flags 800fb
Bad rmap in gish: page c127ca20 flags 20000014 count 1 mapcount 0 addr b6ac8000 vm_flags 800fb
Bad rmap in gish: page c127ca40 flags 20000014 count 1 mapcount 0 addr b6ac9000 vm_flags 800fb
Bad rmap in gish: page c127ca60 flags 20000014 count 1 mapcount 0 addr b6aca000 vm_flags 800fb
Bad rmap in gish: page c127ca80 flags 20000014 count 1 mapcount 0 addr b6acb000 vm_flags 800fb
Bad rmap in gish: page c127caa0 flags 20000014 count 1 mapcount 0 addr b6acc000 vm_flags 800fb
Bad rmap in gish: page c127cac0 flags 20000014 count 1 mapcount 0 addr b6acd000 vm_flags 800fb
Bad rmap in gish: page c127cae0 flags 20000014 count 1 mapcount 0 addr b6ace000 vm_flags 800fb
Bad rmap in gish: page c127cb00 flags 20000014 count 1 mapcount 0 addr b6acf000 vm_flags 800fb
Bad rmap in gish: page c127cb20 flags 20000014 count 1 mapcount 0 addr b6ad0000 vm_flags 800fb
Bad rmap in gish: page c127cb40 flags 20000014 count 1 mapcount 0 addr b6ad1000 vm_flags 800fb
Bad rmap in gish: page c127cb60 flags 20000014 count 1 mapcount 0 addr b6ad2000 vm_flags 800fb
Bad rmap in gish: page c127cb80 flags 20000014 count 2 mapcount 0 addr b6ad3000 vm_flags 800fb
Bad rmap in gish: page c127cba0 flags 20000014 count 2 mapcount 0 addr b6ad4000 vm_flags 800fb
Bad rmap in gish: page c127cbc0 flags 20000014 count 2 mapcount 0 addr b6ad5000 vm_flags 800fb
Bad rmap in gish: page c127cbe0 flags 20000014 count 2 mapcount 0 addr b6ad6000 vm_flags 800fb
Bad rmap in gish: page c127cc00 flags 20000014 count 2 mapcount 0 addr b6ad7000 vm_flags 800fb
Bad rmap in gish: page c127cc20 flags 20000014 count 2 mapcount 0 addr b6ad8000 vm_flags 800fb
Bad rmap in gish: page c127cc40 flags 20000014 count 2 mapcount 0 addr b6ad9000 vm_flags 800fb
Bad rmap in gish: page c127cc60 flags 20000014 count 2 mapcount 0 addr b6ada000 vm_flags 800fb
Bad rmap in gish: page c127cc80 flags 20000014 count 2 mapcount 0 addr b6adb000 vm_flags 800fb
Bad rmap in gish: page c127cca0 flags 20000014 count 2 mapcount 0 addr b6adc000 vm_flags 800fb
Bad rmap in gish: page c127ccc0 flags 20000014 count 2 mapcount 0 addr b6add000 vm_flags 800fb
Bad rmap in gish: page c127cce0 flags 20000014 count 2 mapcount 0 addr b6ade000 vm_flags 800fb
Bad rmap in gish: page c127cd00 flags 20000014 count 2 mapcount 0 addr b6adf000 vm_flags 800fb
Bad rmap in gish: page c127cd20 flags 20000014 count 2 mapcount 0 addr b6ae0000 vm_flags 800fb
Bad rmap in gish: page c127cd40 flags 20000014 count 2 mapcount 0 addr b6ae1000 vm_flags 800fb
Bad rmap in gish: page c127cd60 flags 20000014 count 2 mapcount 0 addr b6ae2000 vm_flags 800fb
Bad rmap in gish: page c127cd80 flags 20000014 count 2 mapcount 0 addr b6ae3000 vm_flags 800fb
Bad rmap in gish: page c127cda0 flags 20000014 count 2 mapcount 0 addr b6ae4000 vm_flags 800fb
Bad rmap in gish: page c127cdc0 flags 20000014 count 2 mapcount 0 addr b6ae5000 vm_flags 800fb
Bad rmap in gish: page c127cde0 flags 20000014 count 2 mapcount 0 addr b6ae6000 vm_flags 800fb
Bad rmap in gish: page c127ce00 flags 20000014 count 2 mapcount 0 addr b6ae7000 vm_flags 800fb
Bad rmap in gish: page c127ce20 flags 20000014 count 2 mapcount 0 addr b6ae8000 vm_flags 800fb
Bad rmap in gish: page c127ce40 flags 20000014 count 2 mapcount 0 addr b6ae9000 vm_flags 800fb
Bad rmap in gish: page c127ce60 flags 20000014 count 2 mapcount 0 addr b6aea000 vm_flags 800fb
Bad rmap in gish: page c127ce80 flags 20000014 count 2 mapcount 0 addr b6aeb000 vm_flags 800fb
Bad rmap in gish: page c127cea0 flags 20000014 count 2 mapcount 0 addr b6aec000 vm_flags 800fb
Bad rmap in gish: page c127cec0 flags 20000014 count 2 mapcount 0 addr b6aed000 vm_flags 800fb
Bad rmap in gish: page c127cee0 flags 20000014 count 2 mapcount 0 addr b6aee000 vm_flags 800fb
Bad rmap in gish: page c127cf00 flags 20000014 count 2 mapcount 0 addr b6aef000 vm_flags 800fb
Bad rmap in gish: page c127cf20 flags 20000014 count 2 mapcount 0 addr b6af0000 vm_flags 800fb
Bad rmap in gish: page c127cf40 flags 20000014 count 2 mapcount 0 addr b6af1000 vm_flags 800fb
Bad rmap in gish: page c127cf60 flags 20000014 count 2 mapcount 0 addr b6af2000 vm_flags 800fb
Bad rmap in gish: page c127cf80 flags 20000014 count 2 mapcount 0 addr b6af3000 vm_flags 800fb
Bad rmap in gish: page c127cfa0 flags 20000014 count 2 mapcount 0 addr b6af4000 vm_flags 800fb
Bad rmap in gish: page c127cfc0 flags 20000014 count 2 mapcount 0 addr b6af5000 vm_flags 800fb
Bad rmap in gish: page c127cfe0 flags 20000014 count 2 mapcount 0 addr b6af6000 vm_flags 800fb
Bad rmap in gish: page c127d000 flags 20000014 count 2 mapcount 0 addr b6af7000 vm_flags 800fb
Bad rmap in gish: page c127d020 flags 20000014 count 2 mapcount 0 addr b6af8000 vm_flags 800fb
Bad rmap in gish: page c127d040 flags 20000014 count 2 mapcount 0 addr b6af9000 vm_flags 800fb
Bad rmap in gish: page c127d060 flags 20000014 count 2 mapcount 0 addr b6afa000 vm_flags 800fb
Bad rmap in gish: page c127d080 flags 20000014 count 2 mapcount 0 addr b6afb000 vm_flags 800fb
Bad rmap in gish: page c127d0a0 flags 20000014 count 2 mapcount 0 addr b6afc000 vm_flags 800fb
Bad rmap in gish: page c127d0c0 flags 20000014 count 2 mapcount 0 addr b6afd000 vm_flags 800fb
Bad rmap in gish: page c127d0e0 flags 20000014 count 2 mapcount 0 addr b6afe000 vm_flags 800fb
Bad rmap in gish: page c127d100 flags 20000014 count 2 mapcount 0 addr b6aff000 vm_flags 800fb
Bad rmap in gish: page c127d120 flags 20000014 count 2 mapcount 0 addr b6b00000 vm_flags 800fb
Bad rmap in gish: page c127d140 flags 20000014 count 2 mapcount 0 addr b6b01000 vm_flags 800fb
Bad rmap in gish: page c127d160 flags 20000014 count 2 mapcount 0 addr b6b02000 vm_flags 800fb
Bad rmap in gish: page c127d180 flags 20000014 count 2 mapcount 0 addr b6b03000 vm_flags 800fb
Bad rmap in gish: page c127d1a0 flags 20000014 count 2 mapcount 0 addr b6b04000 vm_flags 800fb
Bad rmap in gish: page c127d1c0 flags 20000014 count 2 mapcount 0 addr b6b05000 vm_flags 800fb
Bad rmap in gish: page c127d1e0 flags 20000014 count 2 mapcount 0 addr b6b06000 vm_flags 800fb
Bad rmap in gish: page c127d200 flags 20000014 count 2 mapcount 0 addr b6b07000 vm_flags 800fb
Bad rmap in gish: page c127d220 flags 20000014 count 2 mapcount 0 addr b6b08000 vm_flags 800fb
Bad rmap in gish: page c127d240 flags 20000014 count 2 mapcount 0 addr b6b09000 vm_flags 800fb
Bad rmap in gish: page c127d260 flags 20000014 count 2 mapcount 0 addr b6b0a000 vm_flags 800fb
Bad rmap in gish: page c127d280 flags 20000014 count 2 mapcount 0 addr b6b0b000 vm_flags 800fb
Bad rmap in gish: page c127d2a0 flags 20000014 count 2 mapcount 0 addr b6b0c000 vm_flags 800fb
Bad rmap in gish: page c127d2c0 flags 20000014 count 2 mapcount 0 addr b6b0d000 vm_flags 800fb
Bad rmap in gish: page c127d2e0 flags 20000014 count 2 mapcount 0 addr b6b0e000 vm_flags 800fb
Bad rmap in gish: page c127d300 flags 20000014 count 2 mapcount 0 addr b6b0f000 vm_flags 800fb
Bad rmap in gish: page c127d320 flags 20000014 count 2 mapcount 0 addr b6b10000 vm_flags 800fb
Bad rmap in gish: page c127d340 flags 20000014 count 2 mapcount 0 addr b6b11000 vm_flags 800fb
Bad rmap in gish: page c127d360 flags 20000014 count 2 mapcount 0 addr b6b12000 vm_flags 800fb

--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="gish.maps"

08048000-080aa000 r-xp 00000000 03:04 491712     /home/greg/tmp/gishdemo/gish
080aa000-080ac000 rw-p 00062000 03:04 491712     /home/greg/tmp/gishdemo/gish
080ac000-0a255000 rw-p 080ac000 00:00 0 
b35a8000-b628a000 rw-p b35a8000 00:00 0 
b62b4000-b6433000 rw-p b62b4000 00:00 0 
b6433000-b6913000 rw-s d8447000 00:0a 10806      /dev/dri/card0
b6913000-b6b13000 rw-s d8247000 00:0a 10806      /dev/dri/card0
b6b13000-b6b14000 r--s d8246000 00:0a 10806      /dev/dri/card0
b6b14000-b6b94000 r--s e8110000 00:0a 10806      /dev/dri/card0
b6b94000-b6b96000 rw-s d781c000 00:0a 10806      /dev/dri/card0
b6b96000-b7396000 rw-s f0000000 00:0a 10806      /dev/dri/card0
b7396000-b73c2000 r-xp 00000000 03:02 640202     /usr/lib/libexpat.so.0.5.0
b73c2000-b73c4000 rw-p 0002b000 03:02 640202     /usr/lib/libexpat.so.0.5.0
b73d9000-b7598000 r-xp 00000000 03:02 722328     /usr/X11R6/lib/modules/dri/radeon_dri.so
b7598000-b75ad000 rw-p 001be000 03:02 722328     /usr/X11R6/lib/modules/dri/radeon_dri.so
b75ad000-b75ce000 rw-p b75ad000 00:00 0 
b75ce000-b75cf000 ---p b75ce000 00:00 0 
b75cf000-b77ce000 rwxp b75cf000 00:00 0 
b77ce000-b77d5000 r-xp 00000000 03:02 85851      /usr/X11R6/lib/libXrender.so.1.2.2
b77d5000-b77d6000 rw-p 00006000 03:02 85851      /usr/X11R6/lib/libXrender.so.1.2.2
b77d6000-b77df000 r-xp 00000000 03:02 85859      /usr/X11R6/lib/libXcursor.so.1.0.2
b77df000-b77e0000 rw-p 00008000 03:02 85859      /usr/X11R6/lib/libXcursor.so.1.0.2
b77e0000-b77e1000 rw-p b77e0000 00:00 0 
b77e1000-b77e9000 r-xp 00000000 03:02 739587     /usr/lib/gcc-lib/i686-pc-linux-gnu/3.4.3/libgcc_s.so.1
b77e9000-b77eb000 rw-p 00007000 03:02 739587     /usr/lib/gcc-lib/i686-pc-linux-gnu/3.4.3/libgcc_s.so.1
b77eb000-b77ec000 rw-p b77eb000 00:00 0 
b77ec000-b77f1000 r-xp 00000000 03:02 1046255    /usr/lib/libogg.so.0.5.2
b77f1000-b77f2000 rw-p 00004000 03:02 1046255    /usr/lib/libogg.so.0.5.2
b77f2000-b7837000 r-xp 00000000 03:02 699244     /usr/lib/libsmpeg-0.4.so.0.1.3
b7837000-b7839000 rw-p 00045000 03:02 699244     /usr/lib/libsmpeg-0.4.so.0.1.3
b7839000-b7859000 rw-p b7839000 00:00 0 
b7859000-b7886000 r-xp 00000000 03:02 650755     /usr/lib/libaudiofile.so.0.0.2
b7886000-b7889000 rw-p 0002c000 03:02 650755     /usr/lib/libaudiofile.so.0.0.2
b7889000-b7891000 r-xp 00000000 03:02 653398     /usr/lib/libesd.so.0.2.34
b7891000-b7892000 rw-p 00008000 03:02 653398     /usr/lib/libesd.so.0.2.34
b7892000-b791c000 r-xp 00000000 03:02 785105     /usr/lib/libglib-2.0.so.0.400.8
b791c000-b791e000 rw-p 00089000 03:02 785105     /usr/lib/libglib-2.0.so.0.400.8
b791e000-b791f000 rw-p b791e000 00:00 0 
b791f000-b7923000 r-xp 00000000 03:02 785125     /usr/lib/libgthread-2.0.so.0.400.8
b7923000-b7925000 rw-p 00003000 03:02 785125     /usr/lib/libgthread-2.0.so.0.400.8
b7925000-b7928000 r-xp 00000000 03:02 785098     /usr/lib/libgmodule-2.0.so.0.400.8
b7928000-b792a000 rw-p 00002000 03:02 785098     /usr/lib/libgmodule-2.0.so.0.400.8
b792a000-b7930000 r-xp 00000000 03:02 959548     /usr/kde/3.3/lib/libartsc.so.0.0.0
b7930000-b7931000 rw-p 00005000 03:02 959548     /usr/kde/3.3/lib/libartsc.so.0.0.0
b7931000-b7936000 r-xp 00000000 03:02 85745      /usr/X11R6/lib/libXxf86vm.so.1.0
b7936000-b7937000 rw-p 00004000 03:02 85745      /usr/X11R6/lib/libXxf86vm.so.1.0
b7937000-b7945000 r-xp 00000000 03:02 212279     /lib/libpthread-0.10.so
b7945000-b7946000 r--p 0000d000 03:02 212279     /lib/libpthread-0.10.so
b7946000-b7947000 rw-p 0000e000 03:02 212279     /lib/libpthread-0.10.so
b7947000-b798a000 rw-p b7947000 00:00 0 
b798a000-b79f6000 r-xp 00000000 03:02 576399     /usr/lib/libvga.so.1.9.19
b79f6000-b79fc000 rw-p 0006b000 03:02 576399     /usr/lib/libvga.so.1.9.19
b79fc000-b7a06000 rw-p b79fc000 00:00 0 
b7a06000-b7a16000 r-xp 00000000 03:02 85869      /usr/X11R6/lib/libXext.so.6.4
b7a16000-b7a17000 rw-p 00010000 03:02 85869      /usr/X11R6/lib/libXext.so.6.4
b7a17000-b7ae9000 r-xp 00000000 03:02 85717      /usr/X11R6/lib/libX11.so.6.2
b7ae9000-b7aed000 rw-p 000d1000 03:02 85717      /usr/X11R6/lib/libX11.so.6.2
b7aed000-b7bb4000 r-xp 00000000 03:02 212307     /usr/lib/libasound.so.2.0.0
b7bb4000-b7bb8000 rw-p 000c6000 03:02 212307     /usr/lib/libasound.so.2.0.0
b7bb8000-b7bba000 r-xp 00000000 03:02 212196     /lib/libdl-2.3.4.so
b7bba000-b7bbc000 rw-p 00001000 03:02 212196     /lib/libdl-2.3.4.so
b7bbc000-b7c82000 r-xp 00000000 03:02 739547     /usr/lib/gcc-lib/i686-pc-linux-gnu/3.4.3/libstdc++.so.6.0.3
b7c82000-b7c83000 r--p 000c5000 03:02 739547     /usr/lib/gcc-lib/i686-pc-linux-gnu/3.4.3/libstdc++.so.6.0.3
b7c83000-b7c87000 rw-p 000c6000 03:02 739547     /usr/lib/gcc-lib/i686-pc-linux-gnu/3.4.3/libstdc++.so.6.0.3
b7c87000-b7c8e000 rw-p b7c87000 00:00 0 
b7c8e000-b7c97000 r-xp 00000000 03:02 653573     /usr/lib/libvorbisfile.so.3.1.0
b7c97000-b7c98000 rw-p 00008000 03:02 653573     /usr/lib/libvorbisfile.so.3.1.0
b7c98000-b7cb9000 r-xp 00000000 03:02 212186     /lib/libm-2.3.4.so
b7cb9000-b7cbb000 rw-p 00020000 03:02 212186     /lib/libm-2.3.4.so
b7cbb000-b7de1000 r-xp 00000000 03:02 212399     /lib/libc-2.3.4.so
b7de1000-b7de2000 ---p 00126000 03:02 212399     /lib/libc-2.3.4.so
b7de2000-b7de3000 r--p 00126000 03:02 212399     /lib/libc-2.3.4.so
b7de3000-b7de6000 rw-p 00127000 03:02 212399     /lib/libc-2.3.4.so
b7de6000-b7de8000 rw-p b7de6000 00:00 0 
b7de8000-b7e16000 r-xp 00000000 03:02 655779     /usr/lib/libvorbis.so.0.3.0
b7e16000-b7e25000 rw-p 0002e000 03:02 655779     /usr/lib/libvorbis.so.0.3.0
b7e25000-b7e6c000 r-xp 00000000 03:02 915121     /lib/libopenal.so.0.0.7
b7e6c000-b7e6d000 rw-p 00047000 03:02 915121     /lib/libopenal.so.0.0.7
b7e6d000-b7ec3000 rw-p b7e6d000 00:00 0 
b7ec3000-b7f49000 r-xp 00000000 03:02 37387      /usr/lib/opengl/xorg-x11/lib/libGL.so.1.2
b7f49000-b7f4d000 rw-p 00086000 03:02 37387      /usr/lib/opengl/xorg-x11/lib/libGL.so.1.2
b7f4d000-b7f50000 rw-p b7f4d000 00:00 0 
b7f50000-b7fba000 r-xp 00000000 03:02 688175     /usr/lib/libSDL-1.2.so.0.7.0
b7fba000-b7fbc000 rw-p 0006a000 03:02 688175     /usr/lib/libSDL-1.2.so.0.7.0
b7fbc000-b7fd5000 rw-p b7fbc000 00:00 0 
b7fea000-b8000000 r-xp 00000000 03:02 212182     /lib/ld-2.3.4.so
b8000000-b8002000 rw-p 00015000 03:02 212182     /lib/ld-2.3.4.so
bffd5000-c0000000 rwxp bffd5000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 

--Qxx1br4bt0+wmkIi--
