Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131191AbRCTW01>; Tue, 20 Mar 2001 17:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131226AbRCTW0R>; Tue, 20 Mar 2001 17:26:17 -0500
Received: from monza.monza.org ([209.102.105.34]:8453 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131191AbRCTW0C>;
	Tue, 20 Mar 2001 17:26:02 -0500
Date: Tue, 20 Mar 2001 14:24:43 -0800
From: Tim Wright <timw@splhi.com>
To: Doug Ledford <dledford@redhat.com>
Cc: David Ford <david@blue-labs.org>, Peter Lund <firefly@netgroup.dk>,
        Pozsar Balazs <pozsy@sch.bme.hu>, linux-kernel@vger.kernel.org
Subject: Re: esound (esd), 2.4.[12] chopped up sound -- solved
Message-ID: <20010320142443.A2567@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Doug Ledford <dledford@redhat.com>,
	David Ford <david@blue-labs.org>, Peter Lund <firefly@netgroup.dk>,
	Pozsar Balazs <pozsy@sch.bme.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.30.0103201832260.15849-100000@balu> <3AB7A2CB.64ED61F3@netgroup.dk> <3AB7B477.2A740CE0@blue-labs.org> <3AB7BB59.9513514C@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AB7BB59.9513514C@redhat.com>; from dledford@redhat.com on Tue, Mar 20, 2001 at 03:19:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not necessarily. For a write to a disk file, it would be an error to return a
short write except in an error situation. For devices, the rules are looser.
Quoting Stevens APUE p.406, "Some devices, notably terminals, networks, and any
SVR4 streams devices have the following two properties.
...
2 A write operation can also return less that we specified. This may be caused
by flow control constraints by downstream modules, for example. Again it's not
an error, and we should continue writing the remainder of the data. (Normally
this short return from a write only occurs with a nonblocking descriptor or if
a signal is caught."

So, whilst I personally find drivers that return a short write without
O_NONBLOCK set to be rather obnoxious, it's not illegal, and you have to code
accordingly :-)

Tim

On Tue, Mar 20, 2001 at 03:19:37PM -0500, Doug Ledford wrote:
> David Ford wrote:
> > 
> > Actually you probably upgraded to a non-broken version of esd.  Stock esd -still-
> > writes to the socket without regard to return value.  If the write only accepted
> > 2098 of 4096 bytes, the residual bytes are lost, esd will write the next packet at
> > 4097, not 2099.  esd is incredibly bad about err checking as is old e stuff.
> > 
> > I posted my last patch for esd here and to other places in June of 2000.  All it
> > does is check for return value and adjust the writes accordingly.  For reference,
> > the patch is at http://stuph.org/esound-audio.c.patch.
> 
> Why would esd get a short write() unless it is opening the file in non
> blocking mode (which I didn't see when I was working on the i810 sound
> driver)?  If esd is writing to a file in blocking mode and that write is
> returning short, then that sounds like a driver bug to me.
> 
> -- 
> 
>  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
>       Please check my web site for aic7xxx updates/answers before
>                       e-mailing me about problems
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
