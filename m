Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <970999-2834>; Tue, 16 Jun 1998 10:18:35 -0400
Received: from cr154328-a.ktchnr1.on.wave.home.com ([24.112.104.63]:1302 "HELO bifrost.voskamp.waterloo.on.ca" ident: "root") by vger.rutgers.edu with SMTP id <970981-2834>; Tue, 16 Jun 1998 10:18:19 -0400
Message-Id: <m0ylwhc-0003XwC@bifrost.voskamp.waterloo.on.ca>
From: jeff@bifrost.voskamp.waterloo.on.ca (Jeff Voskamp)
Subject: Re: binfmt_script
To: agriffis@css.tayloru.edu (Aron Griffis)
Date: Tue, 16 Jun 1998 10:27:12 -0400 (EDT)
Cc: linux-kernel@vger.rutgers.edu
In-Reply-To: <19980616092717.A16431@css.tayloru.edu> from "Aron Griffis" at Jun 16, 98 09:27:17 am
WWW-homepage: http://www.voskamp.waterloo.on.ca/~jeff
Content-Type: text
Sender: owner-linux-kernel@vger.rutgers.edu

>There appears to be a restriction on scripts that allows only a single
>parameter to the interpreter in the #! line.  For example:
>
>    #!/bin/csh -fb	<-- fine
>    #!/bin/csh -f -b	<-- not allowed
>
>Is there a reason for this restriction?
>
>-Aron

Given a file 

Foo
---
#!<interpreter> <options>

the kernel changes the command line

Foo <args>

to

<interpreter <options> Foo <args>

Once you know that all should be clear.

Hint: the -f option in csh takes the next "word" as the name of the file
to run.  The first verstion gives "csh -fb blah args" while the second
gives "csh -f -b blah args" and csh tries to run the script "-b".

As far as I know all unices (?) do it this way.

Jeff Voskamp

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
