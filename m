Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWIDOgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWIDOgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 10:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWIDOgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 10:36:50 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:18155 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751400AbWIDOgs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 10:36:48 -0400
Subject: Re: Kernel patches enabling better POSIX AIO (Was Re: [3/4]
	kevent: AIO, aio_sendfile)
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: suparna@in.ibm.com, Badari Pulavarty <pbadari@us.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, linux-aio@kvack.org
In-Reply-To: <44DE27AB.7040507@redhat.com>
References: <44C77C23.7000803@redhat.com> <44C796C3.9030404@us.ibm.com>
	 <1153982954.3887.9.camel@frecb000686> <44C8DB80.6030007@us.ibm.com>
	 <44C9029A.4090705@oracle.com>
	 <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
	 <44C90987.1040200@redhat.com>
	 <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
	 <1154091500.13577.14.camel@frecb000686> <44DCDE73.9030901@redhat.com>
	 <20060812182928.GA1989@in.ibm.com>  <44DE27AB.7040507@redhat.com>
Date: Mon, 04 Sep 2006 16:36:40 +0200
Message-Id: <1157380601.3895.53.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/09/2006 16:42:14,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 04/09/2006 16:42:16,
	Serialize complete at 04/09/2006 16:42:16
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-08-12 at 12:10 -0700, Ulrich Drepper wrote:
> Suparna Bhattacharya wrote:
> > I am wondering about that too. IIRC, the IO_NOTIFY_* constants are not
> > part of the ABI, but only internal to the kernel implementation. I think
> > Zach had suggested inferring THREAD_ID notification if the pid specified
> > is not zero. But, I don't see why ->sigev_notify couldn't used directly
> > (just like the POSIX timers code does) thus doing away with the 
> > new constants altogether. Sebestian/Laurent, do you recall?
> 
> I suggest to model the implementation after the timer code which does
> exactly what we need.
> 

  Will do.

> 
> > I'm guessing they are being used for validation of permissions at the time
> > of sending the signal, but maybe saving the task pointer in the iocb instead
> > of the pid would suffice ?
> 
> Why should any verification be necessary?  The requests are generated in
> the same process which will receive the notification.  Even if the POSIX
> process (aka, kernel process group) changes the IDs the notifications
> should be set.  The key is that notifications cannot be sent to another
> POSIX process.
> 
> Adding this as a feature just makes things so much more complicated.
> 

  Agreed.

  Sébastien.


-- 
-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

