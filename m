Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266026AbUEUVob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266026AbUEUVob (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 17:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266027AbUEUVob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 17:44:31 -0400
Received: from [141.156.69.115] ([141.156.69.115]:10664 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S266026AbUEUVoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 17:44:10 -0400
Message-ID: <40AE7829.9060105@infosciences.com>
Date: Fri, 21 May 2004 17:44:09 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com> <20040521043032.GA31113@kroah.com> <40AE5DBB.6030003@infosciences.com> <20040521204430.GA5875@kroah.com>
In-Reply-To: <20040521204430.GA5875@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, May 21, 2004 at 03:51:23PM -0400, nardelli wrote:
> 
> 
> Patch is line-wrapped, so I can't apply it :(
> 
> 

Hmmm... I couldn't see the linewrap in the original I sent, or
in test ones that I did.  Probably my mail tool, but then it
is getting late on a Friday, which probably means that it is me.

To aid in diagnosing where I'm goofing up, could you point out
a spot where it is linewrapping?


>>@@ -456,7 +460,8 @@ static void visor_close (struct usb_seri
>>		return;
>>	
>>	/* shutdown our urbs */
>>-	usb_unlink_urb (port->read_urb);
>>+	if (port->read_urb)
>>+		usb_unlink_urb (port->read_urb);
> 
> 
> I really do not think these extra checks for read_urb all of the place
> need to be added.  We take care of it in the open() call, right?
> 
> 
> 

Yes - less clutter and more efficient too.

>>+	else if (retval != sizeof(*connection_info)) {
>>+		/* real invalid connection info handling is below */
>>+		num_ports = 0;
>>+	}
> 
> 
> Change this to a "if" instead of a "else if".
> Actually just set num_ports to 0 at the beginning of the function, and
> then just check for a valud retval and do the code below...
> 
> 

Yep - same comment as above.

>>+	else {
>>+	        connection_info = (struct visor_connection_info *)
>>+			transfer_buffer;
> 
> 
> 
> greg k-h
> 


-- 
Joe Nardelli
jnardelli@infosciences.com
