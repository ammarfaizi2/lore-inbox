Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSE2D3W>; Tue, 28 May 2002 23:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314094AbSE2D3V>; Tue, 28 May 2002 23:29:21 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:42188 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S314080AbSE2D3V>;
	Tue, 28 May 2002 23:29:21 -0400
Date: Wed, 29 May 2002 13:28:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 orinoco.c __orinoco_ev_rx question
Message-ID: <20020529032822.GA16537@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020528160135.D24097@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2002 at 04:01:35PM +0200, Wolfgang Wegner wrote:
> Hi all,
> 
> after sorting out my sk_buff problem [turned out to be problems with
> pcmcia-cs-3.1.33's own include files, which throw away some of the kernel's
> config options, thus affecting struct sk_buff declaration] i am now
> investigating some things in orinoco.c of 2.4.18, which seems almost
> identical to the one from pcmcia-cs
> 
> My concern is, if it is really necessary to do the whole rx work in the
> interrupt handler, or a bottom half could be used here?
> I ask because like this, the interrupt is set for about 800us in a
> whole-frame (MTU) receive, which IMHO is not really desirable. I have to
> admit i still did not really understand the use of FIDs, so i am not sure,
> but couldn't this be taken out of the interrupt handler itself?

No it doesn't have to be done in the interrupt handler, it could be
done in a bottom half.  However essentially every other network driver
does all the Rx work (up to netif_rx()) in the hard irq, so I'm
disinclined to do it otherwise.

> (Of course, i can simply implement and try it, but as i am absolutely
> not aware about the use of FIDs, i do not want to risk introducing any
> nice subtle bugs...)



-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson
