Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267403AbTAGPxJ>; Tue, 7 Jan 2003 10:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267404AbTAGPxJ>; Tue, 7 Jan 2003 10:53:09 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:20874 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S267403AbTAGPxI>; Tue, 7 Jan 2003 10:53:08 -0500
Date: Tue, 7 Jan 2003 18:01:30 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: fix "ide_scan_direction defined but not used" in ide.c
Message-ID: <20030107160130.GC27032@alhambra>
References: <20030107131002.GI25540@alhambra> <1041957377.20658.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041957377.20658.28.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 04:36:17PM +0000, Alan Cox wrote:
> On Tue, 2003-01-07 at 13:10, Muli Ben-Yehuda wrote:
> > ide_scan_drection is only used if CONFIG_BLK_DEV_IDEPCI is defined,
> > giving a compilation warning otherwise. Against 2.5.54-bk. 
> 
> Please reject. This is uglier than the warning and not the right
> approach

Alan, I bow to your superior knowledge and judgement. However,
'ide_scan_direction' is only used in two places in ide.c, and both of
those are only compiled in if CONFIG_BLK_DEV_IDEPCI:  

in ide_setup(): 

#ifdef CONFIG_BLK_DEV_IDEPCI
        if (!strcmp(s, "ide=reverse")) {
                ide_scan_direction = 1;
                printk(" : Enabled support for IDE inverse scan order.\n");
                return 1;
        }
#endif /* CONFIG_BLK_DEV_IDEPCI */

in probe_for_hwifs(): 

#ifdef CONFIG_BLK_DEV_IDEPCI
        if (pci_present())
        {
                ide_scan_pcibus(ide_scan_direction);
        }
#endif /* CONFIG_BLK_DEV_IDEPCI */

So protecting the variable with #ifdef .. #endif seems the simplest
and least intrusive way to fix it. How would you prefer I do it? 
-- 
Muli Ben-Yehuda

my opinions may seem crazy. But they all make sense. Insane sense, but
sense nontheless. -- Shlomi Fish on #offtopic.

