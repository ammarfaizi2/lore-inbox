Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbTAMJSr>; Mon, 13 Jan 2003 04:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267683AbTAMJSr>; Mon, 13 Jan 2003 04:18:47 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11784 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267648AbTAMJSq>; Mon, 13 Jan 2003 04:18:46 -0500
Date: Mon, 13 Jan 2003 09:27:34 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] add module reference to struct tty_driver
Message-ID: <20030113092734.C12379@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20030113054708.GA3604@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030113054708.GA3604@kroah.com>; from greg@kroah.com on Sun, Jan 12, 2003 at 09:47:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:47:09PM -0800, Greg KH wrote:
> In digging into the tty layer locking, I noticed that the tty layer
> doesn't handle module reference counting for any tty drivers.  Well, I've
> known this for a long time, just finally got around to fixing it :)
> Here's a patch against 2.5.56 that should fix this issue (works for
> me...)
> 
> Comments?  If no one objects, I'll send it on to Linus, and add support
> for this to a number of tty drivers that commonly get built as modules.

I'd just ask whether you considered what happens when:

1. two people open the same tty
2. the tty is hung up
3. both people close the tty

(this isn't an indication that the patch is wrong, I'm just interested
to know.)

I'll test its behaviour later today - the current rules for incrementing/
decrementing the tty driver module use counts are rediculous at present,
and this patch would solve it nicely.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

