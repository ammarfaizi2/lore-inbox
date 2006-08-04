Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161467AbWHDVJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbWHDVJc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161468AbWHDVJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:09:32 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:60093 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161467AbWHDVJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:09:31 -0400
Message-ID: <44D3B78A.8000900@slaphack.com>
Date: Fri, 04 Aug 2006 17:09:30 -0400
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Theodore Tso <tytso@mit.edu>, David Masover <ninja@slaphack.com>,
       "Vladimir V. Saveliev" <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       vda.linux@googlemail.com, linux-kernel@vger.kernel.org,
       Reiserfs-List@namesys.com
Subject: Re: reiser4: maybe just fix bugs?
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com> <20060801013104.f7557fb1.akpm@osdl.org> <44CEBA0A.3060206@namesys.com> <1154431477.10043.55.camel@tribesman.namesys.com> <20060801073316.ee77036e.akpm@osdl.org> <1154444822.10043.106.camel@tribesman.namesys.com> <44CF879D.1000803@slaphack.com> <20060803074651.GA27835@thunk.org>
In-Reply-To: <20060803074651.GA27835@thunk.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Tso wrote:
> On Tue, Aug 01, 2006 at 11:55:57AM -0500, David Masover wrote:
>> If I understand it right, the original Reiser4 model of file metadata is 
>> the file-as-directory stuff that caused such a furor the last big push 
>> for inclusion (search for "Silent semantic changes in Reiser4"):
> 
> The furor was caused by concerns Al Viro expressed about
> locking/deadlock issues that reiser4 introduced.  

Which, I believe, was about file-as-dir.  Which also had problems with 
things like directory loops.  That's sort of a disk space memory leak.

> The bigger issue with xattr support is two-fold.  First of all, there
> are the progams that are expecting the existing extended attribute
> interface,

Yeah...

> More importantly are the system-level extended attributes, such as
> those used by SELINUX, which by definition are not supposed to be
> visible to the user at all,

I don't see why either of these are issues.  The SELINUX stuff can be a 
plugin which doesn't necessarily have a user-level interface. 
Cryptocompress, for instance, exists independent of its user-level 
interface (probably the file-as-dir stuff), and will probably be 
implemented in some sort of stable form as a system-wide default for new 
files.

So, certainly metadata (xattrs) as a plugin could be implemented with no 
UI at all, or any given UI.

... Anyway, I still see no reason why these cannot be implemented in 
Reiser4, other than the possibility that if it uses "plugins", I 
guarantee that at least one or two people will hate the implementation 
for that reason alone.

> Not supporting xattrs means that those distro's that use SELINUX by
> default (i.e., RHEL, Fedora, etc.) won't want to use reiser4, because
> SELINUX won't work on reiser4 filesytstems.

Right.  So they will be implemented, eventually.

> Whether or not Hans cares about this is up to him....

He does, or he should.  Reiser4 needs every bit of acceptance it can get 
right now, as long as it can get them without compromising its goals or 
philosophy.  Extended attributes only compromise these because it 
provides less incentive to learn any other metadata interface that 
Reiser4 provides.  But that's irrelevant if Reiser4 doesn't gain enough 
acceptance due to lack of xattr support, anything it has will be 
irrelevant anyway.

So just as we provide the standard interface to Unix permissions (even 
though we intend to implement things like acls and views, and even 
though there was a file/.pseudo/rwx interface), we should provide the 
standard xattr interface, and the standard direct IO interface, and 
anything else that's practical.  Be a good, standard filesystem first, 
and an innovative filesystem second.
