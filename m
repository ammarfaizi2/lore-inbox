Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283699AbRK3QTH>; Fri, 30 Nov 2001 11:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283697AbRK3QS6>; Fri, 30 Nov 2001 11:18:58 -0500
Received: from mailsorter.in.tmpw.net ([63.121.29.25]:58402 "EHLO
	mailsorter.in.tmpw.net") by vger.kernel.org with ESMTP
	id <S283696AbRK3QSo>; Fri, 30 Nov 2001 11:18:44 -0500
Message-ID: <3AB544CBBBE7BF428DA7DBEA1B85C79C0110199B@nocmail.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Jessica Blank'" <jessica@twu.net>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Slow start -- Linux vs. NT -- it's time to acknowledge the pr
	oblem!
Date: Fri, 30 Nov 2001 11:12:38 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well that may help with your situation, but having the Windows-type person
remove Windows may help more...  ;o)

Seriously though, I would look at what Alan suggested, as if you are really
flooding your network, you'd see problems on the other machines as well.  I
would think, a duplex/network issue over what your seeing.  Does your Net
admin see any errors on your switch if your using one?

B.

-----Original Message-----
From: Jessica Blank [mailto:jessica@twu.net]
Sent: Friday, November 30, 2001 11:03 AM
To: Richard B. Johnson
Cc: linux-kernel@vger.kernel.org
Subject: Re: Slow start -- Linux vs. NT -- it's time to acknowledge the
problem!


Sooo... having the Windows-type person remove NetBEUI and Windows
filesharing (SMB) would fix this if this is indeed the cause of problems?

On Fri, 30 Nov 2001, Richard B. Johnson wrote:

> On Fri, 30 Nov 2001, Jessica Blank wrote:
>
> > Hello esteemed kernel hackers:
> >
> > 	As you doubtless know, NT and BSD both have a broken slow-start
> > implementation. As you may not know, when you try having a Linux box
> > co-exist on a network with a Windows box, this seems to cause the
Windows
> > box to CROWD OUT the Linux box on the network.
> >
> > 	There is a fix to Solaris for this-- or a "workaround", I should
> > say:
> >
> > http://www.sun.com/sun-on-net/performance/tcp.slowstart.html
> >
>
> > 	THERE IS NO FIX TO LINUX FOR THIS. At least, not as far as I could
> > find-- and I just got done Web-searching for a solid 15 minutes, finding
> > MULTIPLE references to the Solaris workaround in the process.
>
> I seriouly doubt that your problem has anything to do with Linux, but
> rather that the NT machines are set up to use Netbeui which puts
> NETBIOS packets into broadcast packets. This means that all the data
> to/from the M$ file-servers ends up being handled by your Ethernet board
> and driver, then dumped onto the floor.
>
> A properly implimented IP Network minimizes the amount of broadcast
> traffic. M$ tends to maximize it. Such a typical mess looks like
> this:
>
> # tcpdump -n
> 10:47:03.349550 10.110.128.209.138 > 10.111.255.255.138: udp 215
> 10:47:03.349607 10.110.1.173.138 > 10.111.255.255.138: udp 216
> 10:47:03.350618 10.110.129.85.138 > 10.111.255.255.138: udp 221
> 10:47:03.351338 10.110.129.95.138 > 10.111.255.255.138: udp 213
> 10:47:03.352340 10.110.1.152.138 > 10.111.255.255.138: udp 211
> 10:47:03.352973 10.110.130.143.138 > 10.111.255.255.138: udp 212
> 10:47:03.356839 10.110.130.53.138 > 10.111.255.255.138: udp 215
> 10:47:03.359190 10.110.129.11.138 > 10.111.255.255.138: udp 217
> 10:47:03.360571 10.110.129.47.138 > 10.111.255.255.138: udp 208
> 10:47:03.361669 10.110.128.96.138 > 10.111.255.255.138: udp 215
> 10:47:03.361938 10.110.129.51.138 > 10.111.255.255.138: udp 214
> 10:47:03.363611 10.110.129.182.138 > 10.111.255.255.138: udp 213
> ^C
> #
>
> Here, data is being sent from a server 10.110.129.182, port 138
> to a broadcast address, 10.111.255.255, port 138. Port 138 is
> NETBIOS Datagram. So, all this data gets sent to every machine
> on the LAN. It generates an interrupt, the driver gets the data
> and passes it on. The IP stack looks at it and says "It ain't for
> me...", and throws it away. This all takes CPU cycles that
> Microsoft is stealing from you. The solution is to fire your
> M$ administrator. Failing that, you need to get the fastest
> Ethernet card, with a good fast driver. This allows the M$ data
> to be thrown away without using too much of your CPU time.
>
> IP filtering in your machine doesn't do any good. It just adds
> CPU cycles. The broadcast packets aren't for your machine anyway
> so they are being rejected without any additional filter.
>
> Cheers,
> Dick Johnson
>
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
>
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
>
>


=========================================
  J e s s i c a    L e a h    B l a n k
-----------------------------------------
  Programmer * Unix Sysadmin * Web Geek
   jessica@jessl.org -- cell@jessl.org
 -`-,-{@  http://www.jessl.org/  @}-,-`-
=========================================


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
