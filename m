Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311136AbSCHVd4>; Fri, 8 Mar 2002 16:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311145AbSCHVdh>; Fri, 8 Mar 2002 16:33:37 -0500
Received: from ns.suse.de ([213.95.15.193]:23823 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311136AbSCHVdb>;
	Fri, 8 Mar 2002 16:33:31 -0500
Date: Fri, 8 Mar 2002 22:33:30 +0100
From: Dave Jones <davej@suse.de>
To: Patricia Gaughen <gone@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
Message-ID: <20020308223330.A15106@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Patricia Gaughen <gone@us.ibm.com>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com>; from gone@us.ibm.com on Fri, Mar 08, 2002 at 01:08:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2002 at 01:08:18PM -0800, Patricia Gaughen wrote:
 > 
 > Hi,
 > 
 > I'm currently working on a discontigmem patch for IBM NUMAQ (an ia32 
 > NUMA box) and want to reuse the standard i386 code as much as
 > possible.  To achieve this, I've modularized setup_arch() and
 > mem_init().  This modularization is what the patch that I've included 
 > in this email contains.

 As a sidenote (sort of related topic) :
 An idea being kicked around a little right now is x86 subarch
 support for 2.5. With so many of the niche x86 spin-offs appearing
 lately, all fighting for their own piece of various files in
 arch/i386/kernel/, it may be time to do the same as the ARM folks did,
 and have..

  arch/i386/generic/
  arch/i386/numaq/
  arch/i386/visws
  arch/i386/voyager/
  etc..

 I've been meaning to find some time to move the necessary bits around,
 and jiggle configs to see how it would work out, but with a pending
 house move, I haven't got around to it yet.. Maybe next week.

 The downsides to this:
 - Code duplication.
   Some routines will likely be very similar if not identical.
 - Bug propagation.
   If something is fixed in one subarch, theres a high possibility
   it needs fixing in other subarchs

  The plus sides of this:
  - Removal of #ifdef noise
    With more and more of these subarchs appearing, this is getting
	more of an issue.
  - subarchs are free to do things 'their way' without affecting the
    common case.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
