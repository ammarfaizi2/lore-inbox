Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131102AbRA2WJF>; Mon, 29 Jan 2001 17:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131091AbRA2WI4>; Mon, 29 Jan 2001 17:08:56 -0500
Received: from [64.64.109.142] ([64.64.109.142]:24583 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S130400AbRA2WIq>; Mon, 29 Jan 2001 17:08:46 -0500
Message-ID: <3A75E9C9.15A19548@didntduck.org>
Date: Mon, 29 Jan 2001 17:08:09 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Rasmus Andersen <rasmus@jaquet.dk>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make drivers/scsi/seagate.c use ioremap instead of 
 isa_{read,write} (241p11)
In-Reply-To: <20010129225907.M603@jaquet.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rasmus Andersen wrote:
> 
> Hi.
> 
> (I have not been able to find a probable current maintainer for
> this code.)
> 
> The following patch makes drivers/scsi/seagate.c use ioremap
> instead of isa_{read, write}.
> 
> It applies against ac12 and 241p11.
> 
> Please comment, esp. on the size of the remappings.

This isn't the proper way to use ioremap.  You should only ioremap once
when the driver is loaded and save the mapped address.  Since ioremap
special cases ISA addresses, it doesn't add much overhead the way you
are doing it, but it is still not consistent with normal non-ISA usage
of ioremap.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
