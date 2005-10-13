Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVJMUMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVJMUMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVJMUMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:12:15 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:42907 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932489AbVJMUMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:12:12 -0400
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
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
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining
 drivers
X-Message-Flag: Warning: May contain useful information
References: <D4CFB69C345C394284E4B78B876C1CF10AF98879@cceexc23.americas.cpqcorp.net>
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 13 Oct 2005 13:12:03 -0700
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10AF98879@cceexc23.americas.cpqcorp.net> (Mike
 Miller's message of "Thu, 13 Oct 2005 15:01:42 -0500")
Message-ID: <52slv518j0.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 13 Oct 2005 20:12:05.0588 (UTC) FILETIME=[61B15140:01C5D032]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Mike> I'm not sure I agree that these are pointless
    Mike> checks. They're not in the main code path so nothing is lost
    Mike> by checking first. What if the pointer is NULL????

Read the source to kfree().  The first thing it does is check if the
pointer it is passed is NULL, so the only thing that checking in the
caller does is save a function call.  However I agree with Jesper that
saving .text and cutting down on source code size far outweighs the
cost of these extra function calls.

 - R.
