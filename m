Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264124AbTCXGcY>; Mon, 24 Mar 2003 01:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264125AbTCXGcY>; Mon, 24 Mar 2003 01:32:24 -0500
Received: from cimice4.netroute.cz ([212.71.168.94]:61638 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S264124AbTCXGcW>; Mon, 24 Mar 2003 01:32:22 -0500
Date: Mon, 24 Mar 2003 07:43:28 +0100
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: GETHOSTBYNAME()
Message-ID: <20030324064328.GE8167@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org,
	kernelnewbies@nl.linux.org
References: <F88IYUmwO9suAkWORuX000101d2@hotmail.com> <Pine.LNX.4.44.0303241019280.13253-100000@students.iiit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303241019280.13253-100000@students.iiit.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 10:25:11AM +0530, Prasad wrote:
> 
> hi,
> 	i dont think there is one similar to gethostbyname in the 
> kernel-space.  I do think so because most of the work done by 
> gethostbyname is based on the nameservices and is generally not required 
> in the kernel-space.  Implementing it should not be that big a problem.
> once you have the IP of the name server (/etc/resolve.conf???) you can 
> always connect to it and get the IP of the given host.

Implementing it is a big problem, since gethostbyname usualy means a DNS
lookup. Best way to do it in kernel is
call_usermode_helper('/sbin/khost') and call gethostbyname in there.

> On Mon, 24 Mar 2003, shesha bhushan wrote:
> 
> > Hi All
> > I am trying to find the gethostbyname() equivalent function in kernel space. 
> > Does any one know that.
> > The reason is...
> > I am using UDP to transfer data from one machine to another. It is not one 
> > time transfer. Once I get a message from machine A; I need to send some 
> > message back to Machine A from Machine B. For that I was using the following 
> > lines in user space program. I need to do the same in kernel space. Could 
> > any one help me out in this.
> > 
> > struct hostent *data;
> > struct sockaddr_in server;
> > int sock;
> > 
> >   sock = socket(AF_INET, SOCK_DGRAM , 0)
> > 
> > /* binding and all are done here */
> > 
> >   data = gethostbyname("158.168.1.1");

However as long as you are resolving IP address, you should not ask for
gethostbyname. You should ask for inet_aton, which does exist (the name
was mentioned in some list (linux-kernel or this one) not long ago, but
I do not remember it).

> >   memcpy (&server.sin_addrs, data->h_addr, data->h_length);
> >   retval = sendto(sock,msg,sizeof(msg), 0, (struct sockaddr *) &server, 
> > sizeof server);
> > 
> > 
> > Thanking You
> > Shesha
> > 
> > _________________________________________________________________
> > Cricket - World Cup 2003 http://server1.msn.co.in/msnspecials/worldcup03/ 
> > News, Views and Match Reports.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -- 
> Failure is not an option
> 
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
