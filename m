Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSJQQtR>; Thu, 17 Oct 2002 12:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbSJQQtR>; Thu, 17 Oct 2002 12:49:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55312 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261724AbSJQQtP>;
	Thu, 17 Oct 2002 12:49:15 -0400
Message-ID: <3DAEEB59.2000000@pobox.com>
Date: Thu, 17 Oct 2002 12:54:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
CC: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device-mapper submission 6/7
References: <20021015175858.GA28170@fib011235813.fsnet.co.uk> <3DAC5B47.7020206@pobox.com> <20021015214420.GA28738@fib011235813.fsnet.co.uk> <3DAD75AE.7010405@pobox.com> <20021016152047.GA11422@fib011235813.fsnet.co.uk> <3DAD8CC9.9020302@pobox.com> <20021017080552.GA2418@fib011235813.fsnet.co.uk> <m3fzv5pj23.fsf@averell.firstfloor.org> <20021017085045.GA2651@fib011235813.fsnet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber wrote:
> The thing I'm not sure about is how to map the supend/resume semantics
> onto the fs.  It is tempting to bind suspend to an writeable open of
> the TABLE file, and resume to the closing of the device.  However that
> means that closing the device both indicates the end of the table and
> a resume, I'm not sure that is good enough, eg, if the table is bogus
> we don't neccessarily want to automatically resume the old table.  So
> this leads us to start thinking about a sepearate SUSPENDED file that
> we write a 1 or 0 to, yuck.


A popular way which also resolves atomicity issues is to just have a 
'control' file, to which you write(2) a command code and 
command-specific data, and read(2) results of the operation (if any). 
This would allow you to do a new-table command, a suspend command, a 
resume-with-existing-table command, a resume-with-new-table command, 
etc.  In other words, a more flexible ioctl(2) ;-)

Preferred method of data input is always ASCII, but if that is 
unreasonable, make sure your binary data is fixed-endian and fixed-size 
on all architectures.

	Jeff



