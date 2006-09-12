Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWILMQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWILMQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 08:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWILMQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 08:16:40 -0400
Received: from tresys.irides.com ([216.250.243.126]:776 "HELO
	exchange.columbia.tresys.com") by vger.kernel.org with SMTP
	id S932284AbWILMQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 08:16:38 -0400
Message-ID: <4506A522.90005@gentoo.org>
Date: Tue, 12 Sep 2006 08:16:34 -0400
From: Joshua Brindle <method@gentoo.org>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: David Madore <david.madore@ens.fr>
CC: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: capabilities patch: trying a more "consensual" approach
References: <20060911212826.GA9606@clipper.ens.fr>
In-Reply-To: <20060911212826.GA9606@clipper.ens.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: avast! (VPS 0637-0, 09/11/2006), Outbound message
X-Antivirus-Status: Clean
X-OriginalArrivalTime: 12 Sep 2006 12:16:38.0231 (UTC) FILETIME=[4C089670:01C6D665]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Madore wrote:
> Hello again,
>
> Given the rather cold reception that my "capabilities" patch has met,
> it is obvious that it will never be accepted in any official kernel,
> so I am now abandoning it and will try to suggest a different approach
> that, in my opinion, isn't nearly as useful or expressive, but which
> should probably be much more acceptable to those who found fault with
> my previous patch, since it follows various suggestions which I
> received on the list.
>
> First, attempt to implement POSIX draft semantics for inheritance as
> closely as the current situation will allow.  (I think this is wrong,
> but many people seem to care, and POSIX semantics is still better than
> no semantics at all.)  Actual filesystem support can come later (Serge
> Hallyn has a patch for that), but in the meantime it would be useful
> to add some (per-filesystem) mount options to specify the default
> "inheritable" and "effective" capability sets.  In the absence of this
> mount option, the behavior would be entirely unchanged, so everyone
> should be happy.  With the mount options, capabilities will be
> somewhat inheritable (only "somewhat", though, because with the POSIX
> semantics, even with a default set, you can't force a non-caps-aware
> process to gain caps in such a way that it will pass it on to its
> children).
>
> Second, suppress the idea of "regular" capabilities, and implement
> them with Linux Security Module hooks (the module could be called,
> say, "cuppabilities").  This won't do as much, but we can probably
> still get a few things done that way.  Unfortunately, the
> cuppabilities won't (can't) follow the same inheritance rules as
> capabilities, and this might be a bit confusing.  But better than
> nothing.
>
> Is there some objection to this scheme?  I should start coding it in a
> couple of weeks.
>   
Do you have a practical use case for this? It still doesn't address the 
questionable capabilities or the fact that the policy is embedded in the 
processes all over the system and therefore there is no analyzable 
system policy.

