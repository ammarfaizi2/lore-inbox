Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbTDKOWA (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbTDKOWA (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:22:00 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:19463 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264364AbTDKOV6 (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 10:21:58 -0400
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain
	backward compatibility
From: James Bottomley <James.Bottomley@steeleye.com>
To: Andries.Brouwer@cwi.nl
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, pbadari@us.ibm.com
In-Reply-To: <UTC200304111142.h3BBgDS11628.aeb@smtp.cwi.nl>
References: <UTC200304111142.h3BBgDS11628.aeb@smtp.cwi.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 11 Apr 2003 09:33:27 -0500
Message-Id: <1050071610.2078.69.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 06:42, Andries.Brouwer@cwi.nl wrote:
>     Here is my problem..
> 
>     #insmod ips.o
>       < found 10 disks>
>     #insmod qla2300.o
>       < found 10 disks>
>     #rmmod ips.o
>        <removed 10 disks>
>     #insmod ips.o
>       <found 10 disks - but new names>
> 
> OK, I see what you mean. I agree.

Could you elaborate on the reason you want to keep the minor space
compact?  I don't regard the insmod/rmmod problem as valid because if
you do:

rmmod ips.o
rmmod qla2300.o
insmod qla2300.o
insmod ips.o

All bets are off again. For small kernel dev_t it was essential to keep
a compact minor space because otherwise we coulde run out of minors. 
Sparse minors cause no inefficiency in the mid-layer, or in sd.  There
are problems in sg which could be solved by encoding the device type in
the minor.

> [I see that dougg wants to solve such things by properly naming,
> but that is a higher level. Given a large number space an
> easier solution is to give each module its own part of the
> number space.]

Please, no.  Dividing up the minor space like this would be a step
backwards (adding more policy to the kernel).  Someone would also have
to manage this scheme.

James


