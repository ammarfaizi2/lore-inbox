Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWG3G3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWG3G3n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 02:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWG3G3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 02:29:43 -0400
Received: from web36706.mail.mud.yahoo.com ([209.191.85.40]:3681 "HELO
	web36706.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751177AbWG3G3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 02:29:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=KhM640W8Rw1mfaN3q5HyGrvbXju8eOrB7Uv5Alj2cZiN2UQ55Ar4+Wr5WCHFzmi0TC7g5s3KJJKoqs7ZxMYw2xf6XfPZsDF44HhfMO2dUoZgeBXueE/qHaWEjNgngUfEBl10RE4CqJee/ZzD2YsS6Tv/jbNX4/HGvnWWaumf/mk=  ;
Message-ID: <20060730062942.29644.qmail@web36706.mail.mud.yahoo.com>
Date: Sat, 29 Jul 2006 23:29:42 -0700 (PDT)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: Support for TI FlashMedia (pci id 104c:8033, 104c:803b) flash card readers
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44CBBEC5.7090908@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Pierre Ossman <drzeus-list@drzeus.cx> wrote:

> Some comments from a MMC/SD perspective.
> 
> On a general note, please replace all your constants
> with defines. Magic
> values are no fun (unless they are in fact a magic
> number ;)).
They are magic numbers. I have only the vague idea on
what most of these numbers mean. I digged them out
from TI's/everest's binary driver.

Luckily, Vayo's linux binary had every register
accessed from separate function, so, at least,
register names are known with certain confidence.

> 
> Also, calling the struct "card" might be a bit
> misleading as it might be
> a bus in the MMC case.
I already have "socket". "card" is something that is
plugged into the "socket". It's hard to think about
short name that fits here nicely.

> 
> In tifm_sd_o_flags(), try not to case on response
> types as the hardware
> shouldn't have to care about this. If you really,
> really, _really_ must
> do this, then make sure you have a default that
> prints something nasty
> and fails the request with an error.

Unfortunately, hardware does care. Output of
tifm_sd_op_flag is set into upper half of command
register. The fall-back is 0 (implied default for both
switches).

> 
> A default is also needed for cmd_flags in the same
> function.
> 
> In tifm_sd_exec(), you should only need to test for
> the presence of
> cmd->data, not that the command is of ADTC type.

The TI binary drivers tests for the command type
before setting the appropriate bit in command register
(similar to tifm_sd_op_flags).

In general: while I'm using code flow different from
this used in TI's binary drivers, I tried very hard to
preserve register access semantics. When I failed to
do so, very bad things happened - sporadic and brutal
kernel crashes and run-aways. I think they were caused
by device writing random junk to some memory address
at arbitrary times.



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
