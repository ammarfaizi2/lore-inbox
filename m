Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKKC3x>; Fri, 10 Nov 2000 21:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129250AbQKKC3d>; Fri, 10 Nov 2000 21:29:33 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:34053 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129213AbQKKC31>; Fri, 10 Nov 2000 21:29:27 -0500
Date: Fri, 10 Nov 2000 20:25:27 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: David Ford <david@linux.com>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, sendmail-bugs@sendmail.org,
        linux-kernel@vger.kernel.org
Subject: Re: Wild thangs, was: sendmail fails to deliver mail with attachments in /var/spool/mqueue
Message-ID: <20001110202527.A3342@vger.timpanogas.org>
In-Reply-To: <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com> <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <3A0C929B.EE6F7137@linux.com> <3A0C9277.273FA907@timpanogas.org> <3A0C96FD.8441F995@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A0C96FD.8441F995@linux.com>; from david@linux.com on Fri, Nov 10, 2000 at 04:46:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 04:46:53PM -0800, David Ford wrote:
> To be honest Jeff, most of my sendmail systems have default load values
> and large (read created by microsoft mua) emails make it through
> constantly with no distinguishable delays.  I just launched 45 "cat
> core|mail david@kalifornia.com" and core is a 10 meg binary file.  It
> results in a 14 meg total message size.
> 
> The load spiked to .75 and dropped back to .45 while launching.  I started
> them two minutes ago and they are all in client DATA phase with the remote
> MTA at the moment.  I only have 30K/s upstream.
> 
> At present the load is .10 and the net is hopping.  This isn't a power box
> and the rest of the system is running as well.
> 
> My guess is that the system reporting the problem has an elevated load
> average from those 11 modprobes stuck in D state.

They're not modprobes, they're misnamed processes sleeping from NWFS.  
I got the fix from someone so now they display their proper names.
top displays the names correctly, ps does not.  Several people have 
verified this problem, and all you are saying is that your servers
are never heavily loaded for long periods of time, say 200 hours
at a stretch of consatnt ftp traffic?

Jeff


> 
> I manage servers that transport hundreds of thousands of emails daily and
> their load is minimal.  They handle large messages fine.  The only
> defaults I've really had to change are the max children and some of the
> timing simply because I want stalled connections (read routing loss) to
> requeue quickly.
> 
> -d
> 
> 
> "Jeff V. Merkey" wrote:
> 
> > David Ford wrote:
> >
> > David,
> >
> > We got to the bottom of it.  sendmail is using a BSD method to react to
> > load average which is different than what linux is providing.  You have
> > to crank up
> >
> > O QueueLA = 18
> > O RefuseLA = 12
> >
> > on a busy Linux server since the defaults will result in large emails
> > never getting sent.
> >
> > Jeff
> 
> --
> "The difference between 'involvement' and 'commitment' is like an
> eggs-and-ham breakfast: the chicken was 'involved' - the pig was
> 'committed'."
> 
> 

Content-Description: Card for David Ford

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
