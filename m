Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287645AbSAPVRd>; Wed, 16 Jan 2002 16:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287627AbSAPVQH>; Wed, 16 Jan 2002 16:16:07 -0500
Received: from amdext.amd.com ([139.95.251.1]:37031 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id <S287629AbSAPVPe>;
	Wed, 16 Jan 2002 16:15:34 -0500
X-Server-Uuid: 02753650-11b0-11d5-bbc5-00508bf987eb
Message-ID: <3C45ED5C.A384BBB@cmdmail.amd.com>
Date: Wed, 16 Jan 2002 13:15:08 -0800
From: "Amit Gupta" <amit.gupta@amd.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12-generic-mpd i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Dana Lacoste" <dana.lacoste@peregrine.com>
cc: "'Luigi Genoni'" <kernel@Expansa.sns.it>,
        "Amit Gupta" <amit.gupta@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: arpd not working in 2.4.17 or 2.5.1
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2AA3@ottonexc1.ottawa.loran.com>
X-WSS-ID: 105B32EF475947-01-01
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw: I get some warning messages when I compile arpd 1.0.4 on 2.4.*
kernel. just wondering if this might also contribute to the problem.

root@lx-master:~/arpd-1.0.4# make
gcc -O6 -pipe -fomit-frame-pointer -Wall -DARPD_VERSION=\"1.0.4\"
arpd.c   -o arpd
arpd.c: In function `arpd_walk_procfs':
arpd.c:272: warning: long unsigned int format, unsigned int arg (arg 4)
root@lx-master:~/arpd-1.0.4# ls -la arpd
-rwxr-xr-x   1 root     root        16636 Jan 16 13:10 arpd*

for
arpd.c: line 266-274
void arpd_walk_procfs(struct arpd_request * request, void * foo)
{
        struct in_addr inaddr;

 inaddr.s_addr = request->ip;
 fprintf(stderr, "Tbl: %s (%08lx)\n",
  inet_ntoa(inaddr), ntohl(request->ip));
 return;
}

Dana Lacoste wrote:

> Right now it's fully working with 2.4.9, i'll put
> 2.4.17 on there and see what it does :)
>
> > -----Original Message-----
> > From: Luigi Genoni [mailto:kernel@Expansa.sns.it]
> > Sent: January 16, 2002 06:50
> > To: Dana Lacoste
> > Cc: Amit Gupta; linux-kernel@vger.kernel.org
> > Subject: RE: arpd not working in 2.4.17 or 2.5.1
> >
> >
> > How are you managing /dev/arpd?
> > It seems that the kernel is not behaving correctly with this device
> >
> >
> > On Tue, 15 Jan 2002, Dana Lacoste wrote:
> >
> > > I have a 2.4 compatible arpd running, but with our
> > > company being bought by a big US software company
> > > I'm having trouble convincing management to allow
> > > the GPL release.  It's becoming very important so
> > > I'm hopeful that I'll be successful shortly, but
> > > until then I have to be quiet :)
> > >
> > > --
> > > Dana Lacoste      - Linux Developer
> > > Peregrine Systems - Ottawa, Canada
> > >
> > > (Note that Peregrine acquired Loran, and jlayes@loran.com
> > > is an email address of a former employee, so i'm kind of
> > > the relevant person to talk to for arpd stuff, because that
> > > other address won't work :)
> > >
> > > > -----Original Message-----
> > > > From: Luigi Genoni [mailto:kernel@Expansa.sns.it]
> > > > Sent: January 15, 2002 10:03
> > > > To: Amit Gupta
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Subject: Re: arpd not working in 2.4.17 or 2.5.1
> > > >
> > > >
> > > > Latest  kernel I saw working with arpd (user space daemon) I
> > > > am manteining
> > > > is 2.2.16, then from 2.4.4 (for 2.4 series), some changes
> > were done to
> > > > kernel so that the kernel does not talk correctly with the device
> > > > /dev/arpd anymore.
> > > > It is not the first time I write about this on lkml, but it
> > > > seems none is
> > > > interested in manteining the kernel space component for
> > arpd support.
> > > > I did some investigation, but the code for arpd support
> > > > itself inside of
> > > > the kernel seems to be ok, something else is wrong with
> > neighour.c.
> > > >
> > > > So at less I can say the user space daemon works well on
> > 2.2.16 I have
> > > > around ;).
> > > >
> > > > Luigi
> > > >
> > > > On Mon, 14 Jan 2002, Amit Gupta wrote:
> > > >
> > > > >
> > > > > Hi All,
> > > > >
> > > > > I am running 2.5.1 kernel on a 2 AMD processor system and
> > > > have enable
> > > > > routing messages, netlink and arpd support inside kernel as
> > > > described in
> > > > > arpd docs.
> > > > >
> > > > > Then after making 36 character devices, when I run arpd,
> > > > it's starts up
> > > > > but always keeps silent (strace) and the kernel also does
> > > > not keep it's
> > > > > 256 arp address limit.
> > > > >
> > > > > Pls help fix it, I need linux to be able to talk to
> > more than 1024
> > > > > clients.
> > > > >
> > > > > Thanks in Advance.
> > > > >
> > > > > Amit
> > > > > amit.gupta@amd.com
> > > > >
> > > > >
> > > > >
> > > > > -
> > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > linux-kernel" in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > >
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
> > > linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >


