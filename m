Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWDRU6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWDRU6A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWDRU57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:57:59 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:907 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1750837AbWDRU57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:57:59 -0400
Message-ID: <444552A7.2020606@novell.com>
Date: Tue, 18 Apr 2006 13:57:11 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>	 <44453E7B.1090009@novell.com> <1145391969.21723.41.camel@localhost.localdomain>
In-Reply-To: <1145391969.21723.41.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
>   
>> implements an approximation to the AppArmor security model, but does it
>> with domains and types instead of path names, imposing a substantial
>> cost in ease-of-use on the user.
>>     
> I don't think thats true. A file name is a pretty meaningless object in
> Unixspace let alone Linux after Al Plan9ified it somewhat.
Not quite; data contents and file names have *different* meanings.
Mediating the contents of the shadow file is good for preserving the
secrecy of the file. Mediating the contents of the thing named
/etc/hosts.allow has impact with respect to what answers to that name,
regardless of what happened to the previous contents.

SELinux has NSA legacy, and that is reflected in their inode design: it
is much better at protecting secrecy, which is the NSA's historic
mission. AppArmor has legacy in intrusion prevention, and so its primary
design goal was to prevent compromised programs from compromising the
host. Name-based access control is better at that, because it lets you
directly control which programs can change the contents of path names
that have critical semantic meaning in UNIX/Linux, such as /etc/shadow,
/etc/hosts.allow, /srv/www/htdocs/index.html and so forth.

>  It has an
> impact on policy design but if anything it makes it slightly harder for
> the policy design work and _easier_ for users, who no longer have to
> follow magic path rules.
>   
Try out AppArmor and see if you still believe that :)

> Can you answer the "when are you submitting it upstream" question ?
It is a small number of hours away. We are polishing our submission now.

>  I've
> certainly not got any fundamental objection to another security system.
> I doubt we'd all use it but we don't all use sys5 file systems or
> reiserfs either.
>   
I very much appreciate that. AppArmor is fundamentally different than
SELinux, in goals and in the resulting design, and we believe it is
important for users to be able to choose the system they want, both in
file systems and security systems.

Note: I'm assuming that LSM will not be removed while we are in the
process of being reviewed. I seem to recall it took SELinux six months
to go from initial submission to acceptance and I'm sure we will have to
fix issues and we don't have illusions that AppArmor will be accepted in
a matter of weeks.

We had actually planned to submit AppArmor next week, and this thread
has accelerated the submission by a few days.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

