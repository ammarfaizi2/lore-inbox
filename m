Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263307AbUDEWnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbUDEWnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:43:01 -0400
Received: from mail.tpgi.com.au ([203.12.160.100]:59841 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S263307AbUDEWjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:39:45 -0400
Subject: Re: swsusp update: supports discontingmem/highmem
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040405212354.GA3633@elf.ucw.cz>
References: <20040405212354.GA3633@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1081203867.2577.11.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Tue, 06 Apr 2004 08:24:28 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-04-06 at 07:23, Pavel Machek wrote:
> +		if (PageReserved(page)) {
> +			printk("highmem reserved page?!\n");
> +			BUG();
> +		}

We dealt with this recently in suspend2. It's perfectly valid to have a
Reserved Highmem page. They need to be completely ignored, and whatever
driver is responsible for the memory should handle any required state
persistance. We're setting NoSave for such pages in the parsing of the
e820 table at boot time.

> +		if (!save)
> +			panic("Not enough memory");

Can't you back out nicely if you don't have enough memory for the image?

> +		if (!save->data)
> +			panic("Not enough memory");

(Ditto)
 
> +	/* Fixme: this is too late; we should do this ASAP to avoid "infinite reboots" problem */

Fully agree. I've been meaning to do this too.

Regards,

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

