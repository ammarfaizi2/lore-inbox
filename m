Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274509AbRJEXSq>; Fri, 5 Oct 2001 19:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274513AbRJEXSg>; Fri, 5 Oct 2001 19:18:36 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:61174 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S274509AbRJEXST>; Fri, 5 Oct 2001 19:18:19 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 5 Oct 2001 17:18:15 -0600
To: Alessandro Suardi <alessandro.suardi@oracle.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Dan Merillat <harik@chaos.ao.net>, linux-kernel@vger.kernel.org
Subject: Re: Wierd /proc/cpuinfo with 2.4.11-pre4
Message-ID: <20011005171815.O315@turbolinux.com>
Mail-Followup-To: Alessandro Suardi <alessandro.suardi@oracle.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Dan Merillat <harik@chaos.ao.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1566531237.1002293911@mbligh.des.sequent.com> <3BBE3DD4.27DFFDCE@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BBE3DD4.27DFFDCE@oracle.com>
User-Agent: Mutt/1.3.22i
"X-GPG-Key: 1024D/0D35BED6"
"X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 06, 2001  01:10 +0200, Alessandro Suardi wrote:
> "Martin J. Bligh" wrote:
> > Sorry. Mea culpa
> > 
> > --- setup.c.old Fri Oct  5 14:20:29 2001
> > +++ setup.c     Fri Oct  5 14:28:51 2001
> > @@ -2420,7 +2420,7 @@
> >          * WARNING - nasty evil hack ... if we print > 8, it overflows the
> >          * page buffer and corrupts memory - this needs fixing properly
> >          */
> > -       for (n = 0; n < 8; n++, c++) {
> > +       for (n = 0; n < (clustered_apic_mode ? 8 : NR_CPUS); n++, c++) {
> >         /* for (n = 0; n < NR_CPUS; n++, c++) { */
> >                 int fpu_exception;
> >  #ifdef CONFIG_SMP

This will also fail if, for some reason "clustered_apic_mode" is set and
you have less than 8 CPUs.  What you really want is to have "max(8:NR_CPUS)"
in the loop (or make the loop actually work with > 8 CPUs, which is probably
the correct solution in the long run).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

