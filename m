Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWCXVkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWCXVkb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 16:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbWCXVkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 16:40:31 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:19164 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750798AbWCXVka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 16:40:30 -0500
Date: Fri, 24 Mar 2006 22:40:29 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
       Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       OpenVZ developers list <dev@openvz.org>,
       "Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] [PATCH 0/7] Some basic vserver infrastructure
Message-ID: <20060324214029.GD22308@MAIL.13thfloor.at>
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	Kirill Korotaev <dev@sw.ru>, Dave Hansen <haveblue@us.ibm.com>,
	Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
	OpenVZ developers list <dev@openvz.org>,
	"Serge E.Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>
References: <20060321061333.27638.63963.stgit@localhost.localdomain> <1142967011.10906.185.camel@localhost.localdomain> <m1k6anq8uq.fsf@ebiederm.dsl.xmission.com> <44241224.9000200@sw.ru> <m13bh7io3i.fsf@ebiederm.dsl.xmission.com> <20060324210150.GA22308@MAIL.13thfloor.at> <m1u09nh7gb.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u09nh7gb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 02:13:40PM -0700, Eric W. Biederman wrote:
> Herbert Poetzl <herbert@13thfloor.at> writes:
> 
> > hmm, isn't per process a little extreme ... I know
> > what you want to accomplish but won't this lead to
> > a per process procfs? 
> 
> Where all of the values vary per process possibly, that
> is they way /proc is supposed to be.
> 
> /proc/sys is the only case that I think really gets extreme. For
> things like /proc/sysvipc and /proc/net it really is a natural break,
> and /proc/mounts already shows that the technique works fine.

well, while /proc/mounts is a good example that it 'works'
it isn't a good example for proper design, as the entire
private namespaces lead to much obfuscation, and having
the mounts per process, where they actually should be per
namespace, and to hide the fact that there are different
namespaces does not help either ...

IMHO a much better design would be to have the namespace
'explicit' and link to that one, containig the mounts entry
btw, this is something which should still be possible
without breaking anything ...

> So I am trying to turn an ugly design choice into feature :)

hmm, no, you are trying to multipy an ugly design :)

> > and, if you want to do per
> > process procfs, what would be the gain?
> >
> > just my opinion ...
> 
> Under the covers the implementation is per namespace, but
> it isn't easy to export it that way from procfs.

why?

/proc/self -> YYY/
/proc/mounts -> self/mounts

(so far nothing new)

/proc/YYY/namespace -> ../namespace-XXX/
/proc/YYY/mounts -> namespace/mounts 

(or alternatively)

/proc/namespace -> namespace-XXX/
/proc/mounts -> namespace/mounts

> In any event this appears to be a way to implement these things while
> retaining backwards compatibility, with the current implementation,
> and it looks like it can be implemented fairly cleanly.

I don't see any differences regarding compatibility when
things like namespaces get explicit ...

best,
Herbert

> Eric
