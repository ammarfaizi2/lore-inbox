Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965305AbWFAVF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965305AbWFAVF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 17:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965306AbWFAVF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 17:05:58 -0400
Received: from qb-out-0506.google.com ([72.14.204.238]:5500 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965305AbWFAVF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 17:05:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lA11zb39Q1oI3LqhF4W7c3GmQ3LJl+E2cMjuraUXL3chaqIVpnwa9YBquCmPLpcJ/5n1pEZEh5FoNvI3+bm3/3sCcccHbg/1vmx2fo6Q9B354YSV0erYkXzezhQVOZUQuP/OirQ2cwkIRefkrZHpKC9zwgRSdU/9J91SnSbO8MY=
Message-ID: <447F56A0.8030408@gmail.com>
Date: Fri, 02 Jun 2006 05:05:36 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: "D. Hazelton" <dhazelton@enter.net>, David Lang <dlang@digitalinsight.com>,
       Ondrej Zajicek <santiago@mail.cz>, Dave Airlie <airlied@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <9e4733910606010959o4f11d7cfp2d280c6f2019cccf@mail.gmail.com>	 <Pine.LNX.4.63.0606010758380.3827@qynat.qvtvafvgr.pbz>	 <200606011603.57421.dhazelton@enter.net> <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
In-Reply-To: <9e4733910606011335q5791997drc02d23f398a2acf5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 6/1/06, D. Hazelton <dhazelton@enter.net> wrote:
> 
> Printk works from inside interrupt handlers currently. This is an
> absolute requirement for kernel debugging that can't be removed.
> Because of this requirement there has to be a way for all drivers to
> draw the console entirely inside the kernel. You can not make calls to
> user space from inside interrupt handlers.
> 
>> > > 6) Things like panics should be visible no matter what is running. No
>> > > more silent deaths.
> 
> Panics can occur inside interrupt handlers. You can't queue up printks
> in this context and they display them later, the kernel just died,
> there is no later.
> 

Console writes are done with the console semaphore held. printk will also
just write to the log buffer and defer the actual console printing
for later, by the next or current process that will grab the semaphore.

Tony
