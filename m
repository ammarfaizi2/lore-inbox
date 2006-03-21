Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWCUVe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWCUVe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWCUVeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:34:25 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:33255 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932459AbWCUVeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:34:25 -0500
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Vilain <sam@vilain.net>
Cc: linux-kernel@vger.kernel.org, Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W.Biederman" <ebiederm@xmission.com>,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <44206B58.5000404@vilain.net>
References: <20060321061333.27638.63963.stgit@localhost.localdomain>
	 <1142967011.10906.185.camel@localhost.localdomain>
	 <44206B58.5000404@vilain.net>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:32:36 -0800
Message-Id: <1142976756.10906.200.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 09:08 +1200, Sam Vilain wrote:
> Dave Hansen wrote:
> >What about going back to the very simple "struct container" on which to
> >build?
> 
> Please read "vx_info" as "container" (or your preferred term).  I
> decided to punt on the naming issue and copy Herbert :-).

My point was that we go back to something simple which we can all
understand and build on.  The code which was just posted is quite
complex.  Although I trust that most of it is needed, the justification
for the complexity simply is not there.

By starting painfully simply, we can build on complexity in bits, and
justify it as we go.

> And also because the acronym "vx" makes the API look nice, at least to
> mine and Herbert's eyes, then when you go to the network virtualisation
> you get "nx_info", etc.  However I'm thinking any of these terms might
> also be right:
> 
>   - "vserver" spelt in full
>   - family
>   - container
>   - jail
>   - task_ns (sort for namespace)
> 
> Perhaps we can get a ruling from core team on this one, as it's
> aesthetics :-).

I was in a meeting with a few coworkers, and we were arguing a bit about
naming.  One person there was a manager-type who didn't have any direct
involvement in the project.  We asked him which naming was more clear.

We need to think a bit like that.  What is more clear to somebody who
has never read the code?  (Hint "vx_" means nothing. :)

> >	http://lkml.org/lkml/2006/2/3/205
> >  
> This patch is simple, but does not handle SMP scalability very well
> (you'll get a lot of cacheline problems when you start actually using
> the container structure; the hashing helps a lot there)

Could you elaborate a bit on this one?  What has cacheline problems?

> and does not provide functions such as looking up a container by ID etc.

We need something so simple that we probably don't even deal with ids.
I believe that Eric claims that we don't really need container _ids_.
For instance, the filesystem namespaces have no ids, and work just fine.

-- Dave

