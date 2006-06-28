Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWF1LGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWF1LGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 07:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbWF1LGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 07:06:08 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:3339 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S932236AbWF1LGH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 07:06:07 -0400
Message-ID: <20060628150605.A29274@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 15:06:05 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: dlezcano@fr.ibm.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       Andrew Morton <akpm@osdl.org>, dev@sw.ru, herbert@13thfloor.at,
       devel@openvz.org, sam@vilain.net, viro@ftp.linux.org.uk,
       Alexey Kuznetsov <alexey@sw.ru>
Subject: Re: Network namespaces a path to mergable code.
References: <20060626134945.A28942@castle.nmd.msu.ru> <m14py6ldlj.fsf@ebiederm.dsl.xmission.com> <20060627215859.A20679@castle.nmd.msu.ru> <m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <m1ejx9kj1r.fsf@ebiederm.dsl.xmission.com>; from "Eric W. Biederman" on Tue, Jun 27, 2006 at 10:20:32PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Jun 27, 2006 at 10:20:32PM -0600, Eric W. Biederman wrote:
> Andrey Savochkin <saw@swsoft.com> writes:
[snip]
> > My first patchset covers devices but not sockets.
> > The only difference from what you're suggesting is ipv4 routing.
> > For me, it is not less important than devices and sockets.  May be even
> > more important, since routing exposes design deficiencies less obvious at
> > socket level.
> 
> I agree we need to do it.  I mostly want a base that allows us to 
> not need to convert the whole network stack at once and still be able
> to merge code all the way to the stable kernel.
> 
> The routing code is important for understanding design choices.  It
> isn't important for merging if that makes sense.   

Ok, fine.
Now I'm working on socket code.

We still have a question about implicit vs explicit function parameters.
This question becomes more important for sockets: if we want to allow to use
sockets belonging to namespaces other than the current one, we need to do
something about it.

One possible option to resolve this question is to show 2 relatively short
patches just introducing namespaces for sockets in 2 ways: with explicit
function parameters and using implicit current context.
Then people can compare them and vote.
Do you think it's worth the effort?

> 
> For everyone looking at routing choices the IPv6 routing table is
> interesting because it does not use a hash table, and seems quite
> possibly to be an equally fast structure that scales better.
> 
> There is something to think about there.

Sure

[snip]
> >
> > Can you summarize you objections against my way of handling devices, please?
> > And what was the typo you referred to in your letter to Kirill Korotaev?
> 
> I have no fundamental objects to the content I have seen so far.
> 
> Please read the first email Kirill responded too.  I quoted a couple
> of sections of code and described the bugs I saw with the patch.

I found your comments, thank you!

> 
> All minor things.  The typo I was referring to was a section where the
> original iteration was on an ifp variable and you called it dev
> without changing the rest of the code in that section.  
> 
> The only big issue was that the patch too big, and should be split
> into a patchset for better review.  One patch for the new functions,
> and the an additional patch for each driver/subsystem hunk describing
> why that chunk needed to be changed.

I'll split the patch.

> I'm still curious why many of those chunks can't use existing helper
> functions, to be cleaned up.

What helper functions are you referring to?

Best regards

Andrey
