Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750894AbWEDNhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbWEDNhj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 09:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbWEDNhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 09:37:39 -0400
Received: from cicero0.cybercity.dk ([212.242.40.52]:53742 "EHLO
	cicero0.cybercity.dk") by vger.kernel.org with ESMTP
	id S1750894AbWEDNhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 09:37:38 -0400
Date: Thu, 4 May 2006 14:37:30 +0100 (BST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
cc: linux-kernel@vger.kernel.org, "Kolli, Neela" <Neela.Kolli@engenio.co>,
       <linux-scsi@vger.kernel.org>
Subject: RE: [PATCH] MegaRAID driver management char device moved to misc
In-Reply-To: <890BF3111FB9484E9526987D912B261901BD2B@NAMAIL3.ad.lsil.com>
Message-ID: <Pine.LNX.4.40.0605041434430.15259-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Ju, Seokmann wrote:

> Hi,
>
> For following reason, I cannot accept/approve this patch.
> I'll update further as I get clear.
>
> Thank you,
>
> > So it now uses a misc device which I named "megadev0" (the
> > name that megarc
> > expects), and has a dynamic minor (previoulsy a dynamic major
> > was used).
> The driver can not change device node name for backward compatibility.
> I'm checking with application team inside for further clarification and update here.

That is an invalid reason: There was no hardcoded device node previously
(it was using a dynamically assigned major).

The only tool I know which uses this device is "megarc" from LSI Logic.
This tool uses the char device /dev/megaraid0, which will be created
correctly when using my patch and udev (the recommended setup for Linux
2.6 systems). I have tested this and it works.

User-level applications should not rely on hardcoded device numbers in any
case, but should use the correct device from /dev or search for the device
they need in sysfs.

Thomas

