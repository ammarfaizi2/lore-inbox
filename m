Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTAXBXu>; Thu, 23 Jan 2003 20:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267479AbTAXBXu>; Thu, 23 Jan 2003 20:23:50 -0500
Received: from unthought.net ([212.97.129.24]:53906 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S267478AbTAXBXt>;
	Thu, 23 Jan 2003 20:23:49 -0500
Date: Fri, 24 Jan 2003 02:32:59 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: why isn't quota dependant on ext2?
Message-ID: <20030124013259.GC1286@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Pete Zaitcev <zaitcev@redhat.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <20030121185927.3abd9298.akpm@digeo.com> <Pine.LNX.4.44.0301212259270.5687-100000@innerfire.net> <mailman.1043208901.31378.linux-kernel2news@redhat.com> <200301222105.h0ML5t719018@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200301222105.h0ML5t719018@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 04:05:55PM -0500, Pete Zaitcev wrote:
> >> > ext3, ufs and udf also use the core quota code.
> >> 
> >> The documentation says it only works with ext2 where would I find working
> >> utilities to get it working on ext3 ?
> > 
> > ext3 uses the same tools as ext2 - checkquota, quotaon, etc.
> > 
> > http://quota-tools.sourceforge.net/ (site seems to be broken)
> 
> The bad news is that quota on ext3 is virtually guaranteed
> to deadlock, so you can do it, but you do not want to do it.
> The original memo describes a deadlock in RH 2.4.18-5, which
> I assure you, was NOT fixed in Marcelo 2.4.20. A good anti-deadlock
> work was done, granted, but this particular one wasn't fixed.

Hmm... that doesn't match my experiences here...

[phoenix:joe] $ uname -r
2.4.20-rc3

[phoenix:joe] $ mount | grep exported
/dev/md7 on /exported type ext3 (rw,usrquota)

[phoenix:joe] $ df -h | grep expor
/dev/md7              147G   98G   41G  70% /exported

[phoenix:joe] $ df -ih | grep expor
/dev/md7                 19M    844k     17M    5% /exported

This is a fairly heavily loaded NFS server (load > 10 is not uncommon).

I have seen no lockups so far. Should I be worried ?

It uses the old quota format - could that be why it's ok ?

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
