Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130451AbRBCAkN>; Fri, 2 Feb 2001 19:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbRBCAkE>; Fri, 2 Feb 2001 19:40:04 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:16682 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S130451AbRBCAj6>; Fri, 2 Feb 2001 19:39:58 -0500
Message-ID: <3A7B52D8.733CFECC@sgi.com>
Date: Fri, 02 Feb 2001 16:37:44 -0800
From: Rajagopal Ananthanarayanan <ananth@sgi.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16-4SGI_20smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Benjamin LaHaise <bcrl@redhat.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>, linux-aio@kvack.org,
        kiobuf-io-devel@lists.sourceforge.net,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: [Kiobuf-io-devel] Re: 1st glance at kiobuf overhead in kernelaiovs  
 pread vs user aio
In-Reply-To: <Pine.LNX.4.30.0102030023530.8627-100000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Fri, 2 Feb 2001, Rajagopal Ananthanarayanan wrote:
> 
> > Do you really have worker threads? In my reading of the patch it seems
> > that the wtd is serviced by keventd. [...]
> 
> i think worker threads (or any 'helper' threads) should be avoided. It can
> be done without any extra process context, and it should be done that way.
> Why all the trouble with async IO requests if requests are going to end up
> in a worker thread's context anyway? (which will be a serializing point,
> otherwise why does it end up there?)
> 

Good point. Can you expand on how you plan to service pending
chunks of work (eg. issuing readpage() on some pages) without
the use of threads?

thanks,


--------------------------------------------------------------------------
Rajagopal Ananthanarayanan ("ananth")
Member Technical Staff, SGI.
--------------------------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
