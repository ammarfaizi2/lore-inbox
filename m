Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264415AbTDKQNz (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTDKQNz (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:13:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58290 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263022AbTDKQNx convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 12:13:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>, Andries.Brouwer@cwi.nl
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Date: Fri, 11 Apr 2003 08:21:46 -0800
User-Agent: KMail/1.4.1
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <UTC200304111142.h3BBgDS11628.aeb@smtp.cwi.nl> <1050071610.2078.69.camel@mulgrave>
In-Reply-To: <1050071610.2078.69.camel@mulgrave>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200304110921.46848.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 April 2003 07:33 am, James Bottomley wrote:
> On Fri, 2003-04-11 at 06:42, Andries.Brouwer@cwi.nl wrote:
> >     Here is my problem..
> >
> >     #insmod ips.o
> >       < found 10 disks>
> >     #insmod qla2300.o
> >       < found 10 disks>
> >     #rmmod ips.o
> >        <removed 10 disks>
> >     #insmod ips.o
> >       <found 10 disks - but new names>
> >
> > OK, I see what you mean. I agree.
>
> Could you elaborate on the reason you want to keep the minor space
> compact?  I don't regard the insmod/rmmod problem as valid because if
> you do:
>
> rmmod ips.o
> rmmod qla2300.o
> insmod qla2300.o
> insmod ips.o
>
> All bets are off again. For small kernel dev_t it was essential to keep
> a compact minor space because otherwise we coulde run out of minors.
> Sparse minors cause no inefficiency in the mid-layer, or in sd.  There
> are problems in sg which could be solved by encoding the device type in
> the minor.

Here user/admin atleast knows what he is doing. So they have to deal
with it. (Proper device naming solution would be great here).

But just by doing rmmod/insmod if my device names change, it will
be a pain. For example, in my case, i have to re-do all my raw device
bindings to just start the database. This will be a problem with 
dynamic <major, minor> assignments also. (Again, i will need a proper
device naming solution here).

Thanks,
Badari

