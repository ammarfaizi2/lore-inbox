Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUCBXIr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 18:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbUCBXIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 18:08:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55250 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261232AbUCBXIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 18:08:41 -0500
Message-ID: <404513E8.9010101@pobox.com>
Date: Tue, 02 Mar 2004 18:08:24 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE cleanups for 2.6.4-rc1 (2/3)
References: <200403022215.07385.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200403022215.07385.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> [IDE] remove ide_cmd_type_parser() logic
> 
> Set ide_task_t fields (command_type, handler and prehandler) directly.
> Remove unused ide_task_t->posthandler and all ide_cmd_type_parser() logic.
> 
> ide_cmd_type_parser() was meant to be used for ioctls but
> ended up checking validity of kernel generated requests (doh!).
> 
> Rationale for removal:
> - it can't be used for existing ioctls (changes the way they work)
> - kernel shouldn't check validity of (root only) user-space requests
>   (it can and should be done in user-space)
> - it wastes CPU cycles on going through parsers
> - it makes code harder to understand/follow
>   (now info about request is localized)


Without the annoyingly-large 'switch', how do you figure out whether a 
command is non-data, pio-read, pio-write, dma-read, or dma-write?

	Jeff



