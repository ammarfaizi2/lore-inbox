Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWHGOkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWHGOkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWHGOkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:40:31 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:59154 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S932092AbWHGOka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:40:30 -0400
Message-ID: <44D75079.5080403@shadowen.org>
Date: Mon, 07 Aug 2006 15:38:49 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: x86_64 command line truncated
References: <20060806030809.2cfb0b1e.akpm@osdl.org>	<44D742DD.6090004@shadowen.org> <p73wt9kprng.fsf@verdi.suse.de>
In-Reply-To: <p73wt9kprng.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>> It seems that the command line on x86_64 is being truncated during boot:
> 
> in mm right?
>> Will try and track it down.
> 
> Don't bother, it is likely "early-param" (the patch from
> hell). I'll investigate.
> 
> -Andi

Well I've narroed it down to the following patch from Andrew:

x86_64-mm-early-param.patch

Basically, that leads setup_arch to return saved_command_line as _the_ 
command_line.  We then run parse_args() against it which assumes it may 
irrevocabaly change command_line.  Previous to this patch 
saved_command_line and command_line were separate and this was not an issue.

It feels like we should be following the model in the newly added 
parse_early_parms() and taking a local copy of the command_line here.

-apw
