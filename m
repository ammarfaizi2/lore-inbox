Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131816AbRCQVkO>; Sat, 17 Mar 2001 16:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131819AbRCQVkE>; Sat, 17 Mar 2001 16:40:04 -0500
Received: from [216.161.55.93] ([216.161.55.93]:44029 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131816AbRCQVjs>;
	Sat, 17 Mar 2001 16:39:48 -0500
Date: Sat, 17 Mar 2001 13:43:18 -0800
From: Greg KH <greg@kroah.com>
To: Junfeng Yang <yjf@stanford.edu>
Cc: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 120 potential dereference to invalid pointers errors for linux 2.4.1
Message-ID: <20010317134318.A6382@wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, Junfeng Yang <yjf@stanford.edu>,
	linux-kernel@vger.kernel.org, mc@cs.stanford.edu
In-Reply-To: <Pine.GSO.4.31.0103170126540.14147-100000@elaine24.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0103170126540.14147-100000@elaine24.Stanford.EDU>; from yjf@stanford.edu on Sat, Mar 17, 2001 at 01:30:54AM -0800
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2001 at 01:30:54AM -0800, Junfeng Yang wrote:
> ---------------------------------------------------------
> [BUG] dereference to invalid pointer "bluetooth" in error message
> /u2/acc/oses/linux/2.4.1/drivers/usb/bluetooth.c:924:bluetooth_read_bulk_callback: ERROR:NULL:828:924: Using NULL ptr "bluetooth" illegally! set by 'get_usb_bluetooth':828
> 
> Start --->
> 	struct usb_bluetooth *bluetooth = get_usb_bluetooth ((struct usb_bluetooth *)urb->context, __FUNCTION__);
> 	unsigned char *data = urb->transfer_buffer;
> 	unsigned int count = urb->actual_length;
> 	unsigned int i;
> 	unsigned int packet_size;
> 
> 	... DELETED 88 lines ...
> 
> 		bluetooth->bulk_packet_pos = 0;
> 	}
> 
> exit:
> Error --->
> 	FILL_BULK_URB(bluetooth->read_urb, bluetooth->dev,
> 		      usb_rcvbulkpipe(bluetooth->dev, bluetooth->bulk_in_endpointAddress),

This has already been fixed in a patch that was sent to the
linux-usb-devel and bluetooth mailing lists, but hasn't made it into the
kernel tree yet.

But good catch!

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
http://immunix.org/~greg
