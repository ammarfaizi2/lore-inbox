Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbUKOXEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbUKOXEk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 18:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUKOXDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 18:03:30 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:47042 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S261577AbUKOXCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 18:02:53 -0500
Date: Tue, 16 Nov 2004 00:02:49 +0100
From: David Weinehall <tao@acc.umu.se>
To: Nickolai Zeldovich <kolya@MIT.EDU>
Cc: linux-kernel@vger.kernel.org, csapuntz@stanford.edu
Subject: Re: [patch] Fix GDT re-load on ACPI resume
Message-ID: <20041115230249.GR29980@khan.acc.umu.se>
Mail-Followup-To: Nickolai Zeldovich <kolya@MIT.EDU>,
	linux-kernel@vger.kernel.org, csapuntz@stanford.edu
References: <Pine.GSO.4.58L.0411151525540.28749@contents-vnder-pressvre.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58L.0411151525540.28749@contents-vnder-pressvre.mit.edu>
User-Agent: Mutt/1.4.1i
X-Editor: Vi Improved <http://www.vim.org/>
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 03:35:14PM -0500, Nickolai Zeldovich wrote:
> The ACPI resume code currently uses a real-mode 16-bit lgdt instruction to
> reload the GDT.  This only restores the lower 24 bits of the GDT base
> address.  In recent kernels, the GDT seems to have moved out of the lower
> 16 megs, thereby causing the ACPI resume to fail -- an invalid GDT was
> being loaded.
> 
> This simple patch adds the 0x66 prefix to lgdt, which forces it to load
> all 32 bits of the GDT base address, thereby removing any restrictions on
> where the GDT can be placed in memory.  This makes ACPI resume work for me
> on a Thinkpad T40 laptop.

Sadly doesn't work for me.  ACPI resume broke for me with
2.6.10-rc1-bk15 (possibly 14, but that one didn't compile), and this
patch does not fix it.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
