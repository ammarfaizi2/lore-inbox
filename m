Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVBLNUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVBLNUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 08:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVBLNUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 08:20:54 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:10504 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261401AbVBLNUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 08:20:48 -0500
Date: Sat, 12 Feb 2005 14:21:03 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stelian Pop <stelian@popies.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-Id: <20050212142103.5e1a79f9.khali@linux-fr.org>
In-Reply-To: <20050211113636.GI3263@crusoe.alcove-fr>
References: <20050210161809.GK3493@crusoe.alcove-fr>
	<20050211113636.GI3263@crusoe.alcove-fr>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Based on feedback from Jean Delvare and Pekka Enberg, here is an
> updated version.

Works for me (Vaio PCG-GR214EP). Tested with 2.6.11-rc3-bk8.

I then enabled the debug mode. I couldn't find anything relevant WRT
what each additional file is supposed to do, but I still have noticed a
number of things you might be interested in.

ctr doesn't seem to affect the contrast for me. I also noticed that the
value seems to be stored on 8 bits. Higher bits are ignored (e.g. write
300, read 44). Default value is 64.

cmi behaves strangely. Its default value is 0. Whatever I write to it
(including 0), next read returns 131.

pbr seems to be stored on 4 bits. Higher bits are ignored (e.g. write
20, read 4). Default value is 0.

csxb is the dangerous one. Default 0. Writing 41 to it deadlocked my
system. Writing 42 changed pbr from 0 to 8 as a side effect. Each write
generates an error in the logs:
  sony_acpi: acpi_evaluate_object failed

cmi and csxb are reset to 0 on sony_acpi module cycling. brightness, ctr
and pbr are preserved.

Hope that helps. Let me know if you want me to test specific things.
-- 
Jean Delvare
