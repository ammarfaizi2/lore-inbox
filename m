Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263547AbTDYKDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 06:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTDYKC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 06:02:59 -0400
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:29966 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263547AbTDYKC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 06:02:58 -0400
Date: Fri, 25 Apr 2003 12:15:17 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Cc: sp@osb.hu
Subject: Re: [PATCH 2.4] dmi_ident made public
Message-Id: <20030425121517.28c9002b.khali@linux-fr.org>
In-Reply-To: <20030424231028.GA29393@kroah.com>
References: <20030424184759.5f7b3323.khali@linux-fr.org>
	<20030424231028.GA29393@kroah.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > If this patch is accepted and applied, I'll work together with Peter
> > to get the three above-mentioned modules simplified, as well as any
> > other I may have missed. Also, I'll take care of porting this patch
> > to the 2.5 series, since it also belongs there.
> 
> i2c-piix4 in the 2.5 kernel tree does not need this patch, as
> everything it needs to detect IBM laptops is already made public.  See
> the current 2.5 releases to verify this.

Thanks for pointing this out. I took a look and could actually verify
it. This made me think again about the whole problem. I wondered wether
all other modules could be fixed that way (in which case my patch
wouldn't make sense), but it turns out that neither i8k nor omke can use
the same trick as the one you used for i2c-piix4. This is due to the
fact that i2c-piix4 only needs a flag (does the system match a given DMI
"mask"? yes/no) whereas the other modules need the actual data. Peter,
correct me if I'm wrong.

What's more, I plan to write another module that exports the DMI data,
as scanned at boot time, to userland (via sysfs), and such a module
definitely requires that the DMI data is made public in dmi_scan.

The good thing is that I think I now understand a bit better what Alan
meant yesterday by "register multiple DMI tables for boot time scanning
to set further flags in the dmi properties post scan". It must be what
you did for i2c-piix4, and isn't what I need there if my analysis is
correct.

So, I still think my patch makes sense and should be applied.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
