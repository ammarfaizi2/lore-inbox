Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318035AbSGWMo0>; Tue, 23 Jul 2002 08:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318049AbSGWMo0>; Tue, 23 Jul 2002 08:44:26 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:30866 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318035AbSGWMoY>; Tue, 23 Jul 2002 08:44:24 -0400
Message-ID: <3D3D4F18.2030803@quark.didntduck.org>
Date: Tue, 23 Jul 2002 08:42:00 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: type safe(r) list_entry repacement: generic_out_cast
References: <15677.15834.295020.89244@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

remove-irqlock-2.5.27-F3Neil Brown wrote:
> list.h has this nifty macro called list_entry that takes a pointer to a "struct
> list_head" and "casts" that to a pointer to some structure that
> contains the "struct list_head".
> 
> However it doesn't do any type checking on the pointer, and you can 
> give it a pointer to something else... just as I did in line 850 of
> md/md.c :-(
> 
> So I thought I would add some type checking to list_entry so that
> you have to pass it a "struct list_head *", but I then discovered that
> lots of places are using list_entry to do creative casting on
> all sorts of other things like inodes embedded in bigger structures
> and so on.
> 
> So... I have created "generic_out_cast" which is like the old
> list_entry but with an extra type arguement.  I have then
> changed uses of list_entry that did not actually apply to lists to use
> generic_out_cast, often indirectly.
> 
> Why "out_cast"???
> 
> Well OO people would probably call it a "down cast" as you are
> effectively casting from a more-general type to a less-general (more
> specific) type that is there-fore lower on the type latice.
> So maybe it should be "generic_down_cast".
> But seeing that one is casting from an embeded internal structure to a
> containing external structure, "out_cast" seemed a little easier to
> intuitively understand.
> 
> If anyone wants to suggest better names of any of the names I have
> chosen, feel free to submit suggestions or patches.

How about member_to_struct() or unembed()?

--
				Brian Gerst

