Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287967AbSABXQe>; Wed, 2 Jan 2002 18:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287989AbSABXQ3>; Wed, 2 Jan 2002 18:16:29 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:25358 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287982AbSABXQN>;
	Wed, 2 Jan 2002 18:16:13 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15411.37236.181936.39729@argo.ozlabs.ibm.com>
Date: Thu, 3 Jan 2002 10:02:12 +1100 (EST)
To: Bernard Dautrevaux <Dautrevaux@microprocess.com>
Cc: "'Tom Rini'" <trini@kernel.crashing.org>,
        Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
        gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org
Subject: RE: [PATCH] C undefined behavior fix
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3ED@IIS000>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E3ED@IIS000>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernard Dautrevaux writes:

> > 1) gcc shouldn't be making this optimization, and Paulus (who 
> > wrote the
> > code) disliked this new feature.  
> 
> Why? If memcpy can then be expanded in line, and the string is short, this
> can be a *huge* win...

Show me a place in the kernel which is performance-critical where we
do strcpy(p, "string").  I can't think of one.  The stuff in prom.c
isn't performance-critical.

> I think we MUST modify the RELOC macro. Currently the code has an undefined
> meaning WRT th eC standard, so is allowed to do almost anything from working
> as expected (quite bad in fact: it may suddenly fail when sth is modified
> elsewhere), to triggering the 3rd World War :-)

As I said in another email, if the gcc maintainers want to change gcc
so that pointer arithmetic can do anything other than an ordinary 2's
complement addition operation, then we will stop using gcc.

Paul.
