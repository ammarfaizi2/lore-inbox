Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTEEKAC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 06:00:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbTEEKAC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 06:00:02 -0400
Received: from elin.scali.no ([62.70.89.10]:61571 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S261190AbTEEKAA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 06:00:00 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
In-Reply-To: <20030505093810.A22327@devserv.devel.redhat.com>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <20030505093810.A22327@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052129543.2821.87.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 12:12:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 11:38, Arjan van de Ven wrote:
> On Mon, May 05, 2003 at 11:33:36AM +0200, Terje Eggestad wrote:
> > 1. performance is everything. 
> > 2. We're making a MPI library, and as such we don't have any control
> > with the application. 
> > 3a. The various hardware for cluster interconnect all work with DMA. 
> > 3b. the performance loss from copying from a receive area to the
> > userspace buffer is unacceptable. 
> > 3c. It's therefore necessary for HW to access user pages. 
> > 4. In order to to 3, the user pages must be pinned down. 
> 
> see how AIO does this, and O_DIRECT, and rawio.
> 
> They all have the same requirement and manage to cope.

Ok, I havn't actually checked the code , but no, they don't have the
same requirement. they pin and unpin the user space memory at the
beginning and and of the operations. 

take aio pseudo code:

aio_write()
{
	pinmem();
	if (file)
	add_write_to_disk_queue();  
	.
	.
	.


};

kernel_aio_completion_handler()
{
	unpinmem();
	send_completion_event_to_task();
};



-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

