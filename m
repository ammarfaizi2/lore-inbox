Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131289AbRC3KVj>; Fri, 30 Mar 2001 05:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131275AbRC3KVa>; Fri, 30 Mar 2001 05:21:30 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:51461 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131273AbRC3KVV>;
	Fri, 30 Mar 2001 05:21:21 -0500
Date: Fri, 30 Mar 2001 12:20:28 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: kernel apm code
To: John Fremlin <chief@bandits.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   linux-laptop@vger.kernel.org, apm@linuxcare.com.au,
   apenwarr@worldvisions.ca, sfr@linuxcare.com.au
Message-id: <3AC45DEC.4ABCC94B@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.7 [en] (WinNT; U)
Content-type: text/plain; charset=iso-8859-2
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3AC0A679.DFA9F74B@uni-mb.si> <"m28zlr58w9.fsf"@boreas.yi.org>
 <3AC1C406.652D0207@uni-mb.si> <"m2bsqmlyrh.fsf"@boreas.yi.org>
 <3AC2FF70.CA2317B6@uni-mb.si> <"m24rwcjziu.fsf"@boreas.yi.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> 
>  David Balazic <david.balazic@uni-mb.si> writes:
> 
> > John Fremlin wrote:
> 
> [...]
> 
> > > > To implement off-button you only need the APM_IOC_REJECT ioctl and
> > >
> > > The problem on my computer with my (re)implementation of
> > > APM_IOC_REJECT is that the screen goes into powersaving when the user
> > > suspend is received, then turns it back on when APM_IOC_REJECT is sent
> > > by apmd.
> >
> > What is wrong with that ?
> 
> > Suspend is requested -> suspend is executed
> 
> > Suspend is canceled (rejected) -> suspend is canceled
> >
> > Seems perfectly OK to me.
> 
> The sequence is in fact: suspend requested by BIOS -> suspend accepted
> by kernel -> SUSPEND -> suspend rejected by apmd which is passed on by
> kernel to BIOS -> REJECT=RESUME (if I understand correctly, this is
> what seems to happen).
> 
> Sequence should be as in pmpolicy patch: suspend requested by BIOS ->
> /sbin/powermanger decides to reject -> REJECT

AFAICT , the kernel does not accept(*) any APM_EVENT until all userspace
"listeners" say it is OK. So until apmd doesn't reply, the kernel does
not accept the SUSPEND. If apmd says OK, kernel says OK to BIOS and SUSPEND
is activated, but if apmd says NO-NO, then the kernel rejects the SUSPEND
request and "nothing happens"

This is of course with a proper implementation of REJECT functionality
in the kernel apm driver. I don't know if it behaves like this in the
current IOC_AOM_REJECT version, but  it should :-)

* - by accept I mean : it receives a notification from BIOS and replies
OK to the BIOS. the BIOS doesn't change the powerstate until the kernel
responds with OK , IIRC

> 
> [...]
> 
> > > Anyway it is fixed in my pmpolicy patch, and I don't need no
> > > daemon so the code is a lot cleaner and simpler (no binary magic
> > > number interfaces).
> >
> > But there should be no policy in the kernel ! ;-)
> 
> Read the patch. Read the webpage:
> 
>         http://john.snoop.dk/programs/linux/offbutton
> 
> There is no policy in kernel.
> 
> --
> 
>         http://www.penguinpowered.com/~vii


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
