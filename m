Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319621AbSH2X22>; Thu, 29 Aug 2002 19:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319624AbSH2X22>; Thu, 29 Aug 2002 19:28:28 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:41213
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319621AbSH2X21>; Thu, 29 Aug 2002 19:28:27 -0400
Subject: Re: [PATCH 1 / ...] i386 dynamic fixup/self modifying code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1030663772.1491.107.camel@ldb>
References: <1030506106.1489.27.camel@ldb>  <20020828121129.A35@toy.ucw.cz>
	<1030663192.1326.20.camel@irongate.swansea.linux.org.uk> 
	<1030663772.1491.107.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 30 Aug 2002 00:32:35 +0100
Message-Id: <1030663955.1327.27.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-30 at 00:29, Luca Barbieri wrote:
> Worked around by making sure all other processors are stopped (iret is
> serializing) sending IPIs if they are not already spinning on the fixup
> lock. See patch #2.

what happens we you do a fixup and the fixup occurs in an IPI handler
(eg a cross CPU tlb flush).


> > For the other fixups though you -have- to do them before you
> > run the code. That isnt hard (eg sparc btfixup). You generate a list of
> > the addresses in a segment, patch them all and let the init freeup blow 
> > the table away
> Is doing them at runtime with the aforementioned workaround fine?

Is doing them all in the beginning not somewhat saner and more
debuggable. The only reason to do it at runtime is hotplugging a less
capable CPU. I have a suggestion for that case which is that we don't
bother about it 8)

