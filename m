Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVANU5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVANU5k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 15:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbVANU5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 15:57:35 -0500
Received: from nikam-dmz.ms.mff.cuni.cz ([195.113.20.16]:12212 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262143AbVANU4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 15:56:52 -0500
Date: Fri, 14 Jan 2005 21:56:51 +0100
From: Jan Hubicka <jh@suse.cz>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] booting a kernel compiled with -mregparm=0
Message-ID: <20050114205651.GE17263@kam.mff.cuni.cz>
References: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501141623530.3526@ezer.homenet>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> I am trying to boot a 2.6.x kernel (on x86_64) compiled with -mregparm=0 
> and it does not boot, i.e. hangs at the very first stage.
> 
> I know this breaks ABI/x86_64 but the reason I need to compile such a 
> kernel is because kdb on x86_64 cannot show the function arguments and the 
> only way to make it work that I found was to pass all arguments on the 
> stack (then kdb works fine and shows correct values for all arguments). 
> But obviously the module and the kernel need to match, otherwise it will 
> panic easily; and so I have to use the same argument passing convention in 
> the kernel. This is obviously for debugging only, nobody would ever ship 
> such "incorrectly" compiled module anywhere.
> 
> So, I have to find a "boundary" between the parts of the kernel that can 
> be safely compiled with -mregparm=0 and which must stay as they are. Any 
> ideas as to what to do in this situation?

Actually -mregparm=0 is not supposed to be even accepted by x86-64
compiler (I've disabled the function attribute but apparently missed
this one) and even if GCC produced valid code by miracle, you will get
into trouble with hand written assembly.

Honza
> 
> Kind regards
> Tigran
> 
