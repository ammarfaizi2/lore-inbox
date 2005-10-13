Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbVJMUjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbVJMUjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVJMUjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:39:12 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:36797 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S964812AbVJMUjK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:39:10 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Date: Thu, 13 Oct 2005 15:39:03 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF10AF988BF@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Thread-Index: AcXQMin43or95+rvQGiYFKDHqz3czQAA8aIA
From: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
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
X-OriginalArrivalTime: 13 Oct 2005 20:39:05.0563 (UTC) FILETIME=[2745E2B0:01C5D036]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jesper Juhl [mailto:jesper.juhl@gmail.com] 
> 
> On 10/13/05, Miller, Mike (OS Dev) <Mike.Miller@hp.com> wrote:
> >
> > I'm not sure I agree that these are pointless checks. 
> They're not in 
> > the main code path so nothing is lost by checking first. 
> What if the 
> > pointer is NULL????
> >
> 
> If the pointer is NULL then this bit of code in kfree takes 
> care of things :
> 
>  void kfree(const void *objp)
>  {
> ...
> 
>          if (unlikely(!objp))
>                  return;
> ...
> 
> Runtime behaviour is exactely the same.
> kfree checks if the pointer passed to it is NULL in any case 
> and just returns if it is.

okay, I'm convinced.

Signed-off-by: Mike Miller <mike.miller@hp.com>


> 
> 
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
> 
