Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265931AbTFSTVz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 15:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbTFSTVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 15:21:39 -0400
Received: from tag.witbe.net ([81.88.96.48]:48136 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S265922AbTFSTVK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 15:21:10 -0400
From: "Paul Rolland" <rol@as2917.net>
To: "'Robert Schweikert'" <Robert.Schweikert@abaqus.com>,
       <linux-kernel@vger.kernel.org>
Cc: "'Robert Schweikert'" <rjschwei@abaqus.com>
Subject: Re: process stack question
Date: Thu, 19 Jun 2003 21:35:09 +0200
Message-ID: <004f01c33699$e51e4bd0$4100a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1056050322.24403.116.camel@cheetah.hks.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Have a look at this :

5.43 Getting the Return or Frame Address of a Function 
These functions may be used to get information about the callers of a function. 


Built-in Function: void * __builtin_return_address (unsigned int level) 
This function returns the return address of the current function, or of one of its callers. The level argument is number of frames
to scan up the call stack. A value of 0 yields the return address of the current function, a value of 1 yields the return address of
the caller of the current function, and so forth. 

The level argument must be a constant integer. 

On some machines it may be impossible to determine the return address of any function other than the current one; in such cases, or
when the top of the stack has been reached, this function will return 0 or a random value. In addition, __builtin_frame_address may
be used to determine if the top of the stack has been reached. 

This function should only be used with a nonzero argument for debugging purposes. 



Built-in Function: void * __builtin_frame_address (unsigned int level) 
This function is similar to __builtin_return_address, but it returns the address of the function frame rather than the return
address of the function. Calling __builtin_frame_address with a value of 0 yields the frame address of the current function, a value
of 1 yields the frame address of the caller of the current function, and so forth. 

The frame is the area on the stack which holds local variables and saved registers. The frame address is normally the address of the
first word pushed on to the stack by the function. However, the exact definition depends upon the processor and the calling
convention. If the processor has a dedicated frame pointer register, and the function has a frame, then __builtin_frame_address will
return the value of the frame pointer register. 

On some machines it may be impossible to determine the frame address of any function other than the current one; in such cases, or
when the top of the stack has been reached, this function will return 0 if the first frame pointer is properly initialized by the
startup code. 

This function should only be used with a nonzero argument for debugging purposes

Regards,
Paul


Paul Rolland, rol@witbe.net
Witbe.net SA
Directeur Associe

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it"

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Robert Schweikert
> Sent: Thursday, June 19, 2003 9:19 PM
> To: linux-kernel@vger.kernel.org
> Cc: Robert Schweikert
> Subject: process stack question
> 
> 
> I have been searching for some documentation on how to get at 
> information regarding the process stack but I didn't find 
> much and from what I found it was not clear to me how I could 
> use the information.
> 
> Here is what I am after.
> 
> We have some rudimentary memory tracking tools in our 
> application and I'd like to put some debug output in that 
> allows me to write the name of the routine I am in to some debug log.
> 
> My thinking is that I should be able to get a hold of the 
> process call stack and using the top of the stack I should 
> have the name of the function/method I am in. 
> 
> Any help on how to go about this would be appreciated. A 
> pointer to any documentation on how to get a hold of the 
> stack, or the public API for this is of course welcome.
> 
> Thanks,
> Robert
> -- 
> Robert Schweikert <Robert.Schweikert@abaqus.com>
> ABAQUS
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

