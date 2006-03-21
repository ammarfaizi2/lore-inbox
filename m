Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWCUVI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWCUVI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWCUVI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:08:56 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:24195 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S965124AbWCUVIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:08:55 -0500
Message-ID: <44206B58.5000404@vilain.net>
Date: Wed, 22 Mar 2006 09:08:40 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
References: <20060321061333.27638.63963.stgit@localhost.localdomain> <1142967011.10906.185.camel@localhost.localdomain>
In-Reply-To: <1142967011.10906.185.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>That said, at this point, I'd just about rather have _anything_ merged
>than the nothing we have at this point.  As we throw patches back and
>forth, we can't seem to agree on even some very small points.  
>
>I also have a sinking feeling that everybody has gone back off and
>continues to develop their own out-of-tree functionality, deepening the
>patch divide.
>
>Is there anything we could merge that we _all_ don't like?  I'm pretty
>convinced that no single solution will support Eric's, OpenVZ's, and
>VServer's _existing_ usage models.  Somebody is going to have to bend,
>or nothing will ever get merged.  Any volunteers? ;)
>  
>

I don't think they're all that different conceptually.  If something as
simple as this was merged then we'd at least have a common structure to
throw things in, and a common syscall infrastructure that can gracefully
handle kernel API versioning without requiring dozens of syscalls.

>What about going back to the very simple "struct container" on which to
>build?
>  
>

Please read "vx_info" as "container" (or your preferred term).  I
decided to punt on the naming issue and copy Herbert :-).

And also because the acronym "vx" makes the API look nice, at least to
mine and Herbert's eyes, then when you go to the network virtualisation
you get "nx_info", etc.  However I'm thinking any of these terms might
also be right:

  - "vserver" spelt in full
  - family
  - container
  - jail
  - task_ns (sort for namespace)

Perhaps we can get a ruling from core team on this one, as it's
aesthetics :-).

>	http://lkml.org/lkml/2006/2/3/205
>  
>

This patch is simple, but does not handle SMP scalability very well
(you'll get a lot of cacheline problems when you start actually using
the container structure; the hashing helps a lot there), and does not
provide functions such as looking up a container by ID etc.  I think
Herbert's context.c is a pretty nice basic set of functions for dealing
with container-like things.

Thanks for your feedback!
Sam.
