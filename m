Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUIHNiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUIHNiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 09:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267615AbUIHNeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 09:34:04 -0400
Received: from open.hands.com ([195.224.53.39]:32937 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267701AbUIHNc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 09:32:56 -0400
Date: Wed, 8 Sep 2004 14:43:56 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
Message-ID: <20040908134356.GC1017@lkcl.net>
References: <20040908100946.GA9795@lkcl.net> <1094638489.2800.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094638489.2800.7.camel@laptop.fenrus.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 12:14:50PM +0200, Arjan van de Ven wrote:
> On Wed, 2004-09-08 at 12:09, Luke Kenneth Casson Leighton wrote:
> > dear kernel people,
> > 
> > this is a first pass at attempting to add per-program firewall rule
> > checking to iptables.
> 
> question: any reason you didn't use something like selinux-like contexts
> instead of dentry/device pairs ? 

a very good question: stephen smalley described an approach in which
exactly what you suggest can be done.

please bear with me whilst i explain, then i will answer.

the issue is that FireFlier is an on-demand (user-driven) popup firewall
program [and there literally ISN'T any firewall program available for
linux that even remotely comes close to the same capabilities as
fireflier]

so rules are queued (ipt_queue) and the popup thrown at the user until
they select "yes, no, create-a-firewall-rule".

to parallel the same functionality i would need to place a hook in
selinux to catch an audit operation (hooks are already there), then
alert the user to it, then create a rule, recompile the policy, and
_then_ let the hook proceed.

i'm not sure if this would work!!!

so, i didn't want to use selinux contexts because  it involves
dynamically creating selinux policy rules.

fireflier is NOT a "create-it-once-then-apply-it-suck-it-and-see"
firewall program.

it's an on-demand "popup" firewall program where the default is
"block by virtue of the packet being in the ip_queue, awaiting
 user approval or disapproval".


unless... *shudder* ... you mean ... why didn't i consider getting
FireFlier to _create_ selinux contexts, blatting them into the policy
directly? (which i know is possible, there do exist binary policy
editing-and-writing tools).

well... if this approach turns out to be a total nightmare, then
your question is really appreciated because it makes me think of
other possibilities.

l.


-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

