Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVAIBih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVAIBih (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 20:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVAIBih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 20:38:37 -0500
Received: from mproxy.gmail.com ([216.239.56.241]:19997 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262183AbVAIBie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 20:38:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=M0Ggp7Qih2ClLpwk0Jdn3vRyVfu/k5YYLIlx5x7ehzI1NF2iIhIdTSvSOF2KGO4x/3wvtc4iu9D/R33OT2kEXxSM69XwtsrkjpFyYKWDvhfyxkbn/djMFPp7Ld645WkGx2tfOyNgYnlKlshHqZdtmwUbUjlVXIovKBABY/8oRmM=
Message-ID: <21d7e99705010817386f55e836@mail.gmail.com>
Date: Sun, 9 Jan 2005 12:38:33 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.10-mm2
Cc: Andrew Morton <akpm@osdl.org>, Mike Werner <werner@sgi.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40f323d0050108074112ae4ac7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_76_23346676.1105234713333"
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <40f323d005010701395a2f8d00@mail.gmail.com>
	 <21d7e99705010718435695f837@mail.gmail.com>
	 <40f323d00501080427f881c68@mail.gmail.com>
	 <21d7e99705010805487322533e@mail.gmail.com>
	 <40f323d0050108074112ae4ac7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_76_23346676.1105234713333
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> 
> Removing the framebuffer from the boot command line solved it... (with
> the patch that Mike Werner posted ; without it, it oopsed).
> 

That's a bit weird as nothing should be different, I've just built
vesafb into my kernel and booted and it works fine.. (with the oops
patch...)

vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 3072k,
total 131072k
vesafb: mode is 1024x768x16, linelength=2048, pages=84
vesafb: protected mode interface info at c000:56cd
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Processor [CPU1] (supports 8 throttling states)
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: AGP aperture is 128M @ 0x28000000

....
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized radeon 1.11.0 20020828 on minor 0:
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[drm] Loading R200 Microcode

all good here... I'm trying to see if this could be a via only issue,
or something even more tricky....

If you could apply the patch I've attached (just adds some debug...)
it'll narrow it down a small bit where it is failing for me...

Thanks,
Dave.

------=_Part_76_23346676.1105234713333
Content-Type: application/octet-stream; name="my_agp_debug_patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="my_agp_debug_patch"

LS0tIGRyaXZlcnMvY2hhci9hZ3AvYmFja2VuZC5jLm9yaWcJMjAwNS0wMS0wOSAxMjozNjoxOS4w
MDAwMDAwMDAgKzExMDAKKysrIGRyaXZlcnMvY2hhci9hZ3AvYmFja2VuZC5jCTIwMDUtMDEtMDkg
MTI6Mzc6MjQuMDAwMDAwMDAwICsxMTAwCkBAIC02NiwxMCArNjYsMTYgQEAKIAlicmlkZ2UgPSBh
Z3BfZ2VuZXJpY19maW5kX2JyaWRnZShwZGV2KTsKIAogCWlmICghYnJpZGdlKQorCXsJCisJCXBy
aW50aygiYWdwX2JhY2tlbmRfYWNxdWlyZSBmYWlsZWQgb24gZmluZCBicmlkZ2VcbiIpOwogCQly
ZXR1cm4gTlVMTDsKKwl9CiAKIAlpZiAoYXRvbWljX3JlYWQoJmJyaWRnZS0+YWdwX2luX3VzZSkp
CisJeworCQlwcmludGsoImFncF9iYWNrZW5kX2FjcXVpcmUgZmFpbGVkIG9uIGF0b21pYyByZWFk
XG4iKTsKIAkJcmV0dXJuIE5VTEw7CisJfQogCWF0b21pY19pbmMoJmJyaWRnZS0+YWdwX2luX3Vz
ZSk7CiAJcmV0dXJuIGJyaWRnZTsKIH0K
------=_Part_76_23346676.1105234713333--
