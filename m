Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264515AbUEXRVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264515AbUEXRVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 13:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264527AbUEXRVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 13:21:13 -0400
Received: from [141.156.69.115] ([141.156.69.115]:33967 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S264515AbUEXRUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 13:20:47 -0400
Message-ID: <40B22EED.4080808@infosciences.com>
Date: Mon, 24 May 2004 13:20:45 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com> <40AE7829.9060105@infosciences.com> <40AE7CFE.5060805@infosciences.com> <20040521223024.GA7399@kroah.com>
In-Reply-To: <20040521223024.GA7399@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, May 21, 2004 at 06:04:46PM -0400, nardelli wrote:
> 
>>Maybe I spoke too soon here.  We have 1 bulk in, 2 bulk out, and 1 interrupt
>>in endpoint, which by the logic in usb-serial, translates to 2 ports.  Only
>>one of those ports can have a read_urb associated with it, unless we want to
>>do some really fancy juggling.  This means that we're going to have a port
>>that does not have a valid read_urb associated with it, even after open().
> 
> 
> But the call to open() fails, which prevents any of the other tty calls
> from happening on that port.  That's why we don't need to make that
> check anywhere else.
> 
> 

The call to open() does not fail - with only a write_urb associated with it,
it's not a very interesting port, but data can be written to it, at least in
small quantities (see below).  The first patch that I submitted had a bug
(which I've fixed) in it 
http://marc.theaimsgroup.com/?l=linux-usb-devel&m=108515267617337&w=2
that Pete Zaitcev pointed out in visor_open() that might be confusing the 
issue.

The behavior that I intended was to allow devices that have more bulk out
endpoints than bulk in endpoints (namely treos) to still use the write only
port.  Mainly though, it was to allow for swapping endpoints to allow for
the uneven number of in and out endpoints.  This was not a problem prior to
now since the endpoints were being copied instead of swapped.


>>I'm at a loss why this device has an uneven number of bulk in and bulk out
>>endpoints.
> 
> 
> Stupid hardware engineers?  Who really knows...
> 

I bet someone really smart will figure it out - it probably just melts the ROM,
or something else useful :-)


One more question - my system does not really like it when I redirect /dev/urandom
to either the first or second port.  I know that it obviosuly makes no sense to
do such a thing, but is it expected that there should be no problems associated
with this.  I'm not finished testing, so I'm not sure how severe a problem develops.
I'll report in when I know more about this.


-- 
Joe Nardelli
jnardelli@infosciences.com
