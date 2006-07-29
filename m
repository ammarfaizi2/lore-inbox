Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWG2UB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWG2UB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 16:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWG2UB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 16:01:59 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:3973 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932183AbWG2UB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 16:01:58 -0400
Message-ID: <44CBBEC5.7090908@drzeus.cx>
Date: Sat, 29 Jul 2006 22:02:13 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Alex Dubov <oakad@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash
 card readers
References: <20060728033406.40478.qmail@web36712.mail.mud.yahoo.com>
In-Reply-To: <20060728033406.40478.qmail@web36712.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some comments from a MMC/SD perspective.

On a general note, please replace all your constants with defines. Magic
values are no fun (unless they are in fact a magic number ;)).

Also, calling the struct "card" might be a bit misleading as it might be
a bus in the MMC case.

In tifm_sd_o_flags(), try not to case on response types as the hardware
shouldn't have to care about this. If you really, really, _really_ must
do this, then make sure you have a default that prints something nasty
and fails the request with an error.

A default is also needed for cmd_flags in the same function.

In tifm_sd_exec(), you should only need to test for the presence of
cmd->data, not that the command is of ADTC type.

Rgds
Pierre


