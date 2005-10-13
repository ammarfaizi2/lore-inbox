Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbVJMUaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbVJMUaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbVJMUaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:30:19 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:41856 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S964775AbVJMUaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:30:18 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Date: Thu, 13 Oct 2005 21:30:18 +0100
User-Agent: KMail/1.8.91
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, "Len Brown" <len.brown@intel.com>,
       "ISS StorageDev" <iss_storagedev@hp.com>,
       "Jakub Jelinek" <jj@ultra.linux.cz>, "Frodo Looijaard" <frodol@dds.nl>,
       "Jean Delvare" <khali@linux-fr.org>,
       "Bartlomiej Zolnierkiewicz" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Jens Axboe" <axboe@suse.de>, "Roland Dreier" <rolandd@cisco.com>,
       "Sergio Rozanski Filho" <aris@cathedrallabs.org>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Pierre Ossman" <drzeus-wbsd@drzeus.cx>,
       "Carsten Gross" <carsten@sol.wh-hms.uni-ulm.de>,
       "Greg Kroah-Hartman" <greg@kroah.com>,
       "David Hinds" <dahinds@users.sourceforge.net>,
       "Vinh Truong" <vinh.truong@eng.sun.com>,
       "Mark Douglas Corner" <mcorner@umich.edu>,
       "Michael Downey" <downey@zymeta.com>,
       "Antonino Daplas" <adaplas@pol.net>,
       "Ben Gardner" <bgardner@wabtec.com>
References: <D4CFB69C345C394284E4B78B876C1CF10AF98879@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10AF98879@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510132130.18686.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 October 2005 21:01, you wrote:
> > From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> > This is the remaining misc drivers/ part of the big kfree
> > cleanup patch.
> >
> > Remove pointless checks for NULL prior to calling kfree() in
> > misc files in drivers/.
> >
> >
> > --- linux-2.6.14-rc4-orig/drivers/block/cciss.c
> > 2005-10-11 22:41:05.000000000 +0200
> > +++ linux-2.6.14-rc4/drivers/block/cciss.c	2005-10-12
> > 17:43:18.000000000 +0200
> > @@ -1096,14 +1096,11 @@ static int cciss_ioctl(struct inode *ino
> >  cleanup1:
> >  		if (buff) {
> >  			for(i=0; i<sg_used; i++)
> > -				if(buff[i] != NULL)
> > -					kfree(buff[i]);
>
> I'm not sure I agree that these are pointless checks. They're not in the
> main code path so nothing is lost by checking first. What if the pointer
> is NULL????
>

kfree() handles a NULL argument gracefully. Jesper's making these cleanups to 
eliminate the redundant checking.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
