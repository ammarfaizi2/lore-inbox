Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUFLPhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUFLPhg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 11:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUFLPhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 11:37:36 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:24287 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264857AbUFLPhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 11:37:33 -0400
Message-ID: <40CB233C.6050505@myrealbox.com>
Date: Sat, 12 Jun 2004 08:37:32 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: In-kernel Authentication Tokens (PAGs)
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <40CA74D0.5070207@myrealbox.com> <FA11463F-BC2C-11D8-888F-000393ACC76E@mac.com> <40CA95ED.8060902@myrealbox.com> <3131BE9C-BC6F-11D8-888F-000393ACC76E@mac.com>
In-Reply-To: <3131BE9C-BC6F-11D8-888F-000393ACC76E@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On Jun 12, 2004, at 01:34, Andy Lutomirski wrote:
> 
>> Right.  But I think it would be desirable to do other things -- for 
>> example, a program might want to forward one token over to a daemon to 
>> do some work.  It doesn't make much sense here to have a hierarchial 
>> structure.
> 
> 
> So you disagree with the hierarchical structure because you believe that 
> there are other things that are more important that conflict with it.  I 
> see no reason why both cannot be accommodated.  For me, I would really 
> desire a hierarchical structure because it would make it very simple to 
> have a token set for the entire session and one for each instance 
> (shell), and ones for subshells where convenient.

OK.

> 
> You want to sent a token to some daemon over a UNIX socket?  Just copy 
> the token data and write it out to the socket, the same as if you had 
> some external token store (Like in MIT Kerberos) and wanted to send the 
> token to somewhere without the environment variables.  This system would 
> allow several existing token cache mechanisms to be converted to this 
> alternative store without much work at all.

Except I'd like non-root users to have tokens that they _cannot_ read, but 
that they can still pass over unix sockets.  I have no objection to also 
allowing user-readable tokens.

This way I could have a server with, say, a Kerberos service token such 
that a compromise of the server process does not compromise the service 
token.  (You still have a gotcha in that the kerberosd this would require 
would, for performance reasons, want to handle only ticket-granting 
traffic.  Still, you just mark the TGT unreadable and the individual 
session tickets readable, so that the damage of a compromise is limited to 
a few hours until the sessions expire.)

Yes, this would be a _lot_ more work than just blindly porting Kerberos' 
ticket cache, but it has security benefits.

And I really want a good token system in Linux -- that way the OpenAFS 
people will stop bitching and I might be able to use it again.

--Andy
