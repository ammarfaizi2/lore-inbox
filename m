Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWAWRdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWAWRdj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 12:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWAWRdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 12:33:39 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:11935 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751361AbWAWRdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 12:33:38 -0500
Date: Mon, 23 Jan 2006 19:33:32 +0200
From: Ville Herva <vherva@vianova.fi>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Neil Brown <neilb@suse.de>,
       Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale \(ltd\)" <ltd@cisco.com>,
       Michael Tokarev <mjt@tls.msk.ru>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060123173332.GF1686@vianova.fi>
Reply-To: vherva@vianova.fi
References: <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com> <20060121000344.GY22163@marowsky-bree.de> <20060121000806.GT2801@redhat.com> <20060121001311.GA22163@marowsky-bree.de> <20060123094418.GX2801@redhat.com> <20060123125420.GE1686@vianova.fi> <20060123135428.GA2801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060123135428.GA2801@redhat.com>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 02:54:28PM +0100, you [Heinz Mauelshagen] wrote:
> > 
> > It is very tedious to have to debug a production system for a few hours in
> > order to get the rootfs mounted after each kernel update. 
> > 
> > The lvm error messages give almost no clue on the problem. 
> > 
> > Worse yet, problem reports on these issues are completely ignored on the lvm
> > mailing list, even when a patch is attached.
> > 
> > (See
> >  http://marc.theaimsgroup.com/?l=linux-lvm&m=113775502821403&w=2
> >  http://linux.msede.com/lvm_mlist/archive/2001/06/0205.html
> >  http://linux.msede.com/lvm_mlist/archive/2001/06/0271.html
> >  for reference.)
> 
> Hrm, those are initscripts related, not lvm directly

With the ancient LVM1 issue, my main problem was indeed that mkinitrd did
not reserve enough space for the initrd. The LVM issue I posted to the LVM
list was that LVM userland (vg_cfgbackup.c) did not check for errors while
writing to the fs. The (ignored) patch added some error checking.

But that's ancient, I think we can forget about that.

The current issue (please see the first link) is about the need to add
a "sleep 5" between 
 lvm vgmknodes
and
 mount -o defaults --ro -t ext3 /dev/root /sysroot 
. 

Otherwise, mounting fails. (Actually, I added "sleep 5" after every lvm
command in the init script and did not narrow it down any more, since this
was a production system, each boot took ages, and I had to get the system up
as soon as possible.)

To me it seemed some kind of problem with the lvm utilities, not with the
initscripts. At least, the correct solution cannot be adding "sleep 5" here
and there in the initscripts...
 
> Alright.
> Is the initscript issue fixed now or still open ?

It is still open.

Sadly, the only two systems this currently happens are production boxes and
I cannot boot them at will for debugging. It is, however, 100% reproducible
and I can try reasonable suggestions when I boot them the next time. Sorry
about this.

> Had you filed a bug against the distros initscripts ?

No, since I wasn't sure the problem actually was in the initscript. Perhaps
it does do something wrong, but the "sleep 5" workaround is pretty
suspicious.

Thanks for the reply.



-- v -- 

v@iki.fi
