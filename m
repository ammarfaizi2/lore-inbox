Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130484AbQKCTrL>; Fri, 3 Nov 2000 14:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130719AbQKCTrB>; Fri, 3 Nov 2000 14:47:01 -0500
Received: from web5204.mail.yahoo.com ([216.115.106.85]:28941 "HELO
	web5204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130484AbQKCTqq>; Fri, 3 Nov 2000 14:46:46 -0500
Message-ID: <20001103194639.24058.qmail@web5204.mail.yahoo.com>
Date: Fri, 3 Nov 2000 11:46:39 -0800 (PST)
From: Rob Landley <telomerase@yahoo.com>
Subject: Re: 255.255.255.255 won't broadcast to multiple NICs
To: Paul Flinders <P.Flinders@ftel.co.uk>
Cc: Philippe Troin <phil@fifi.org>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Paul Flinders <P.Flinders@ftel.co.uk> wrote:
> 
> Rob Landley <telomerase@yahoo.com> writes:
> > 3) Java sucks in many ways.  Today's way is that
...
> > There is no way to query the current machine's
> > interfaces without resorting to
> > native code.
> 
> I faced this problem a while ago - in the end I
> cheated and put this bit of code in a shell script
> used to start the application

I've considered it.  Counts as "native code", but
thanks for the script anyway. :)

For my current app, I've pretty much decided that for
the boxes where broadcasting 255.255.255.255, they
have to supply it on the command line.  Maybe I'll
have the script supply it on the command line for them
since I'll probably offer an RPM or linux-specific tar
as an install option.  I need to potentially install
the JRE for them (assuming licensing issues work out
ok there, which I'm 99% certain is fine but want to
double check), and should have a shell script to
encapsulate the "jre -cp myjar.jar runthisclass" part
anyway into "runclient" or "runserver".  (Possibly
starting from the init scripts, or with a nice Gnome
icon.  Depends how industrious I feel when I'm done,
and/or what my boss wants. :)

The larger question of "should the Linux kernel's IP
stack behavior be fixed, documented, or left alone" is
what I'm interested in now.  If people agree that
255.255.255.255 should go out to multiple interfaces,
I'd be willing to try my hand at a patch to route.c
(be afraid, be very afraid), but I'm still waiting to
hear from on high (higher than me anyway) about
whether or not the current behavior is something
they're happy with.  (My app will NOT require a custom
kernel to function properly, that's not an option. :)

> including ${NET_ADDRESSES} in the java command line
> sets
> up a set of defines, one per interface. For example
> 
> -Dethaddr.172.16.1.1=00:00:0A:BC:CD:78
> -Dnetmask.172.16.1.1=255.255.0.0
> 
> which you can use via System.getProperty() and
> System.getProperties()

If I go with a script I'll just have it spit the IP
broadcast addresses one after the other to stdout, and
then call it from the command line with back quotes as
some variant of:

./myprog broadcast `./findbroadcasts`

Encased in the platform-specific launch shell script,
of course. :)

Why on earth would my app need the ethernet address? 
If the stack didn't abstract that away, there would be
a much bigger problem than global broadcasts not
really being global...

Rob

__________________________________________________
Do You Yahoo!?
>From homework help to love advice, Yahoo! Experts has your answer.
http://experts.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
