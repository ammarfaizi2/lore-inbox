Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317934AbSFNP2u>; Fri, 14 Jun 2002 11:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317935AbSFNP2t>; Fri, 14 Jun 2002 11:28:49 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:26359 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S317934AbSFNP2s>; Fri, 14 Jun 2002 11:28:48 -0400
Date: Fri, 14 Jun 2002 11:28:49 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020614112849.A22888@redhat.com>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com> <20020614040025.GA2093@inspiron.birch.net> <20020614001726.D21542@redhat.com> <20020614062754.A11232@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 06:27:54AM +0200, Andi Kleen wrote:
> Both AMD x86-64 and Intel IA32 documentation states that INVLPG flushes global
> TLBs. The first version of change_page_attr did in fact use __flush_tlb_all,
> but I changed it after checking the docs.

As Andrea pointed out, there is an errata whereby 4MB pages aren't flushed 
on the Athlon.  If you mask off the low bits of the address for flushing, 
that should fix the problem, and sounds like a plausible explanation for 
the failure I saw.

		-ben

ps. s/La Haise/LaHaise would be nice, too.
-- 
"You will be reincarnated as a toad; and you will be much happier."
