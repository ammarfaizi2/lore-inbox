Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267341AbUIJJuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267341AbUIJJuF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUIJJuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:50:04 -0400
Received: from open.hands.com ([195.224.53.39]:25574 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S267341AbUIJJpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:45:46 -0400
Date: Fri, 10 Sep 2004 10:57:00 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] to add device+inode check to ipt_owner.c - HACKED UP
Message-ID: <20040910095700.GB14060@lkcl.net>
References: <20040908100946.GA9795@lkcl.net> <20040908103922.GD9795@lkcl.net> <1094802568.8495.49.camel@sherbert>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094802568.8495.49.camel@sherbert>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 08:49:28AM +0100, Gianni Tedesco wrote:
> On Wed, 2004-09-08 at 11:39 +0100, Luke Kenneth Casson Leighton wrote:
> > ... did i sent a patch?
> > 
> > did i send a patch??  i don't _think_ so *lol* :)
> 
> heh :)
> 
> IMO the number of constraints involed here make using this patch fairly
> involved (for something security related at least) in that, as you said,
> you have to:
> 
>  - be careful to use ACCEPT rules only
>  - be careful that you do:
>     1. remove fw rules
>     2. upgrade software
>     3. replace rules
 
 i've since replaced the code with use of d_path() which stephen
 smalley kindly pointed out, negating the need for doing a
 commit-replace-thing.

> plus the fastpath code looks very hairy with at least 3 locks taken and
> O(num_tasks * max_fds) unpreemptable in softirq...

 *shrug*.  that's the way ipt_owner works...

> There has to be a simpler approach, perhaps passing in a path, looking
> up the dentry in current namespace and setting an unused flag in
> d_vfs_flags? That way you could just match on skb->sk->sk_socket->file-
> >f_dentry.
 
  ooo...

> I don't know enough about VFS to know if that's really possible. I mean
> would you need vfsmnt too to make it accurate across namespaces? 


 well you need vfsmnt in order to trackdown the full path name.

 l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

