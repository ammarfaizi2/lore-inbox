Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262136AbTEELS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 07:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbTEELS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 07:18:56 -0400
Received: from elin.scali.no ([62.70.89.10]:36228 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S262136AbTEELSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 07:18:55 -0400
Subject: Re: The disappearing sys_call_table export.
From: Terje Eggestad <terje.eggestad@scali.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, D.A.Fedorov@inp.nsk.su
In-Reply-To: <1052133798.2821.122.camel@pc-16.office.scali.no>
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	 <20030505092324.A13336@infradead.org>
	 <1052127216.2821.51.camel@pc-16.office.scali.no>
	 <20030505112531.B16914@infradead.org>
	 <1052133798.2821.122.camel@pc-16.office.scali.no>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1052134278.2821.131.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 May 2003 13:31:19 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 2003-05-05 at 13:23, Terje Eggestad wrote:

> 
> > Again, where's your driver source so we can help you to find a better
> > approach out of that mess?
> >  
> 
> The trace module we made to trace munmap() and sbrk() could be opened,
> but you'll be disappointed since all the pinning ( get_user_pages() and
> friends), send() recv() etc are in the drivers for the various hardware,
> most of which are not our property.  
> 
> The module works as follows. It catches sbrk(-arg) and munmap() and lays
> out the trace info in a memory area mmap()'able thru the device file.  
> So when processes need the trace info they have the info in memory to
> avoid doing a ioctl().
> 
> Thats all we need to know if a given virtual address needs to be
> (re)pinned. 
> 

In all fairness this should be done in glibc, but the task of getting it
done there was several orders of magnitude larger than just adding the
syscall intercepts. Serves you right for writing clean code :-)
 
The thing is of course this *worked* until someone decided to remove the
export of sys_call_table. 

Which is a decision that is most probably right, I just need another way
of getting  a hook or notification of the sys calls. 





> 
> 
> TJ
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

