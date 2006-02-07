Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWBGMGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWBGMGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 07:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965045AbWBGMGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 07:06:22 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:12470 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S965043AbWBGMGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 07:06:21 -0500
Date: Tue, 7 Feb 2006 14:06:19 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Alexander Nassian <linux@picadreams.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Development of Ricoh Memory Host Adapter
Message-ID: <20060207120619.GS3927@mea-ext.zmailer.org>
References: <200602071128.16673.linux@picadreams.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602071128.16673.linux@picadreams.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 11:28:16AM +0100, Alexander Nassian wrote:
> Hi,
> 
> I'm new to kernel programming and wanted to try to develop my first "real" 
> kernel module. Up to now I only programmed little, useless, modules to get 
> into the kernel.
> 
> Because there is no module for the Ricoh Memory Host Adapter, which is in my 
> notebook, I want to start developing one.
> 00:0a.2 Class 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host Adapter (rev 17)
> 
> The problem is, that I have absolutely no idea where to start. When I'm 
> looking at the code of existing MMC modules, I wanna start cry.

Do you have documentation for that chip ?
If not, can you get it ?

I found Ricoh LSI's pages easily enough, and there are no deep documentation
available for this chip for direct download:
  http://www.ricoh.com/LSI/product_pcif/pcc/5c821/index.html

If I had hardware where this chip exists, I would do following:

 - Contact vendor directly, and ask for necessary documentation
   and other support, under a limited scope NDA if necessary,
   so that I can create device driver for it to be used in Linux
   system.  Plus tell that:

    - Documentation and support I receive from vendor under the NDA
      will not be made publically available, nor privately unless
      vendor informs me otherwise (e.g. introduces some other named
      individual/company looking/working for the same and that the
      vendor is explicitely allowing me to tell my info to them.)

    - I would prefer not to receive Windows driver sources as
      an example of how to program the chip; such would endanger
      entire Open Source driver development.

    - NDA (scope) limitation is about:
       - Documentation redistribution, including extensive copying
         to public material.
       - NDA has expiration time, after which it no longer binds
         (say: 1 to 5 years)
       - Possible penalty values are sensible when talking about
         individuals (e.g. USD 10k, not million(s) - sums that do
         hurt individual hobby programmer a lot, and make to think
         about what to release publically. )

    - Resulting source code will be minimally informative about what
      is going on in spots that are vendor hardware specific (e.g.
      other than generic PCI interface stuff.) And if the vendor wants,
      they can review the source code for the (lack of) public 
      hardware specific informativity before release.
      When some control register needs manipulation in these private
      parts, values stored there are hex literals, and not #define:d
      mnemonics.  When processing logic affects values (e.g. by mode)
      one can always deduct changes in bit-patterns to mean something,
      and obfuscation can not completely hide everything.
      E.g. where some "deep magic" is needed, that is documented at
      most with
          "Doc 5: part 3.2.1"
      and somewhere in beginning comments:
        "Doc 5: R5C821 programming documentation errata 3 received under NDA"

    - Code shall be _maintainable_ (to track possibly changing kernel
      API conventions within Linux,) preferrably without original
      author and NDA documents.  In essence this means separation
      of vendor hardware specific code to internal procedures and
      to use internal datastructures in its handling.  Mapping
      from external to internal shall ne via easily maintainable
      interfaces. 

    - Preferrably there shall be no "this internal driver is only
      available in pre-compiled object-file format" -- Linux exists
      now in considerably large number of possible processors, and
      it makes things a lot easier, if there is no need to supply
      pre-compiled binary libraries to all of them.


 - If the vendor does not answer, then trying via near-by sales
   representative, who usually speaks your language.
   Getting thru them with an idea that it would be productive for
   them to help you while you are not buying their products might
   take some talking, though...


> Do you have any tips, tutorials, ... how I can start, step by step, the 
> development of this module?

  "Writing device drivers for Linux"  or some such titled book..

  You can receive support for Linux side driver interfaces, especially
  if there is no matured device interface for something as of yet.

  I have no idea, if e.g. "MMC"-card can be thought as "scsi-disk", and
  thus be accessed as if via SCSI block driver interface.
  If it can, then there are lots of examples of how to do that.

> Sincereley,
> Alexander Nassian

  /Matti Aarnio
