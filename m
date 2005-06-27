Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVF0VWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVF0VWQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVF0VVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:21:36 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:17168 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261843AbVF0VT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:19:26 -0400
Message-ID: <42C06D59.2090200@slaphack.com>
Date: Mon, 27 Jun 2005 16:19:21 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050325)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu> <42BF667C.50606@slaphack.com> <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com> <42BF7167.80201@slaphack.com> <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
In-Reply-To: <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kyle Moffett wrote:
> On Jun 26, 2005, at 23:24:23, David Masover wrote:
> 
>>> Neither do I want the kernel to unzip it, because that just  
>>> introduces the
>>> kernel to a whole series of normally application-level  vulnerabilities.
>>
>>
>> That just means the zip plugin has to be more carefully written than I
>> thought.  It would have to be sandboxed and limited to prevent buffer
>> overruns and zip bombs.
> 
> 
> 
> 
>> Remember that zip, at least, would not be in the kernel.  I think what
>> is going in the kernel is gzip and lzo, and it's being done so
>> transparently that you never actually see the compressed version.
> 
> 
> 
>>> Can you illustrate for me with precise, clear, and unambiguous 
>>> arguments
>>
>>
>> That will take some time.  And some thinking.
> 
> 
> Precisely.  Come back when you have a good sturdy set of arguments.  See
> the FUSE project (Also discussed in this thread), for better ideas on  how
> to add strange filesystem semantics.

If I didn't care about performance.  I will read up on how FUSE works,
though, to see if there's anything in the _kernel_ code that would be
useful.

> NOTE:  Even the FUSE project,  which
> is in _userspace_ (as opposed to the massive kernelspace mess of  reiser4),
> is taking a lot of flak for changing UNIX semantics, so I see no reason
> why Reiser4 should be special.

Right.  Kernel people hate change.  Got it.

No, seriously, I have to respect the history involved, which is why I'm
not pretending to know more than I do.

> Ok, good.  That's one of the first issues.  A _lot_ of applications 
> would get
> themselves thoroughly confused at that '...' interface, not to  mention
> a lot
> of sysadmins :-D.

Not as much as you think.  Unless a lot of applications can't handle
opening or saving files that have '...' in the pathname?

The sysadmin problem doesn't worry me so much.

>> Now, the cryptocompress as it currently stands does not involve ...  and
>> does not introduce any new security holes in the way that you are
>> describing.
> 
> 
> Good.  I think that we can all agree that, in the event  cryptocompress is
> included, it would be a nice feature to have in all filesystems.  
> Therefore,
> we should attempt to come up with a clean interface with which it  could be
> added _inside_ the VFS.

Agreed.  I don't know enough about VFS to propose one, though.  I think
others are working on that, finally.

>> There might be some issues with key management (someone
>> hinted vaguely at that), but nothing insurmountable.
> 
> 
> Likewise, this should be handled in a common VFS interface that all FSs
> can use.  There already exists a key management system that would not be
> particularly difficult to interface with, but it would take thought and
> discussion.

Not too much, I hope.

Although being able to use different keys on a per-file basis would be
nice.  I'm not sure if that would work in the existing system.  Not to
mention that keys would also be handlable with '...', if/when it happens.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQsBtWXgHNmZLgCUhAQI5gw/8DXFk/v3faGbAtv0vdeMmy5aZ4MSpr3pp
+rjjb8Wx6twCZelmPQgwTBtSQec9XUEipW3ucHVeP5Y2LM8hZHfbxEpHCzDydlH0
AppxZfHp/FBlqROSYajcc4qX062QQ7Wc/VfePmvVKcC7Plo1n1UnF30RRFLR67/r
SOwb4/GPDnYyY0SQQt8XmuFmu1ngRB5M/kFgGOkiGLOsRiPzx4zVnYsxnOp8vH/q
l0SxCsjev4+dL0TRnFBhx/uw7GerZJhqjjB9DZZgMIXILXt8oTHj1ubEXD0WRQxr
iwiXruO2rO3vFbJVXzdlhFnUj98ViQR9nALa+CwT779Zus9hx8/KAxScPXEZPzVz
jdF7y7GUvBL9vR+t5TTJjlpSqyfiyYKEw038/li/uBB1ThXtjTx4uL0QLzWkaaOh
mfdX5RFwyinrsmscBaYgUPHwqLTjgcIWwqSfmGQ9RvYbMkHy9ZOzHTP9chJIeD5F
cuJPluPEOMpeQduF/S7sG/Y00eQaMx0nBxtDprkwonnhy3Qw2jSSgsXqEIG+x45P
3qjiK7/4cZSkN/Q/VkObEwD0GE2FD31yfqSkrkGRMkhOg22YWBVqrwvmcm2RyQk9
h9S9C3HzNXGAuW9HfCmWLqg1yAQCilkTdGRpc38unBa364nRlBzii7PkA3XLol3S
zChIED+O964=
=shbE
-----END PGP SIGNATURE-----
