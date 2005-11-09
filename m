Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030496AbVKIBv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496AbVKIBv4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbVKIBvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:51:55 -0500
Received: from smtpout.mac.com ([17.250.248.45]:51699 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1030379AbVKIBvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:51:54 -0500
In-Reply-To: <20051109004808.GM19593@austin.ibm.com>
References: <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com> <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com> <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain> <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com> <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local> <20051109004808.GM19593@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com>
Cc: Douglas McNaught <doug@mcnaught.org>, Steven Rostedt <rostedt@goodmis.org>,
       linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: typedefs and structs
Date: Tue, 8 Nov 2005 20:51:25 -0500
To: linas <linas@austin.ibm.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 8, 2005, at 19:48:08, linas wrote:
> On Tue, Nov 08, 2005 at 07:37:20PM -0500, Douglas McNaught was  
> heard to remark:
>> Yeah, but if you're trying to read that code, you have to go look  
>> up the declaration to figure out whether it might affect 'foo' or  
>> not. And if you get it wrong, you get silent data corruption.
>
> No, that is not what "pass by reference" means. You are thinking of  
> "const", maybe, or "pass by value"; this is neither.  The arg is  
> not declared const, the subroutine can (and usually will) modify  
> the contents of the structure, and so the caller will be holding a  
> modified structure when the callee returns (just like it would if a  
> pointer was passed).

Pass by value in C:
do_some_stuff(arg1, arg2);

Pass by reference in C:
do_some_stuff(&arg1, &arg2);

This is very obvious what it does.  The compiler does type-checks to  
make sure you don't get it wrong.  There are tools to check stack  
usage of functions too.  This is inherently obvious what the code  
does without looking at a completely different file where the  
function is defined.


Pass by value in C++:
do_some_stuff(arg1, arg2);

Pass by reference in C++:
do_some_stuff(arg1, arg2);

This is C++ being clever and hiding stuff from the programmer, which  
is Not Good(TM) for a kernel.  C++ may be an excellent language for  
userspace programmers (I say "may" here because some disagree,  
including myself), however, many of the features are extremely  
problematic for a kernel.


Cheers,
Kyle Moffett

--
Debugging is twice as hard as writing the code in the first place.   
Therefore, if you write the code as cleverly as possible, you are, by  
definition, not smart enough to debug it.
   -- Brian Kernighan


