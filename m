Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTEPAeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 20:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTEPAeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 20:34:05 -0400
Received: from windlord.Stanford.EDU ([171.64.19.147]:55696 "HELO
	windlord.stanford.edu") by vger.kernel.org with SMTP
	id S264305AbTEPAeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 20:34:03 -0400
To: Garance A Drosihn <drosih@rpi.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       <linux-fsdevel@vger.kernel.org>, <openafs-devel@openafs.org>
Subject: Re: [OpenAFS-devel] Re: Alternative to PAGs
References: <Pine.LNX.4.44.0305150920400.1841-100000@home.transmeta.com>
	<p05210620bae9cce008ed@[128.113.24.47]>
In-Reply-To: <p05210620bae9cce008ed@[128.113.24.47]> (Garance A Drosihn's
 message of "Thu, 15 May 2003 19:14:27 -0400")
From: Russ Allbery <rra@stanford.edu>
Organization: The Eyrie
Date: Thu, 15 May 2003 17:46:48 -0700
Message-ID: <yl7k8rzpjb.fsf@windlord.stanford.edu>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Portable Code,
 sparc-sun-solaris2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Garance A Drosihn <drosih@rpi.edu> writes:

> What AFS does not want is for a single process to be drosehn@rpi.edu and
> linus@rpi.edu at the exact same time.  That is to avoid the question of
> what open() should do on a file which is permitted:

>      drosehn rlidwka
>      linus   none

An even better example without an obvious answer (which in this case is
that the open should be allowed, since that ACL says that drosehn should
be able to open the file and says nothing about linus) would be if linus
had negative rights (in other words, if the ACL actively asserted that
linus should *not* be able to open the file regardless of the other ACLs).

AFS supports the notion of negative rights primarily in combination with
groups, so you can have a situation like:

    Normal rights:
        organization:itss rlidwka

    Negative rights:
        rra rlidwka

where rra is a member of organization:itss.  rra will be denied access to
that directory despite the fact that his membership in organization:itss
would normally give him full rights.

-- 
Russ Allbery (rra@stanford.edu)             <http://www.eyrie.org/~eagle/>
