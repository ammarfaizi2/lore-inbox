Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVANAYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVANAYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVANAWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:22:53 -0500
Received: from CPE-144-136-221-26.sa.bigpond.net.au ([144.136.221.26]:44088
	"EHLO modra.org") by vger.kernel.org with ESMTP id S261706AbVANARi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 19:17:38 -0500
Date: Fri, 14 Jan 2005 10:47:36 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: "H. J. Lu" <hjl@lucon.org>
Cc: "Allan B. Cruse" <cruse@cs.usfca.edu>, binutils@sources.redhat.com,
       gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: Change i386 assembler/disassembler for SIB with INDEX==4
Message-ID: <20050114001735.GB3408@bubble.modra.org>
Mail-Followup-To: "H. J. Lu" <hjl@lucon.org>,
	"Allan B. Cruse" <cruse@cs.usfca.edu>, binutils@sources.redhat.com,
	gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
	linux-kernel@vger.kernel.org
References: <20050113203328.1174721A3F@nexus.cs.usfca.edu> <20050113224601.GA3184@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113224601.GA3184@lucon.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 02:46:01PM -0800, H. J. Lu wrote:
> On Thu, Jan 13, 2005 at 12:33:28PM -0800, Allan B. Cruse wrote:
> > 
> > On Thu, 13 Jan 2005, "H. J. Lu" <hjl@lucon.org> wrote:
> > >
> > >
> > >
> > > Subject: Change i386 assembler/disassembler for SIB with INDEX==4
> > > 
> > > I am proposing to change i386 assembler/disassembler for SIB with
> > > INDEX==4
> > >                                                                                
> > > http://sources.redhat.com/bugzilla/show_bug.cgi?id=658
> > >                                                                                
> > > It will change the assembler output for (%ebx,[1248]). I am not too
> > > worried about the disassembler output since assembler can't generate
> > > SIB with INDEX==4 directly today. Any comments?
> > > 
> > > 
> > > H.J.
> > > 
> > 
> > 
> > This change would give programmers the freedom to write instruction-
> > syntax that the processor cannot actually execute, is that right?  
> 
> No. Assemberl will turn "mov (%ebx,2),%eax" into "8b 04 63", which
> is valid i386 machine code.

I don't see any particular need to support generation of this
instruction coding.  Feeding the output of the disassembler back to the
assembler won't generate the same encodings for many instructions, eg.
there are two ways to encode mov %eax,%ebx (and some people even use
the two reg->reg move encodings to hide messages in code).  Another
example is that the assembler chooses the smallest immediate or
displacement encoding.

> > 
> > Perhaps the downside to this would lie in the hours of debugging and
> > private research each programmer would then be faced with, trying to
> > figure out why  " movl (%esi,2),%eax "  wasn't doing what he/she had
> > intended, and which the assembler had dutifully accepted.    --ABC

Huh?  The assembler will warn about this construct, and we certainly
should continue to warn, so that people who meant to write
"mov (,%esi,2),%eax" get a clue.

> 
> What do you expect "movl (%esi,2),%eax" will do?
> 
> 
> H.J.

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
