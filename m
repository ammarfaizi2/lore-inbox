Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264695AbUEUUWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264695AbUEUUWu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbUEUUWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:22:50 -0400
Received: from [141.156.69.115] ([141.156.69.115]:55207 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S264695AbUEUUWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:22:47 -0400
Message-ID: <40AE6509.5070507@infosciences.com>
Date: Fri, 21 May 2004 16:22:33 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jkroon@cs.up.ac.za
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com>    <20040521043032.GA31113@kroah.com>    <40AE5DBB.6030003@infosciences.com> <36233.165.165.44.119.1085169684.squirrel@165.165.44.119>
In-Reply-To: <36233.165.165.44.119.1085169684.squirrel@165.165.44.119>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jkroon@cs.up.ac.za wrote:
>>I've made all of the changes that recommended below.  If it looks like
>>I've missed anything, please indicate so.
>>
>>
> 
> 
> [snip]
> 
> 
>>>>+	if (num_ports <= 0 || num_ports > 2) {
>>>
>>>
>>>I like the idea of this check, but you are trying to test for a negative
>>>value on a __u16 variable, which is always unsigned.  So that check will
>>>never be true :)
> 
> 
> What happens if num_ports == 0?  Not that hardware should ever report that.
> 
> [snip]
> 
> 

Short answer:
A warning is logged and num_ports defaults to 2.

Long answer:

Unfortunately, it does not apear that this class of device sends any kind of
connect info back in repsonse to VISOR_GET_CONNECTION_INFORMATION,
PALM_GET_EXT_CONNECTION_INFORMATION, or for that matter any request under
200 (or some similiar number - I don't remember how far I tested).

Based upon a usb packet capture under windoze, I believe that the device
is not capable of this.  I'd really like some kind of documentation on
the connection protocol, but I've come up completely empty handed in that
regard.

The packet capture available at
http://bugzilla.kernel.org/attachment.cgi?id=2924&action=view shows the
attempt to send both VISOR_GET_CONNECTION_INFORMATION (3) and 
PALM_GET_EXT_CONNECTION_INFORMATION (4) requests.  Both times nothing is
returned.

In any case, when no valid connection info is found, num_ports is initially
set to 0, a warning is logged, and num_ports defaults to 2.


-- 
Joe Nardelli
jnardelli@infosciences.com
