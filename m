Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSGMRsv>; Sat, 13 Jul 2002 13:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315267AbSGMRsu>; Sat, 13 Jul 2002 13:48:50 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:55561 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S315266AbSGMRsu>; Sat, 13 Jul 2002 13:48:50 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: LKML <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [RFC] dcache scalability patch (2.4.17) 
cc: pmenage@ensim.com
In-reply-to: Your message of "Sat, 13 Jul 2002 13:33:10 EDT."
             <Pine.GSO.4.21.0207131328360.15574-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Jul 2002 10:51:10 -0700
Message-Id: <E17TR30-0006Yu-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>On Sat, 13 Jul 2002, Paul Menage wrote:
>
>> - accessing foo/../bar, won't mark foo as referenced, even though it
>> might be being referenced frequently. Probably not a common case for foo
>> to be accessed exclusively in this way, but it could be fixed by marking
>> a dentry referenced when following ".."
>
>It certainly will.  Look - until ->d_count hits zero referenced bit is
>not touched or looked at.  At all.
>
>Look at the code.  There is _no_ aging for dentries with positive ->d_count.
>They start aging only when after they enter unused_list...
>

Yes, but with the fastwalk lookup, accessing foo/../bar won't do a
dget() for foo (assuming it was cached), and hence will never do a
dput() on it either. So if the only references to foo are as foo/../bar
then its d_count will stay zero and it will never be marked referenced.
(Or am I missing something?)

Paul

