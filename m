Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132176AbRCVUQr>; Thu, 22 Mar 2001 15:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132178AbRCVUQh>; Thu, 22 Mar 2001 15:16:37 -0500
Received: from ftc-0337.dialup.frii.com ([216.17.134.133]:34039 "EHLO
	linuxtaj.korpivaara.org") by vger.kernel.org with ESMTP
	id <S132176AbRCVUQX>; Thu, 22 Mar 2001 15:16:23 -0500
Date: Thu, 22 Mar 2001 13:17:42 -0700 (MST)
From: Trent Jarvi <trentjarvi@yahoo.com>
To: Geir Thomassen <geirt@powertech.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Serial port latency
In-Reply-To: <3ABA5A9A.7B85B5B9@powertech.no>
Message-ID: <Pine.LNX.4.20.0103221310500.3343-100000@linuxtaj.korpivaara.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Mar 2001, Geir Thomassen wrote:

> Trent Jarvi wrote:
> > 
> > Hi,
> > 
> > I'm not on the kernel list.  I just ran across your email while looking at the
> > weekly archive.
> > 
> > I think you want to enable software flow control.
> > 
> >         tcgetattr( fd, &ttyset );
> >         ttyset.c_iflag |= IXOFF;
> >         tcsetattr( fd, TCSANOW, &ttyset );
> > 
> 
> Just tested it, it didn't change anything. The response from the controller
> can contain ^S/^Q, so it would be a bad idea anyway ....
> 
> > Someone reported that the Java CommAPI driver at http://www.rxtx.org got
> > 150-200ms latency with (9600,N,8,1,XON/XOFF).  Beyond that you may have to
> > look at something like the realtime support.  I guess 2 ms is normal on
> > win98.
> 
> Win98 is the problem I am trying to solve with my program ...
> 
> > Since you have the scope hooked up you may look at hardware flow control too.
> > 
> >         tcgetattr( fd, &ttyset );
> >         ttyset.c_cflag |= HARDWARE_FLOW_CONTROL;
> >         tcsetattr( fd, TCSANOW, &ttyset );
> 
> Do you mean CRTSCTS ? HARDWARE_FLOW_CONTROL is not defined in my header files.
> I use CLOCAL, which should make the driver ignore modem control lines.
> 

Ya.. My bad.  I use that to support multiple platforms

#ifdef CRTSCTS
#define HARDWARE_FLOW_CONTROL CRTSCTS
#else

Do you happen to have shared interupts enabled in the kernel?

> > Let me know if you find anything out.  I'm the maintainer of rxtx and would
> > be interested in documenting this for others.
> 
> sure ...
> 
> > --
> > Trent Jarvi
> > TrentJarvi@yahoo.com
> 
> Thanks anyway
> 
> Geir
> 

-- 
Trent Jarvi
TrentJarvi@yahoo.com

