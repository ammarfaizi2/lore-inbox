Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131774AbRCQVop>; Sat, 17 Mar 2001 16:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131815AbRCQVoe>; Sat, 17 Mar 2001 16:44:34 -0500
Received: from [216.161.55.93] ([216.161.55.93]:35823 "EHLO blue.int.wirex.com")
	by vger.kernel.org with ESMTP id <S131774AbRCQVo2>;
	Sat, 17 Mar 2001 16:44:28 -0500
Date: Sat, 17 Mar 2001 13:47:58 -0800
From: Greg KH <greg@kroah.com>
To: Seth Andrew Hallem <shallem@Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Potential free/use-after-free bugs
Message-ID: <20010317134758.B6382@wirex.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Seth Andrew Hallem <shallem@Stanford.EDU>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010316221730.B17586@elaine23.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010316221730.B17586@elaine23.stanford.edu>; from shallem@Stanford.EDU on Fri, Mar 16, 2001 at 10:17:30PM -0800
X-Operating-System: Linux 2.4.2-immunix (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2001 at 10:17:30PM -0800, Seth Andrew Hallem wrote:
> [BUG] Potential double or more free.
> /home/shallem/oses/linux/2.4.1/drivers/usb/serial/belkin_sa.c:236:belkin_sa_shutdown:
> ERROR:FREE:237:236: Use-after-free of 'private'! set by 'kfree':237
> 
> 		}
> 		/* My special items, the standard routines free my urbs */
> 		if (serial->port->private)
> Error --->
> Start --->
> 			kfree(serial->port->private);
> 	}
> 
> [BUG] Copy paste of above potential bug.
> /home/shallem/oses/linux/2.4.1/drivers/usb/serial/mct_u232.c:277:mct_u232_shutdown:
> ERROR:FREE:278:277: Use-after-free of 'private'! set by 'kfree':278
> 
> [BUG]

Damn fine catch, the author meant to say serial->port[i].private there.

Thanks, I'll fix these up.

greg k-h

-- 
greg@(kroah|wirex).com
