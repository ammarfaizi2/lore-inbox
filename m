Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbTKXTJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 14:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263839AbTKXTJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 14:09:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:60546 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263834AbTKXTJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 14:09:14 -0500
Date: Mon, 24 Nov 2003 11:09:39 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: anand@eis.iisc.ernet.in (SVR Anand)
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, bridge@osdl.org
Subject: Re: 2.6.0-test9 : bridge freezes
Message-Id: <20031124110939.1cb3f87c.shemminger@osdl.org>
In-Reply-To: <200311221527.UAA29684@eis.iisc.ernet.in>
References: <200311221527.UAA29684@eis.iisc.ernet.in>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Nov 2003 20:57:44 +0530 (GMT+05:30)
anand@eis.iisc.ernet.in (SVR Anand) wrote:

> Hi,
> 
> I am one of the system administrators who manage a campus network of 5000 users
> that is connected to Internet. We have placed a Linux bridge to isolate the 
> Internet from the campus. To nullify network flooding effect, we have used 
> iptables. The kernel is 2.6.0-test9, the ethernet cards that are used are 
> RTL8139.
> 
> The problem is : After 3 to 4 hours of functioning, the bridge stops working 
> and the machine becomes unusable where it doesn't respond to keyboard, and 
> there is no video display. In simple terms it freezes. Before going in for 
> 2.6.0-test9 I have tried 2.4.20 with bridge patches for iptables support. It
> worked reliably except that I cannot even login from the console because 
> I don't get the shell prompt after a while. 
> 
> Presently I have gone back to 2.4.20 for the sake of robustness. Can someone
> let me know what I can do to use 2.6.x kernel with a good amount of confidence
> so that I can keep the campus users happy ? I am making guess work as
> to whether the problem is with the network drivers, or some power management 
> issues, and so on.
> 
> Any inputs from you will be really useful. I am eager to try out any amount
> of debugging, the thing is I don't know what to look for.
> 
> 
> Anand

Linus is right, this is probably a memory leak issue.  There are several areas
that could be the problem:
	- core networking 
	- iptables
		- iptables filter
	- ethernet bridging
	- ethernet driver (rtl8169)

To find/fix the problem, we need to narrow down the scope.  
Things that would help are, what are the iptables rules you are using?
Are there any errors showing up on the ethernet devices?
Also what does the bridge forwarding table look like? are there lots of entries, are
you running spanning tree?



