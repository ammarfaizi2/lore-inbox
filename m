Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292233AbSCIBAn>; Fri, 8 Mar 2002 20:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292130AbSCIBAd>; Fri, 8 Mar 2002 20:00:33 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:30381 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S292150AbSCIBAV>; Fri, 8 Mar 2002 20:00:21 -0500
Message-ID: <3C895E90.696E92A2@didntduck.org>
Date: Fri, 08 Mar 2002 20:00:00 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thomas Hood <jdthood@mail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS driver status
In-Reply-To: <1015628440.14518.212.camel@thanatos>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood wrote:
> 
> A couple people have asked me about the status of the
> PnP BIOS driver, so I thought I'd post an update.
> 
> History: During the pre-Tosatti 2.4-ac series the driver was
> hammered into a reliable form.  However it never entered the
> mainline kernel series.
> 
> The driver was then stripped down to the core functionality
> required to make the lspnp and setpnp utilities work.
> pnpbios_register_driver() and pnpbios_unregister_driver() are
> still there but aren't used by anything.  Additional /proc/
> interface files were then added to allow reading of ESCD info.
> 
> The latest version of the driver seems nice 'n' stable and can
> be found in Alan's latest 2.4 patches.
> 
> Current 2.5 kernels also contain the driver, but it's a bit out
> of date.  There's a patch in 2.5-dj but that's also out of date.
> ("Out of date" here means "missing new features and some
> cleanups".)  Once DJ releases a 2.5.6-dj I'll send him a patch
> to bring his tree up to date.  Then he can pass it on to Linus.

The current driver is not SMP-safe.  It is modifying the GDT descriptors
outside of the pnp_bios_lock.  Also, you can remove the __cli(), as
spin_lock_irq() already turns off interrupts.

-- 

						Brian Gerst
