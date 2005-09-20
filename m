Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbVITWIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbVITWIY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbVITWIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:08:24 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:11484 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750863AbVITWIX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:08:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MkMQy/BXD7lhPG2nCh0nrRURsWb2mdTF1Ap76E+MSZgTg/PeCeel8IwEzLlCDL3AR5mgR2nFdqcI1rm8Qdu4rnwbzNmxYc/ZQxVX1dDbSk8u6lmFYYwlJhc6SB2TJK9LeF5k4JNDvqcpt9E8jTq9y2MXfTfHwamW9lK150Zd5ws=
Message-ID: <feed8cdd050920150866e7925d@mail.gmail.com>
Date: Tue, 20 Sep 2005 15:08:21 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: stephen.pollei@gmail.com
To: Hans Reiser <reiser@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Nikita Danilov <nikita@clusterfs.com>,
       Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <43304A41.7080206@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509201536.j8KFa6wn011651@laptop11.inf.utfsm.cl>
	 <43304A41.7080206@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/05, Hans Reiser <reiser@namesys.com> wrote:
> Horst von Brand wrote:
> >Nikita Danilov <nikita@clusterfs.com> wrote:
> >It is supposed to go into the kernel, which is not exactly warning-free.

> Is that what this thread boils down to, that you guys think the compile
> should fail not warn?

I don't care if it fails or warns at compile time, but you shouldn't
misuse/abuse a warning by potentialily introducing an unrelated bug.

So if you had
#if defined(DEBUG_THIS) || defined(DEBUG_THAT) 
int znode_is_loaded(const struct znode *z);
#else
int znode_is_loaded(const struct znode *z)
  __attribute__((__warn_broken__("unavailible when not debuging")));
#endif
That would be great with me.. except __warn_broken__ or the like
doesn't exist AFAIK :-<
Closest thing is __attribute((__deprecated__)) but thats not quite right.

> >As was said before: It it is /really/ wrong, arrange for it not to compile
> >or not to link. If it isn't, well... then it wasn't that wrong anyway.

That is really true, if it is really wrong then make it so that trying
to do it simply breaks.
And if you are impatient then use a define to substitute crap into the
compile that will give you something you can't ignore as well. Make it
throw off sparks, get bonus points if you can make gcc segfault;->

#define znode_is_loaded(I_dont_care_you_are_going_to_) \
  } )die(]0now[>anyway<}}}}}}*bye*}

should stop a compile, but I don't think it's evil enough to cause gcc
to segfault.
If you didn't like my humor I'm sure you could code something more
concise that is as sick and twisted to crash a compile...
Hmmm. 
#if yadda yadda
int znode_is_loaded_yet_again(....)
#else
#define znode_is_loaded(z) ><<<>
/* break the compile if someone tries using it while not debuging */
#endif

That should break the parser as well. too bad there isn't a
_Pragma("error") or something... oh well.

Also note my opinion, doesn't really count if you grep the kernel
sources for pollei, you won't find anything.

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
