Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277954AbRJRSlL>; Thu, 18 Oct 2001 14:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277957AbRJRSlC>; Thu, 18 Oct 2001 14:41:02 -0400
Received: from web20901.mail.yahoo.com ([216.136.226.223]:36747 "HELO
	web20901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277954AbRJRSkv>; Thu, 18 Oct 2001 14:40:51 -0400
Message-ID: <20011018184124.57237.qmail@web20901.mail.yahoo.com>
Date: Thu, 18 Oct 2001 11:41:24 -0700 (PDT)
From: Ravi Chamarti <ravi_chamarti@yahoo.com>
Subject: Re: Ref: zerocopy +netfilter performance problem.
To: kuznet@ms2.inr.ac.ru, Ravi Chamarti <ravi_chamarti@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200110171818.WAA22378@ms2.inr.ac.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your response Alexey. I appreciate it. 

--- kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > My question is that is this copy is required for
> > netfilter to work? Do we somehow get around
> > with netfilter to work such that the zerocopy path
> > passes the packet without any copy?
> 
> Yes & yes.
> 
> Existing netfilter modules do not understand
> fragmented skbs,
> and as soon as netfilter folks are lazy even to move
> the check
> to relevant modules, even smart hooks has to be
> harmed by this.

How many netfilter modules exist which do not
understand fragmented skbs and need to look at the
skb data? 

Will the following approach work? 

if the somehow hook register shows interest only in
header (by setting a flag, may be in nf_hooks_ops 
struct), then we can avoid the copy of the fragmented
skb's data and all other cases, we copy fragmented
skb's data to a kernel buffer. The side effect is that
a flag field is introduced into nf_hook_ops struct
which makes netfilter modules to recompile. Are there
any other side affects or better approaches?


regards
Ravi Chamarti


__________________________________________________
Do You Yahoo!?
Make a great connection at Yahoo! Personals.
http://personals.yahoo.com
