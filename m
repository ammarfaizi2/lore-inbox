Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292881AbSCJHr6>; Sun, 10 Mar 2002 02:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292885AbSCJHrj>; Sun, 10 Mar 2002 02:47:39 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17465 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S292881AbSCJHrf>; Sun, 10 Mar 2002 02:47:35 -0500
To: Dave Jones <davej@suse.de>
Cc: Patricia Gaughen <gone@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [RFC] modularization of i386 setup_arch and mem_init in 2.4.18
In-Reply-To: <200203082108.g28L8I504672@w-gaughen.des.beaverton.ibm.com>
	<20020308223330.A15106@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 10 Mar 2002 00:42:15 -0700
In-Reply-To: <20020308223330.A15106@suse.de>
Message-ID: <m1zo1gzx60.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:

> On Fri, Mar 08, 2002 at 01:08:18PM -0800, Patricia Gaughen wrote:
>  > 
>  > Hi,
>  > 
>  > I'm currently working on a discontigmem patch for IBM NUMAQ (an ia32 
>  > NUMA box) and want to reuse the standard i386 code as much as
>  > possible.  To achieve this, I've modularized setup_arch() and
>  > mem_init().  This modularization is what the patch that I've included 
>  > in this email contains.
> 
>  As a sidenote (sort of related topic) :
>  An idea being kicked around a little right now is x86 subarch
>  support for 2.5. With so many of the niche x86 spin-offs appearing
>  lately, all fighting for their own piece of various files in
>  arch/i386/kernel/, it may be time to do the same as the ARM folks did,
>  and have..

I will tenatively vote in favor of this kind of action.  There
are a couple of directions to consider.  This is a two dimensional
problem.

Dimension 1.  Different basic hardware architectures. 
  (pc,numaq,visws,voyager)
Dimension 2.  Different firmware implementations.  
  (pcbios,linuxbios,openfirmware,acpi?)

And beyond that it is fairly important to be able to build a generic
kernel.  That works on everything.  You might have to specify a
command line parameter to tell it which arch it is really running on
but it should work. 

>From working with the alpha I can say that it is just nasty when you
must have per motherboard information in your kernel.  Generally life
is much more pleasant if a small handful of things like irq routing
information is provided by the firmware so you only have to code for a
specific hardware device, and not a specific motherboard.  

And even if we get to the point of putting in motherboard specific
code I would suggest it just provide the information like irq routing,
and which superio chips are present and allow a more generic layer to
handle their setup.

Anyway on the multiplexing the firmware score I have just done the
heavy lifting needed so we can put the firmware switching logic 
all in C code.

Eric
