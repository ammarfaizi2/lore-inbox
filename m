Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTJaTQx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTJaTQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 14:16:52 -0500
Received: from enterprise.bidmc.harvard.edu ([134.174.118.50]:32522 "EHLO
	enterprise.bidmc.harvard.edu") by vger.kernel.org with ESMTP
	id S263527AbTJaTQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 14:16:51 -0500
Message-ID: <3FA2B4F4.8040404@enterprise.bidmc.harvard.edu>
Date: Fri, 31 Oct 2003 14:16:04 -0500
From: "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Kronos <kronos@kronoz.cjb.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Javier Villavicencio <jvillavicencio@arnet.com.ar>
Subject: Re: RadeonFB [Re: 2.4.23pre8 - ACPI Kernel Panic on boot]
References: <20031029210321.GA11437@dreamland.darkstar.lan>	 <1067491238.1735.4.camel@ktkhome> <1067587196.715.1.camel@gaston>
In-Reply-To: <1067587196.715.1.camel@gaston>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:

>Ok, first thing: XFree "radeon" _is_ accelerated, though it doesn't
>do 3D on recent cards
>
Hi Ben - Right, sorry, I mean to apply "accelerated" to the 3D effects; 
the private ATI driver is much faster on glxgears than the version that 
bundles with XFree.

>Then, the problem you are having is well known
>
I'm having two, actually.  The first is that YPAN is getting quite 
confused.  If I switch VCs, then switch back, the text has been 
re-arranged, the cursor is often invisible, and sometimes a page or two 
of new text must be written before anything starts to show up on the 
screen again.  Experimenting shows that setting VYRES = YRES works 
around this problem.

The second problem is of course the register contents issue when 
returning from certain graphics programs (e.g. X+fglr) to text mode..  I 
rather like your idea of doing a re-init when switching from KD_GRAPHICS 
to KD_TEXT, as the monitor blank during resolution switch will likely 
overshadow the re-init process.

>Can you verify that running fbset -accel 0 then back 1 cures the
>problem for you ?
>  
>

At work now, will try when I return home later...

Kris

