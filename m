Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbSIXXeO>; Tue, 24 Sep 2002 19:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261847AbSIXXeO>; Tue, 24 Sep 2002 19:34:14 -0400
Received: from patan.Sun.COM ([192.18.98.43]:55783 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S261840AbSIXXeN>;
	Tue, 24 Sep 2002 19:34:13 -0400
Message-ID: <3D90F78E.1060405@sun.com>
Date: Tue, 24 Sep 2002 16:38:54 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Brad Hards <bhards@bigpond.net.au>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: alternate event logging proposal
References: <20020924073051.363D92C1A7@lists.samba.org> <3D90C4FE.3070909@pobox.com> <3D90D0FB.1070805@sun.com> <200209250832.35068.bhards@bigpond.net.au> <3D90F5D3.4070504@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Brad Hards wrote:
> 
>> I liked the /sbin/hotplug arrangement (aka call_usermode_helper). In 
>> fact, my plan was to add the call_usermode_helper call to the 
>> netif_carrier_[on,off] functions. Unfortuantely, I've been to too many 
>> of Rusty's talks, and know that calling a function that is only safe 
>> in user context is unlikely to be a good idea in 
>> netif_carrier_[on,off], which are more than likely running in 
>> interrupt context.
> 
> 
> 
> You really want something where a userspace app can sleep on an fd, to 
> be awakened when link changes (or some other interesting event occurs)

I tend to agree - I like either of the models:

a bunch of little single-value files that can be polled and read

  or

a single device_event file that a daemon reads and dispatches events (I 
like this one because the daemon is already written, just poorly named - 
acpid)

For things like netif_carrier, poll() is probably best - the DHCP client 
can be fully self contained, and not need an eventd to alert it to a 
signal change.  Of course, acpid does support UNIX socket connections 
from apps like DHCP....



-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

