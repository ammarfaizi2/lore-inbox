Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267185AbUGMWgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267185AbUGMWgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267192AbUGMWgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:36:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2472 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267185AbUGMWfu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:35:50 -0400
Message-ID: <40F463B0.1010706@pobox.com>
Date: Tue, 13 Jul 2004 18:35:28 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: David Balazic <david.balazic@hermes.si>, Dave Jones <davej@redhat.com>,
       Andries Brouwer <aebr@win.tue.nl>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Weird:  30 sec delay during early boot
References: <600B91D5E4B8D211A58C00902724252C035F1D0C@piramida.hermes.si> <20040713221623.GA10480@lists.us.dell.com>
In-Reply-To: <20040713221623.GA10480@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> David, Jeff, would you mind trying the patch below on your systems
> which exhibit the long delays in the EDD real-mode code?
> 
> This does a few things:
> 1) it uses an int13 fn15 "Get Disk Type" command prior to doing the
> fn02 "Read Sectors" command, to try to determine if there is a disk
> present or not before reading its signature.
> 
> 2) A few registers are more fully zeroed out, in case the BIOS cared
> about things it shouldn't have.
> 
> Crossing my fingers that the delays are gone...

Can you attach the patch, or switch mailers?

The patch is word-wrapped and otherwise munged :(

Example:
> +# Do int13 fn15 first, as BIOS should know if a disk is present or not.
> +# This avoids long (>30s) delays waiting for the READ_SECTORS to a non-pre=
> sent disk.
> +       xor     %eax, %eax
