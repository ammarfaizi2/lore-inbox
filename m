Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264943AbTF3PXU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 11:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264958AbTF3PXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 11:23:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264943AbTF3PXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 11:23:17 -0400
Date: Mon, 30 Jun 2003 08:37:25 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
Message-Id: <20030630083725.25ffb48a.shemminger@osdl.org>
In-Reply-To: <3F004302.4070907@nortelnetworks.com>
References: <3EFFA1EA.7090502@nortelnetworks.com>
	<16128.7306.58928.879567@cargo.ozlabs.ibm.com>
	<3F004302.4070907@nortelnetworks.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jun 2003 10:02:42 -0400
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> Paul Mackerras wrote:
> 
> > Is this the user-mode pppoe or the in-kernel pppoe?  IOW, are you
> > using the pppoe channel type, or do you have the usermode program that
> > runs pppd behind a pty?
> 
> I believe its the Roaring Penguin usermode one.  I'm fairly sure PPPOE 
> isn't enabled in the kernel.  I'm at work now, so it'll have to wait 
> till this evening to make sure.
> 
> > And, do you have any TCP connections open over the link when you take
> > it down?
> 
> On at least some of the occasions there should have been no connections 
> open as the machine had just booted and the first thing I did after X 
> came up was to shutdown adsl.
> 
> > What version of pppd is it?
> 
> Not sure--will check later.  Pretty sure its Mandrake 9 default.
> 
> > Has anyone been able to replicate this without using pppoe?  The type
> > of channel shouldn't make any difference, but I just tried ppp over a
> > pty and it worked fine (except that Deflate is broken, but that's
> > another problem).
> 
> Note that I can only reliably reproduce it if the dsl connection is 
> brought up at init time.  If I don't bring it up automatically at init 
> but manually bring it up later, the problem doesn't seem to occur.
> 
> Chris

PPP did have problems keeping track of the tty until the latest round
if fixes (2.5.73+).  The ppp_async module wasn't using owner fields as
reqired.


 Also, see if bringing down the ppp connection with ifconfig
before attempting the rmmod helps. i.e.
	ifconfig ppp0 down
