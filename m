Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261991AbREUSuq>; Mon, 21 May 2001 14:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbREUSuj>; Mon, 21 May 2001 14:50:39 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:52666 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S261397AbREUStp>; Mon, 21 May 2001 14:49:45 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Pierre Etchemaite" <petchema@concept-micro.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: tmpfs + sendfile bug ?
Date: Mon, 21 May 2001 11:49:40 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKCECOPDAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <XFMail.20010521183553.petchema@concept-micro.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That could be a bug with tmpfs and sendfile in 2.4.5-pre4 :
>
> [...]
> read(8, "%PDF-1.4\r%\342\343\317\323\r\n870 0 obj\r<< \r/L"...,
> 8192) = 8192
> shmat(11, 0x4cfe65, 0x3)                = 0xbffff4d4
> sendfile(11, 8, [0], 5045861)           = -1 EINVAL (Invalid argument)
> [...]
>
> Any idea ?

	Looks like a bug in the program. If 'sendfile' returns 'EINVAL', that means
you can't use 'sendfile' to send this particular file, and should default to
read/write or mmap/write. If this program doesn't, it doesn't understand
Linux's 'sendfile' semantics.

	DS

