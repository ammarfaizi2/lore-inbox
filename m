Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVBNMhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVBNMhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVBNMhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:37:20 -0500
Received: from sd291.sivit.org ([194.146.225.122]:42920 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261427AbVBNMgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:36:45 -0500
Date: Mon, 14 Feb 2005 13:38:23 +0100
From: Stelian Pop <stelian@popies.net>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050214123822.GF3233@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Jean Delvare <khali@linux-fr.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
	Pekka Enberg <penberg@gmail.com>
References: <20050214100738.GC3233@crusoe.alcove-fr> <CKthPPXN.1108383209.9808960.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CKthPPXN.1108383209.9808960.khali@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 01:13:30PM +0100, Jean Delvare wrote:

> 
> Hi Stelian, all,
> 
> On 2005-02-14, Stelian Pop wrote:
> > I have some interesting information from one user, who noticed that:
> >
> > * pbr is the power-on brightness. It's the brightness that the
> >   laptop uses at power-on time.
> 
> Hey, that makes full sense. After playing around with the debug mode, I
> noticed that the brightness was at the minimum level on next boot. I
> thought it was related to the fact that I didn't have the opportunity
> to stop my system cleanly, but it is indeed possible that I had written
> 0 to pbr before the crash. Will test this evening.
> 
> This reminds me of a related thing I had noticed some times ago but
> couldn't explain back then. Brightness changes made under Linux using
> spicctrl always seemed to be temporary (lost over reboot) while those
> made under Windows on the same laptop were permanent (preserved over
> reboot). Now I have to believe that spicctrl was only changing brt,
> while the Windows tool was probably changing both brt and pbr?
> 
> So, what about either renaming pbr to brightness_default,

something like that, yes.

> or making the
> brightness file dual-valued (several acpi files do that already)?

I don't like much this.

> And I
> guess that the pbr value would need to be limited to the 0-8 range just
> like is done for brt.

Probably, I haven't tested it myself yet, so I don't know.

> > * cdp is the CD-ROM power. Writing 0 to cdp turns off the cdrom in
> >   order to save a bit of power consumption.
> 
> I don't seem to have cdp on my system. Is this something I need to
> manually activate in the driver, or does it simply mean that my laptop
> doesn't support that feature?

sony_acpi doesn't create this node. But if it is supported on your
system you should see 'method: name: GCDP' and 'method: name: SCDP'
in the logs because sony_acpi does enumerate all the methods it
finds for the snc device.

If you see it you can create the cdp entry with a bit of copy&paste
in the driver code...

Stelian.
-- 
Stelian Pop <stelian@popies.net>
