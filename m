Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbULHGBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbULHGBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbULHGBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:01:39 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:32522 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262036AbULHGB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:01:29 -0500
Date: Wed, 8 Dec 2004 06:48:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Simon Byrnand <simon@igrin.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.27 -> 2.4.28 breaks i810-tco watchdog timer
Message-ID: <20041208054834.GD17946@alpha.home.local>
References: <17545.210.54.153.131.1102449575.squirrel@210.54.153.131>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17545.210.54.153.131.1102449575.squirrel@210.54.153.131>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 08, 2004 at 08:59:35AM +1300, Simon Byrnand wrote:
(...)
> e400-e47f : motherboard
> e800-e81f : motherboard
> ec00-ec3f : motherboard
> f000-f00f : Intel Corp. 82801DB Ultra ATA Storage Controller
>   f000-f007 : ide0
>   f008-f00f : ide1
> 
> Clearly the IO range the driver is trying to open is already in use by
> "motherboard". If I check another almost identical machine still running
> 2.4.27 but with the watchdog timer unloaded, /proc/ioports gives:

grep -r shows that it's ACPI which declares this "motherboard" name. I
seem to remember about a change in the ACPI resource reservation. You
might want to check with Len or Marcelo. I believe you cannot disable
it if you want to use HT.

(...)
 
> For some reason a blanket range of IO addresses are being allocated which
> include the range needed by the i810-tco watchdog timer. Why ? I don't see
> any changes to the code for the watchdog timer itself so it seems that
> something else is allocating that range first. Does anyone know of a patch
> to fix this ? Running without a watchdog timer until the next kernel
> version doesnt appeal :( (I can't go back to 2.4.27 due to other problems
> with that version)

Maybe you can hack the driver if you absolutely need to load 2.4.28+TCO.
Simply comment out the "return -EIO" at line 402. It will still print
the message but should load.

Regards,
Willy

