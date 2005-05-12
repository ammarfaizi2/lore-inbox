Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVELRDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVELRDI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 13:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVELRDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 13:03:08 -0400
Received: from mailgate.quadrics.com ([194.202.174.11]:10889 "EHLO
	qserv01.quadrics.com") by vger.kernel.org with ESMTP
	id S262079AbVELRDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 13:03:04 -0400
Message-ID: <42838C38.8060404@quadrics.com>
Date: Thu, 12 May 2005 18:02:48 +0100
From: David Addison <addy@quadrics.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] enhance x86 MTRR handling
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com>
In-Reply-To: <20050512161825.GC17618@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 May 2005 16:56:18.0031 (UTC) FILETIME=[83FCDFF0:01C55713]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> Whilst your changes may have merit, I'd much rather see effort spent
> on getting PAT into shape than further massaging MTRR.  Its well past its
> smell-by-date, and theres been no activity whatsoever afaik on getting
> Terrence Ripperda's cachemap stuff beaten into shape.
> 
> I'll dust off the last version he sent and diff against latest-mm later
> so it can get some more commentary. It seems everyone is in violent
> agreement that we want PAT support, but nothing seems to happen.
> 
Yes we tried to contact the cachemap author but just found dead email
addresses, so in the end we switched to using PAT.
But rather that make kernel changes, we simply wrote a startup utility to
program the MSR registers using /dev/cpu/%d/msr
Our device driver then reads the IA32CR_PAT MSR and looks for a write-combining
entry (value 0x01) and uses the slot # to program the correct PTE bits.

But having a default write-combining MSR slot and a defined call to enable it
would be good; I believe Hugo Kohmann from Dolphin has a patch to do this for
x86_64 at least.

Cheers
Addy.

