Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUAQQ6p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 11:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUAQQ6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 11:58:44 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:14094 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265681AbUAQQ6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 11:58:42 -0500
Date: Sat, 17 Jan 2004 16:58:28 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Doug Ledford <dledford@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Arjan Van de Ven <arjanv@redhat.com>,
       Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
       Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
Subject: Re: smp dead lock of io_request_lock/queue_lock patch
Message-ID: <20040117165828.A4977@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Doug Ledford <dledford@redhat.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Arjan Van de Ven <arjanv@redhat.com>,
	Martin Peschke3 <MPESCHKE@de.ibm.com>, Jens Axboe <axboe@suse.de>,
	Peter Yao <peter@exavio.com.cn>, linux-kernel@vger.kernel.org,
	linux-scsi mailing list <linux-scsi@vger.kernel.org>, ihno@suse.de
References: <OF317B32D5.C8C681CB-ONC1256E19.005066CF-C1256E19.00538DEF@de.ibm.com> <20040112151230.GB5844@devserv.devel.redhat.com> <20040112194829.A7078@infradead.org> <1073937102.3114.300.camel@compaq.xsintricity.com> <Pine.LNX.4.58L.0401131843390.6737@logos.cnet> <1074345000.13198.25.camel@compaq.xsintricity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1074345000.13198.25.camel@compaq.xsintricity.com>; from dledford@redhat.com on Sat, Jan 17, 2004 at 08:10:00AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 17, 2004 at 08:10:00AM -0500, Doug Ledford wrote:
> 4)  The last issue.  2.6 already has individual host locks for drivers. 
> The iorl patch for 2.4 adds the same thing.  So, adding the iorl patch
> to 2.4 makes it easier to have drivers be the same between 2.4 and 2.6. 
> Right now it takes some fairly convoluted #ifdef statements to get the
> locking right in a driver that supports both 2.4 and 2.6.  Adding the
> iorl patch allows driver authors to basically state that they don't
> support anything prior to whatever version of 2.4 it goes into and
> remove a bunch of #ifdef crap.

Well, no.  For one thing all the iorl patches miss the scsi_assign_lock
interface from 2.6 which makes drivers a big ifdef hell (especially
as the AS2.1 patch uses a different name for the lock as 3.0), and even
if it was there the use of that function is strongly discuraged in 2.6
in favour of just using the host_lock.

