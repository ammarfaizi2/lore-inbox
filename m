Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268267AbUG2QAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268267AbUG2QAk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268292AbUG2P5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:57:24 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:1083 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S268277AbUG2P47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:56:59 -0400
Message-Id: <200407291556.i6TFuc7U015149@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.1
In-reply-to: <1091071364.13625.37.camel@gaston> 
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Fix ide probe double detection 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jul 2004 10:56:38 -0500
From: Doug Maxey <dwm@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jul 2004 13:22:44 +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2004-07-28 at 08:46, Alan Cox wrote:
>> Some devices don't decode master/slave - notably PCMCIA adapters. 
>> Unfortunately for us some also do, which makes it hard to guess if we
>> should probe the slave.
>> 
>> This patch fixes the problem by probing the slave and then using the model
>> and serial information to spot undecoded pairs. An additional check is done
>> to catch pairs of pre ATA devices just in case.
>
>What about checking if drive->select sticks ? And if that doesn't work,
>something like
>
>- select 0
>- write a value to reg X
>- select 1
>- write a different value to reg X
>- select 0
>- check value
>
>reg X could be nsect or such ...
>
>I don't like relying on drive->id and serial_no, but that may just be
>paranoia...
>
>Ben.

One strategy would be to reverse the order of probes, doing drive 1 first,
then drive 0.  When I was working IDE in AIX, we had some ATAPI devices that
were recalcitrant until the strategy was switched to 1,0 order

++doug
