Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVGHQpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVGHQpG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVGHQpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:45:06 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:3340 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262709AbVGHQpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:45:04 -0400
Message-ID: <42CEADA8.4060303@slaphack.com>
Date: Fri, 08 Jul 2005 11:45:28 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
Cc: Hans Reiser <reiser@namesys.com>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>	<87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com>	<1120675943.13341.10.camel@localhost> <42CCCEEA.7040302@namesys.com> <87oe9duu9o.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87oe9duu9o.fsf@evinrude.uhoreg.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:
> On Wed, 06 Jul 2005 23:42:50 -0700, Hans Reiser <reiser@namesys.com> said:
> 
> 
>>Oh no, don't store the whole path, store just the parent list.  This
>>will make fsck more robust in the event that the directory gets
>>clobbered by hardware error.
> 
> 
>>I don't think it affects the cost of detecting cycles though, I think
>>it only makes fsck more robust.
> 
> 
> It doesn't affect the worst-case cost of detecting cycles; by necessity,
> any (static [1]) directed cycle detection algorithm must take O(n) time,
> n being the size of the tree (nodes + links).  However, under
> "reasonable assumptions" (where the reasonableness of those assumptions
> may be questioned, but I think they're reasonable), I think that doing a
> depth-first-search through the parent links makes the algorithm
> not-too-terrible.  Namely, the "reasonable assumptions" are that a node
> doesn't have "too many" parents, and the filesystem hierarchy is not
> "too deep".

And, remember, there are other things affected by depth of the tree 
anyway.  For that matter, most of the time, when you push a system past 
"reasonable assumptions", you hit performance issues, if not stability 
ones.  Most everything but Reiser assumes that you won't have "too many" 
files in a directory, or "too many" small files in the FS as a whole.

I think it's fair to assume people will keep things "reasonable", 
especially if we tell them what "reasonable" means.  As in, "This is the 
kind of organization which Reiser4 handles really well, and this is the 
kind of organization which will absolutely kill your performance."

