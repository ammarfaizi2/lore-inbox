Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262544AbVGFVB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262544AbVGFVB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 17:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVGFU6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:58:34 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:17159 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S262528AbVGFUxf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 16:53:35 -0400
Message-ID: <42CC44D9.8000306@slaphack.com>
Date: Wed, 06 Jul 2005 15:53:45 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Briggs <jbriggs@esoft.com>
Cc: Hubert Chan <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>	 <87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com>	 <1120675943.13341.10.camel@localhost>  <87mzozemqp.fsf@evinrude.uhoreg.ca> <1120681998.13341.23.camel@localhost>
In-Reply-To: <1120681998.13341.23.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Briggs wrote:
> On Wed, 2005-07-06 at 15:51 -0400, Hubert Chan wrote:
> 
>>On Wed, 06 Jul 2005 12:52:23 -0600, Jonathan Briggs <jbriggs@esoft.com> said:
> 
> [snip]
> 
>>>It still has the performance and locking problem of having to update
>>>every child file when moving a directory tree to a new parent.  On the
>>>other hand, maybe the benefit is worth the cost.
>>
>>Every node should store the inode number(s) for its parent(s).  Not the
>>path name.  So you don't need to do any updates, since when you move a
>>tree, inode numbers don't change.
> 
> 
> You do need the updates if you change what inode is the parent.
> 
> /a/b/c, /a/b/d, /a/b/e, /b
> mv /a/b /b
> Now you have to change the stored grand-parent inodes for /a/b/c, /a/b/d
> and /a/b/e so that they reference /b/b instead of /a/b.

no, c, d, and e all would reference /a/b's *inode*, not *pathname*. 
Then /a/b would reference /a.  So with the above mv, you just change the 
reference in /a/b (now /b/b) to point to /b as parent.

Only way you would have to touch c, d, and e is if you did:

mkdir /b/b
mv /a/b/* /b/b/

but, since you're also essentially unlinking them from /a/b and linking 
them into /b, it's not that much more of a performance hit to update one 
pointer in the file.

