Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276305AbRJYUu4>; Thu, 25 Oct 2001 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276318AbRJYUuq>; Thu, 25 Oct 2001 16:50:46 -0400
Received: from fe2.rdc-kc.rr.com ([24.94.163.49]:37641 "EHLO mail2.kscable.com")
	by vger.kernel.org with ESMTP id <S276305AbRJYUuf>;
	Thu, 25 Oct 2001 16:50:35 -0400
Date: Thu, 25 Oct 2001 15:51:00 -0500 (CDT)
From: Nate Dannenberg <natedac@kscable.com>
X-X-Sender: <natedac@daconcepts.dyndns.org>
To: <volodya@mindspring.com>
cc: <livid-gatos@linuxvideo.org>, <video4linux-list@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [livid-gatos] [RFC] alternative kernel multimedia API
In-Reply-To: <Pine.LNX.4.20.0110251258510.8566-200000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33.0110251534240.31044-100000@daconcepts.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2001 volodya@mindspring.com wrote:

>
>  After looking at and working with Xv, v4l and v4l2 I became somewhat
> dissatisfied with the current state of affairs. I have attached a
> description of the API that would make (at least) me much happier.
>
>  I would very much appreciate comments from interested people..

I'm not a coder for Linux or X, but I figured this would be a good read
anyway, as it might provide some ideas for a similar (albeit less complex)
issue on another platform I use >:-)

Anyways since this is an RFC, here's the only a couple of comments I can
think of (the RFC otherwise looks clear to me):


Commands/queries should also include some kind of (arbitrary, decided by the
calling program) command serial number, so that an out-of-sequence reply
(those prepended with a colon as you describe) can be matched to a previous
command/query.  This could allow several commands to be sent and handled by
multiple processes/threads/whatever.

 05,HUE=7\n
 07,some unrelated command
+05\n				# The HUE command was successful
:07,reply to unrelated command
:05,HUE=6\n			# Driver reported the HUE parameter as
				# different from that most recently set.

The program wanted to set HUE to 7, command successful, value later returned
was 6 (maybe the device only allows even values), while at the same time some
other command was sent and processed.

Also, it might be a nice idea to return the range of one or more parameters if
a command given is out of range.  Suppose HUE is only valid for values 0-255:

 06,HUE=300\n
-06,HUE=INVALID,0,255\n

..Would tell the calling program that a value given for HUE is only valid for
a range of 0 to 255.  This would be useful for a program that wants to attempt
to guess the range a device accepts for a given parameter.

-- 
 _________________________ ___ ___
|  natedac@kscable.com    //ZZ]__ |
|      C64/C128/SCPU     |'/  |Z/ |
| What's *YOUR* Hobby!?  | \__|_\ |
|_________________________\___]___|


