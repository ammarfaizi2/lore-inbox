Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUFLE5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUFLE5T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 00:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264641AbUFLE5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 00:57:19 -0400
Received: from lakermmtao06.cox.net ([68.230.240.33]:11233 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S264640AbUFLE5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 00:57:17 -0400
In-Reply-To: <40CA74D0.5070207@myrealbox.com>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com> <40CA74D0.5070207@myrealbox.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FA11463F-BC2C-11D8-888F-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel Authentication Tokens (PAGs)
Date: Sat, 12 Jun 2004 00:57:16 -0400
To: Andy Lutomirski <luto@myrealbox.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 11, 2004, at 23:13, Andy Lutomirski wrote:
> I like the idea of having some kernel support for tokens.
>
> But why PAGs?  I imagine tokens as being independent objects without
> any hierarchy.  A token group is a set of tokens.  The operations on 
> tokens
> are:
>
> [...snip...]
>
> If you really need a hierarchy, then you could allow token groups to 
> contain
> other token groups, with the rule that the whole thing must be acyclic.

I think my vocabulary here is confusing, what you refer to as a token 
group, I refer to as a PAG.  The idea for the hierarchy is that it is 
frequently desirable to start a sub-shell with a temporarily different 
set of tokens, or to mask out only a certain token without modifying 
the rest.  For example, let's say that I login at my school, which gets 
Kerberos tokens and AFS tickets.  Now I want to perform some Kerberos 
administration activities, so I run "pagsh" or something to create a 
new shell with a new PAG, one with a parent of the original PAG.  When 
I do filesystem access the search process finds the old AFS tokens, but 
the kmoffett/admin@MY.HOST Kerberos TGT token hides the old 
kmoffett@MY.HOST Kerberos TGT, without replacing it.  That means that 
all the old shells operate normally, nothing has changed for them, but 
the new shell has the extra layer with the new Kerberos tickets, so I 
can administrate Kerberos without changing my AFS tokens to admin ones.

Cheers,
Kyle Moffett

