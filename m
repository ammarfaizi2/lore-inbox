Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316684AbSFJGlw>; Mon, 10 Jun 2002 02:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316686AbSFJGlw>; Mon, 10 Jun 2002 02:41:52 -0400
Received: from khms.westfalen.de ([62.153.201.243]:10421 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S316684AbSFJGlu>; Mon, 10 Jun 2002 02:41:50 -0400
Date: 10 Jun 2002 08:39:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8QbH9n0Xw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>
Subject: Re: [PATCH] Futex Asynchronous Interface
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 09.06.02 in <Pine.LNX.4.44.0206091056550.13459-100000@home.transmeta.com>:

> On 9 Jun 2002, Kai Henningsen wrote:
> >
> > However, I don't think that's all that important. What I'd rather see is
> > making the network devices into namespace nodes. The situation of eth0 and
> > friends, from a Unix perspective, is utterly unnatural.
>
> But what would you _do_ with them? What would be the advantage as compared
> to the current situation?

For one, enumerate them. Network interfaces, as opposed to sockets, are  
fairly static. And currently I have to either call /sbin/ifconfig or  
figure out where this information is hidden in /proc. (And there is a  
kernel interface, I think, some ioctl() stuff - I have mostly forgotten  
all I learned about that, it was so ugly.)

Doesn't need to be /dev/xxx nodes (that *would* be the traditional Unix  
way) - these days I'd argue for a special network device fs.

> Now, to configure a device, you get a fd to the device the same way you
> get a fd _anyway_ - with "socket()".

>From what little I remember, though, you don't bind your socket to some  
address "eth0" - which might have been halfway reasonable - but instead  
you say *that* with some ioctl().

> And anybody who says that "socket()" is utterly unnatural to the UNIX way
> is quite far out to lunch. It may be unnatural to the Plan-9 way of
> "everything is a namespace", but that was never the UNIX way. The UNIX way
> is "everything is a file descriptor or a process", but that was never
> about namespaces.
>
> Yes, some old-timers could argue that original UNIX didn't have sockets,
> and that the BSD interface is ugly and an abomination and that it _should_
> have been a namespace thing, but that argument falls flat on its face when
> you realize that the "pipe()" system call _was_ in original UNIX, and has
> all the same issues.

On the other hand, pipe() is about *anonymous* files. You could in fact  
argue that it would be nice to have an interface for anonymous disk files  
as well, instead of all the current acrobatics for safe temp file  
creation.

> Don't get hung up about names.

Especially not if your argument is then about situations where you atually  
don't want a name.

See, the problem with eth0 and friends is that they already *have* names -  
their names just aren't in the standard namespace. *That* is the real  
problem here.

Unix tradition or not, I propose the rule:

*Any kernel object that has a text name, shall appear,*
*under this name, somewhere in the filesystem.*

Or in other words, *there can only be one namespace*. (Well, only one  
global namespace, anyway.)

MfG Kai
