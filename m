Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbTEMXma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbTEMXma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:42:30 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:19615
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262271AbTEMXm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:42:29 -0400
Subject: Re: 2.5.69, IDE TCQ can't be enabled
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Oleg Drokin <green@namesys.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Oliver Neukum <oliver@neukum.org>, lkhelp@rekl.yi.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10305131256240.2718-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10305131256240.2718-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052866550.1205.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 13 May 2003 23:55:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 21:03, Andre Hedrick wrote:
> Not a single OS (linux included) can deal with a error in flush cache, 
> much less an error from a previous tagged request.

To be reasonable its not clear what you can do when a flush cache fails. The
only cases I can see you can handle anything intelligently are drive side but
even those are not clear. If the drive flushes all the blocks it can get
to disk its really the same as a fatal write error except we have less idea how
to recover and have already lost the data.

For the cases it matters you turn off write cache and we (maybe SATA time mostly)
get tcq working properly.

This is the same issue as with SCSI. SCSI has a whole rats nest of things that
seem to exist solely to screw up error recovery 8)

