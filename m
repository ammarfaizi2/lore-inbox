Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135790AbRAWGiS>; Tue, 23 Jan 2001 01:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136239AbRAWGiM>; Tue, 23 Jan 2001 01:38:12 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:50483 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S135790AbRAWGiA>; Tue, 23 Jan 2001 01:38:00 -0500
Message-Id: <4.3.2.7.2.20010122222130.00b1b780@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 22 Jan 2001 22:37:48 -0800
To: Anton Altaparmakov <aia21@cam.ac.uk>,
        Mark I Manning IV <mark4@purplecoder.com>
From: Stephen Satchell <satch@fluent-access.com>
Subject: Re: [OT?] Coding Style
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.0.2.1.2.20010122233742.00ae5e40@pop.cus.cam.ac.uk>
In-Reply-To: <3A6C630E.C2CB784C@purplecoder.com>
 <4.3.2.7.2.20010122130852.00b92a80@mail.fluent-access.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:56 PM 1/22/01 +0000, Anton Altaparmakov wrote:
>At 16:42 22/01/2001, Mark I Manning IV wrote:
>>Stephen Satchell wrote:
>> >                                              I got in the habit of using
>> >  structures to minimize the number of symbols I exposed. It also
>> > disambiguates local variables and parameters from file- and program-global
>> > variables.
>>
>>explain this one to me, i think it might be usefull...
>
>What might be meant is that instead of declaring variables my_module_var1, 
>my_module_var2, my_module_var3, etc. you declare a struct my_module { 
>var1; var2; var3; etc. }. Obviously in glorious technicolour formatting... (-;
>That's my interpretation anyway...

The first sentence is right on the money.  In addition to module variables, 
I define a global structure as:

      extern struct G {
          /* the real globals */
          } g;

and then in the main program I define the instance as "struct G g;"  This 
is more for apps than operating systems.

Further to the avoidance of pollution of the external global namespace, I 
define local functions as static.  Indeed, in one parser I had over 1400 
very small functions, none of them with external scope.  Instead, I defined 
a structure of function pointers and exposed one name to the rest of the 
world.  Sound stupid?  Well, that stupidity had its place:  the "opcode" in 
the pseudo-instruction stream was the offset into this structure of 
pointers to the pointer of interest, which made the main loop for the 
parser about five lines long, and not a switch statement to be seen.  Three 
of those lines were to handle unknown-opcodes...

I also am partial to arrays of function pointers when appropriate.  Ever 
think how easy it would be to implement a TCP stack that would handle the 
"lamp-test packet" as a single special case?  Granted, it results in a 
small amount of code bloat over the traditional in-line test method, but it 
does make you think about EVERY SINGLE ONE OF THE 64 COMBINATIONS of 
Urg/Ack/Psh/Rst/Syn/Fin (to use the labels from the 1985 version of RFC 
793) and what they really mean.  Especially the combination with all bits set.

Satch

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
