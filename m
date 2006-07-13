Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWGMRBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWGMRBK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 13:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWGMRBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 13:01:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:46749 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030248AbWGMRBI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 13:01:08 -0400
Message-ID: <44B67C4B.7050009@fr.ibm.com>
Date: Thu, 13 Jul 2006 19:00:59 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Andrey Savochkin <saw@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
References: <20060711075051.382004000@localhost.localdomain>	<20060711075420.937831000@localhost.localdomain>	<44B3D435.8090706@sw.ru> <m1k66jebut.fsf@ebiederm.dsl.xmission.com>	<44B4D970.90007@sw.ru> <m164i2ae3m.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m164i2ae3m.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>> I'm fine with such situations, since we need containers mostly, but what makes
>> me really afraid is that it introduces hard to find/fix/maintain issues. I have no
>> any other concerns.
> 
> Hard to find and maintain problems I agree should be avoided.  There are only two
> ways I can see coping with the weird interactions that might occur.
>
> 1) Assert weird interactions will never happen, don't worry about it,
>    and stomp on any place where they can occur.  (A fully isolated container approach).
> 
> 2) Assume weird interactions happen and write the code so that it simply
>    works if those interactions happen, because for each namespace you have
>    made certain the code works regardless of which namespace the objects are
>    in.
> 
> The second case is slightly harder.  But as far as I can tell it is more robust
> and allows for much better incremental development.

hmm, slightly, I would say much harder and these weird interactions are
very hard to anticipate without some experience in the field. We could
continue on arguing for ages without making any progress.

let's apply that incremental development approach now. Let's work on simple
namespaces which would make _some_ container scenarios possible and not
all. IMHO, that would mean tying some namespaces together and find a way to
unshare them safely as a whole. Get some experience on it and then work on
unsharing some more independently for the benefit of more use case
scenarios. I like the concept and I think it will be useful.

just being pragmatic, i like things to start working in simple cases before
over optimizing them.

cheers,

C.

