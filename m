Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268611AbRHPBWF>; Wed, 15 Aug 2001 21:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268614AbRHPBVz>; Wed, 15 Aug 2001 21:21:55 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:64507
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S268611AbRHPBVq>; Wed, 15 Aug 2001 21:21:46 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.8 Resource leaks + limits
Date: Wed, 15 Aug 2001 20:12:48 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, mag@fbab.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <E15Wz1n-00033Y-00@the-village.bc.nu> <Pine.LNX.4.33.0108150952001.2220-100000@penguin.transmeta.com> <20010815215723.F9870@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010815215723.F9870@nightmaster.csn.tu-chemnitz.de>
MIME-Version: 1.0
Message-Id: <01081520213500.04125@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Aug 2001, Ingo Oeser wrote:
>On Wed, Aug 15, 2001 at 09:53:09AM -0700, Linus Torvalds wrote:
>> > For that to work we need to seperate struct user from the uid a little, or
>> > provide heirarchical pools (which seems overcomplex). Its common to want
>> > to take a group of users (eg the chemists) and give them a shared limit
>> > rather than per user limits
>> 
>> No, I think the answer there is to do all the same things for "struct
>> group" as we do for user.
> 
>Not really. Large installations use ACLs instead of groups. 
>
>Why? Because if we have 2^31 users, there might be a slight
>chance, that we need more then 32 group memberships per user.
>
>So let's better stop relying more and more on this group brain
>damage and start supporting ACLs. We can support building ACL
>groups, but please let the user and not the admin build them.
>
>It's called user data, because the user owns it and should
>decide, which people are allowed to access it. 
>
>Please look at AFS groups, to see what I mean.
>
>All serious admins I know miss the ACL feature in Linux. One
>product even emulates them via groups.

ACLs are good and very usefull.

HOWEVER, there are cases of users giving away their files to users
that are not authorized to recieve that data.

The advantage of groups is that the facility managment defines the
list of users authorized to view the data. It up to the user to
grant/deny that group access authorization.

Alternatively, it is possible to view the system as you describe - the
user can add others to the ACL to grant access. There should still be
some method that facility management can deny access.... On many systems
(Trusted Solaris, UNICOS, Trix,...) this is done with compartmentalization.
Now, it is subsets of the members of the compartment that the user can
grant access to.

Still more flexible than generic groups, but more restricted than no
limits on members of the ACL.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
