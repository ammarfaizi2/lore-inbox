Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbVJCEoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbVJCEoE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVJCEoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:44:04 -0400
Received: from smtpout.mac.com ([17.250.248.89]:11456 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932149AbVJCEoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:44:01 -0400
In-Reply-To: <5543.1127327394@warthog.cambridge.redhat.com>
References: <20050921101558.7ad7e7d7.akpm@osdl.org> <5378.1127211442@warthog.cambridge.redhat.com> <12434.1127314090@warthog.cambridge.redhat.com> <5543.1127327394@warthog.cambridge.redhat.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C3E4D28A-385C-4E08-822C-EC577D330EB8@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Keyrings] Re: [PATCH] Keys: Add possessor permissions to keys
Date: Mon, 3 Oct 2005 00:43:18 -0400
To: David Howells <dhowells@redhat.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 21, 2005, at 14:29:54, David Howells wrote:
> (3) Key handles (which I've been asked for before).
>
> This involves detaching the permissions and suchlike from the key  
> into a "handle" which can then be cloned. A temporary handle could  
> then be used to hold the possession attribute and the other  
> permissions at the time of the access.
>
> The downside of this is that it's quite a big change. It also makes  
> joining session keyrings way more "interesting". It does have some  
> nice features though.

Are there any plans to implement this functionality in the near  
future?  It would complement the existing security model nicely by  
allowing a process to clone its key handle either explicitly (with  a  
keyctl call) or implicitly (by passing it over a file handle to  
another process), and then later revoke the cloned handle and all  
handles cloned from it with a single call, much as one can SIGKILL an  
entire process group with a single kill().  It seems that a key  
handle would be little more than a special sort of file handle  
attached to a key.  I'm curious what issues you've found with joining  
session keyrings.  I haven't thought about that part specifically,  
but it seems that perhaps there should be a set of "default"  
permissions and attributes that are associated with a new lookup-by- 
key-id handle.


Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


