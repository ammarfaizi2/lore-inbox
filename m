Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUERXus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUERXus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 19:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUERXus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 19:50:48 -0400
Received: from lakermmtao02.cox.net ([68.230.240.37]:27823 "EHLO
	lakermmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263741AbUERXuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 19:50:46 -0400
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <2A66C358-A926-11D8-9051-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: PAG/tokens in the kernel (again)
Date: Tue, 18 May 2004 19:50:39 -0400
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 From what I can tell searching the web and reading the LKML archives, 
the
issue of PAGs in the kernel is still mostly unresolved.  I guess 
currently the
reason that all of the patches have been rejected is due to the 
combination
of the patch with parts of AFS or NFSv4 or Coda or whatever.  I've 
looked at
most of the complaints about the patches proposed on the list and 
decided
introduce a cleaner alternative idea.

What if each process had a PAG entry associated with it (Similar to 
earlier
proposals). Each PAG would have a set of associated tokens (AFS, NFSv4,
Coda, whatever), and a parent PAG.  The search for tokens would begin
in the process's PAG and continue up the list until it either found a 
token or
hit the end.  All user processes would be able to push a new empty PAG
onto the front of their PAG list (up to a limit).  Thus it is possible 
to create a
new set of tokens (admin tokens or whatever) that hide the older ones 
for
a given process and its subprocesses.  Thus the PAG originally created
when logging in on one console could be pointed to by several processes
and several other PAGs.

It would also perhaps be useful to allow any process with the CAP_PAG
bit set to modify the chain in other ways on any process. One example
could be to allow sshd/rshd to connect a user's new session to an 
already
existing PAG, without hiding anything in the user's newly created PAG.

I'm sure that there are holes in this idea somewhere, please feel free 
to
point them out.  If other people like it or would like to see a patch 
I'll try to
hack up one, but I'd rather not waste the effort if this has some 
utterly fatal
flaw.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

