Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTLURoM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 12:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTLURoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 12:44:12 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:22287 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263771AbTLURoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 12:44:10 -0500
Date: Sun, 21 Dec 2003 18:44:08 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: PeteVine <davine@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and auto geometry resizing?
Message-ID: <20031221174408.GA14499@win.tue.nl>
References: <20031221162850.5b0bbad9@Athlon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031221162850.5b0bbad9@Athlon.net>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 21, 2003 at 04:28:50PM +0100, PeteVine wrote:

> I've got this problem with 2.6 kernels, namely I can't use my RAID 
> partitions as they are not detected at boot.  I've tracked the issue
> to what I believe is auto geometry resizing.
> 
> With 2.6 cfdisk shows:
> 
> hdc1           Boot, NC       Primary     OnTrackDM6                  33814,13                                   
> 
> Whereas with 2.4 there's no resizing: 
> 
> hdc1                    Primary   Linux swap                        254,99     

It is clear what happens. Both kernels see different partition tables.
You did not show the 2.4 boot messages, but no doubt they will mention
something about the boot manager shift.
Give 2.6 the appropriate boot parameter and all will be fine.

What parameter? Quoting from ide.c:
 * "hdx=remap63"        : add 63 to all sector numbers (for OnTrack DM)
 * "hdx=remap"          : remap 0->1 (for EZDrive)

So if you have OnTrack you need "hdc=remap63".

Andries

