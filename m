Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265999AbUIMExZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265999AbUIMExZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 00:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUIMExZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 00:53:25 -0400
Received: from fmr11.intel.com ([192.55.52.31]:1425 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S265999AbUIMExW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 00:53:22 -0400
Subject: Re: Possible dcache BUG
From: Len Brown <len.brown@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20040912004812.3544c6de.akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	 <20040808113930.24ae0273.akpm@osdl.org>
	 <200408100012.08945.gene.heskett@verizon.net>
	 <200408102342.12792.gene.heskett@verizon.net>
	 <Pine.LNX.4.58.0408102044220.1839@ppc970.osdl.org>
	 <20040810211849.0d556af4@laptop.delusion.de>
	 <Pine.LNX.4.58.0408102201510.1839@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408102213250.1839@ppc970.osdl.org>
	 <20040812180033.62b389db@laptop.delusion.de>
	 <Pine.LNX.4.58.0408121813190.1839@ppc970.osdl.org>
	 <20040912000354.7243a328@laptop.delusion.de>
	 <20040912001626.759e2d17.akpm@osdl.org>
	 <20040912002945.29a976ad@laptop.delusion.de>
	 <20040912004812.3544c6de.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1095051183.2984.7.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Sep 2004 00:53:03 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-12 at 03:48, Andrew Morton wrote:
> "Udo A. Steinberg" <us15@os.inf.tu-dresden.de> wrote:
> >
> > On Sun, 12 Sep 2004 00:16:26 -0700 Andrew Morton (AM) wrote:
> >
> >  AM> Random guess: acpi_evaluate_object() is returning an error but
> is
> >  AM> allocating memory anyway.
> >  AM>
> >  AM> In acpi_battery_get_status():
> >  AM>
> >  AM>  status = acpi_evaluate_object(battery->handle, "_BST", NULL,
> &buffer);
> >  AM>  if (ACPI_FAILURE(status)) {
> >  AM>          ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating
> _BST\n"));
> >  AM>          return_VALUE(-ENODEV);
> >  AM>  }
> >  AM>
> >  AM> Is that failure path being taken?
> >
> >  Is there a way for me to find that out without recompiling and
> rebooting?
> 
> Looks like you need to set CONFIG_ACPI_DEBUG and then put the
> right number into /proc/acpi/debug_layer.

For the battery module:
# echo 0x00040000 > /proc/acpi/debug_layer


and then to turn on everything about it:
# echo 0xffffffff > /proc/acpi/debug_level

These hooks exist only if the kernel is built with CONFIG_ACPI_DEBUG.

It would be interesting to know if you can examine the contents of
/proc/acpi/battery/*/*

thanks,
-Len


