Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <971341-31949>; Wed, 3 Jun 1998 10:35:35 -0400
Received: from out1.ibm.net ([165.87.194.252]:3953 "EHLO out1.ibm.net" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <971351-31949>; Wed, 3 Jun 1998 10:31:49 -0400
Message-Id: <m0yhFkt-000OwsC@maestro.thrillseeker.net>
X-Mailer: exmh version 2.0.2 2/24/98 (debian) 
To: Jauder Ho <jauderho@carumba.com>
Cc: linux-kernel@vger.rutgers.edu
Subject: Re: Forwarded mail.... 
From: Billy Harvey <Billy.Harvey@thrillseeker.net>
In-Reply-To: Your message of "Wed, 03 Jun 1998 02:30:11 PDT." <Pine.LNX.3.96.980603022914.30744A-100000@marvin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Jun 1998 10:47:10 -0500
Sender: owner-linux-kernel@vger.rutgers.edu

Jauder,

What works well for me is to put the following in my procmail:

M=.Mail
L=$LOCKEXT
R=/usr/lib/mh/rcvstore

T=Trash
# :0 c:$M/$T/$L 
# | $R +$T

# Check for duplicate messages and send them to the Trash
:0 Whc: .msgid.lock
| formail -D 65536 .msgid.cache
T=Trash
:0 a:$M/$T/$L
| $R +$T

# Trash stuff sent directly to linux lists instead of via vger
T=Trash
:0 :$M/$T/$L
* ^Sender: owner-linux-.*@vger\.rutgers\.edu
# * ! ^(((To|Cc):)|( )).*linux-.*@vger\.rutgers\.edu
* ! ^(((To|Cc):)|( )).*linux
| $R +$T

# Trash subscribe/unsubscribe messages
T=Trash
:0 :$M/$T/$L
* ^Subject: .*subscr
| $R +$T

# Trash non-delivery messages
T=Trash
:0 :$M/$T/$L
* ^Subject:.*non-delivery*
| $R +$T


This moves suspicious stuff into a 'Trash' folder, which I can then examine at 
my leisure.  It's fairly easy to scan all the subjects and delete the contents 
of the folder in about 3 seconds, or read a specific email that was mistakenly 
filed.

This works fairly well on the linux lists since spammers usually leave the To: 
header blank.


Regards,

Billy Harvey

> 	
> 	I think someone is trolling the listserver again. This sucks. I
> can't even filter for this. 
> 
> --jauder



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
