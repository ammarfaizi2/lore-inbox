Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbTHTTrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTHTTrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:47:16 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:13832 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262226AbTHTTrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:47:15 -0400
Date: Wed, 20 Aug 2003 21:47:12 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: John Riggs <jriggs@altiris.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 48-bit Drives Incorrectly reporting 255 Heads?
Message-ID: <20030820214712.A3065@pclin040.win.tue.nl>
References: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>; from jriggs@altiris.com on Wed, Aug 20, 2003 at 01:31:08PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 20, 2003 at 01:31:08PM -0600, John Riggs wrote:

>   With the 2.4.20 kernel, I have a 40GB disk with 240 heads, with 48-bit
> mode enabled. The Linux ide driver automatically declares that anything
> with 48-bit mode enabled has 255 heads. This is a problem, as I am
> writing a utility to fix up a Windows PBR, and the PBR relies on the
> head count as counted by the BIOS.
>   The Linux code in question is in ide-disk.c:
> 
>   if (id->cfs_enable_2 & 0x0400) {
>     .
>     drive->head = drive->bios_head = 255;
>     .
>   }
> 
>   What I would like to do is change the above to:
> 
>   if (id->cfs_enable_2 & 0x0400) {
>     .
>     drive->head = 255;
>     .
>   }
> 
>   Thereby not changing the bios head count. My initial tests seem to
> have worked okay, with the correct geometry getting reported. Can
> anybody point out to me why this will break something else?
>   Two more specific questions are:
>     1) Will this break drives > 137 GB?
>     2) Why would the head count be set to 255 in the first place?

No, this does not break anything.
Setting drive->head to 255 is completely ridiculous.
Setting drive->bios_head to 255 is rather pointless.
In 2.6 this junk has been removed already.

On the other hand, you are badly mistaken if you think that your changes
do anything useful. The value drive->bios_head must be regarded as
random, and is only vaguely related to what the BIOS thinks.
In 2.6 that vague relation has entirely disappeared.

