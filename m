Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286691AbRLVF1w>; Sat, 22 Dec 2001 00:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbRLVF1m>; Sat, 22 Dec 2001 00:27:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:47880 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S286691AbRLVF1c>; Sat, 22 Dec 2001 00:27:32 -0500
Message-ID: <3C241978.65020179@zip.com.au>
Date: Fri, 21 Dec 2001 21:26:16 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Jason Thomas <jason@topic.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] link errors with internal calls to devexit functions
In-Reply-To: Your message of "Sat, 22 Dec 2001 13:57:25 +1100."
	             <20011222025725.GA629@topic.com.au> <5750.1008997543@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
>         __devexit_call(bttv_remove(dev));
>         __devexit_call(uhci_pci_remove(dev));

This may break the drivers.  They both call the remove
function on the init path, when something failed.

I believe the correct fix here is to simply remove __devinit altogether
from the definition of both those functions.
