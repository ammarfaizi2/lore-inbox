Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbULQQon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbULQQon (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 11:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbULQQon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 11:44:43 -0500
Received: from dsl027-176-166.sfo1.dsl.speakeasy.net ([216.27.176.166]:48308
	"EHLO waste.org") by vger.kernel.org with ESMTP id S261870AbULQQoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 11:44:38 -0500
Date: Fri, 17 Dec 2004 08:44:19 -0800
From: Matt Mackall <mpm@selenic.com>
To: Park Lee <parklee_sel@yahoo.com>
Cc: pmarques@grupopie.com, mingo@redhat.com, linux-os@chaos.analogic.com,
       linux-kernel@vger.kernel.org, ipsec-tools-devel@lists.sourceforge.net
Subject: Re: Issue on netconsole vs. Linux kernel oops
Message-ID: <20041217164419.GO2767@waste.org>
References: <20041217121220.9782.qmail@web51510.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217121220.9782.qmail@web51510.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 04:12:20AM -0800, Park Lee wrote:
> On Thu, 16 Dec 2004 at 10:55, Matt Mackall wrote:
> >
> > On Thu, Dec 16, 2004 at 10:48:27AM -0800, Park Lee 
> > wrote:
> > > Hi,
> > > I'd like to use netconsole to send local Linux
> > > kernel's final messages (i.e. oops) to remote 
> > > machine when the kernel crashes. 
> > > Now I can successfully use a built-in netconsole 
> > > to send some loacl kernel messages to the remote 
> > > machine.(the parameter I send to local kernel on 
> > > kernel command line is 
> > > "netconsole=@192.168.0.2/,514@192.168.0.1/", I run
> > > syslogd in remote machine). For example, When the
> > > local kernel is booting, it will send a message
> > > "192.168.0.2 audit(1103247021.091:0): 
> > > initialized" to remote machine through 
> > > netconsole, and the syslogd on remote machine 
> > > will write the message to /var/log/messages on 
> > > remote machine.
> > >  What CONFUSE me most is that when the kernel
> > > crashes, there is NO message (oops) about the 
> > > crash being wrote down by syslogd on remote 
> > > machine to remote /var/log/messages file at all!! 
> > >   But in the mean time, We can see the outputs of
> > > tcpdump on the remote machine, they are some thing
> > > like the following:
> > >
> > >01:36:56.692877 IP 192.168.0.2.6665 >
> > >192.168.0.1.syslog: UDP, length 48
> > >01:36:56.692930 IP 192.168.0.2.6665 >
> > >192.168.0.1.syslog: UDP, length 29
> > >01:36:56.692982 IP 192.168.0.2.6665 >
> > >192.168.0.1.syslog: UDP, length 15
> > >01:36:56.693034 IP 192.168.0.2.6665 >
> > >192.168.0.1.syslog: UDP, length 9
> > >01:36:56.693086 IP 192.168.0.2.6665 >
> > >192.168.0.1.syslog: UDP, length 16
> > >01:36:56.693121 IP 192.168.0.2.6665 >
> > >192.168.0.1.syslog: UDP, length 16
> > >   ... ...
> > > From these messages, we can see that the 
> > > netconsole actually have sent the final messages 
> > > (oops) to remote machine when the local kernel 
> > > crashed. But there are no corresponding messages 
> > > recorded by syslogd on remote machine 
> > > to /var/log/messages.
> >
> > From your description, it sounds like syslogd is at 
> > fault. Try using netcat on the remote machine.
> 
>   Today, I have a try using netcat. But I found that
> the problem still exist!
>   By accident, I found that this problem is related to
> native IPsec that runs between my local machine and
> the remote machine. 
>   I'm using IPsec-Tools ( which including racoon,
> setkey) as the user-space tools for the native IPsec
> of linux kernel. Only if I run the command "setkey -f
> /etc/ipsec.conf" on the remote machine, the syslogd
> (or netcat) running on the remote machine will unable
> to record the messages that have been reached the
> remote machine. If I'm not run this command on remote
> machine, the syslogd/netcat will be able to record the
> arrived messages. (the /etc/ipsec.conf on the remote
> machine is shown in the end.)
>   Then, CAN'T netconsole be used in the IPsec
> environment (with IPsec-Tools)? How can we solve this
> problem?

Netconsole builds very simple IPv4 packets by hand without the use of
the rest of the IP stack. This is how it continues to work when the
system is crashing. So it will never be able to build IPSEC packets.
Nor is it likely to do IPv6 any time soon.

You can probably get it to work by using a different IP address for
netconsole than you use for IPSEC, and set up the receiving end to
recognize packets from that address as normal unencrypted IPv4.
-- 
Mathematics is the supreme nostalgia of our time.
