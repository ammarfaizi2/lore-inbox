Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTGFRGc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266706AbTGFRG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:06:26 -0400
Received: from unthought.net ([212.97.129.24]:23215 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262710AbTGFRGY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:06:24 -0400
Date: Sun, 6 Jul 2003 19:20:56 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: Charles-Edouard Ruault <ce@ruault.com>,
       Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.21 , large disk write => system crawls
Message-ID: <20030706172056.GB9705@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	Charles-Edouard Ruault <ce@ruault.com>,
	Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
References: <3F04AE6A.8000504@ruault.com> <Pine.LNX.4.44.0307031848420.7338-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0307031848420.7338-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 06:56:24PM -0400, Mark Hahn wrote:
> > >>when i do a large disk write operation ( copy a big file for example ), 
> > >>the whole system becomes very busy ( system goes into 99% cpu 
> 
> it's not write-specific.  you can see below that you're somehow
> managing to trigger roughly two interrupts per *either* bi or bo.
> for a normal IDE setup, you should see one interrupt per 16-64K
> under average use.  it's almost like your sys somehow thinks
> that it can only transfer 1 sector per interrupt!

The system is 90% in kernel when writing.  That's bad (unless you're
maxing out your PCI busses or main memory bandwidth of course ;)

The IDE disks are most likely not running DMA.

> 
> > everytime i experience a slowdown, there's a 'big' number in the io (bo) 
> > column.
> 
> no, it's basically in=2*(bi+bo), as if your system somehow believes
> it can only do a single sector per interrupt (PIO and -m1 perhaps?)
> it should be more like 32K per interrupt.

Try:

hdparm -d1 /dev/hda


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
