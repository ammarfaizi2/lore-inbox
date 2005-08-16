Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVHPRJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVHPRJP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 13:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVHPRJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 13:09:15 -0400
Received: from [85.8.12.41] ([85.8.12.41]:9619 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1030252AbVHPRJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 13:09:14 -0400
Message-ID: <43021DB8.70909@drzeus.cx>
Date: Tue, 16 Aug 2005 19:09:12 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Flash erase groups and filesystems
References: <4300F963.5040905@drzeus.cx> <20050816162735.GB21462@wohnheim.fh-wedel.de>
In-Reply-To: <20050816162735.GB21462@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>Question came up before, albeit with a different phrasing.  One
>possible approach to benefit from this ability would be to create a
>"forget" operation.  When a filesystem already knows that some data is
>unneeded (after a truncate or erase operation), it will ask the device
>to forget previously occupied blocks.
>
>The device then has the _option_ of handling the forget operation.
>Further reads on these blocks may return random data.
>
>And since noone stepped up to implement this yet, you can still get
>all the fame and glory yourself! ;)
>  
>

I'm not sure we're talking about the same thing. I'm not suggesting new
features in the VFS layer. I want to know if something breaks if I
implement this erase feature in the MMC layer. In essence the file
system has marked the sectors as "forget" by issuing a write to them.
The question is if it is assumed that they are unchanged if the write
fails half-way through.

I'd have to say that this is a dangerous assumption to make already
today since some systems might not be able to tell where it fails if a
large chunk of data is given to it, perhaps because of a deep pipeline
before it actually reaches the physical storage.

Rgds
Pierre

