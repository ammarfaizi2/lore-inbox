Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUEUQkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUEUQkK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUEUQkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 12:40:10 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:49795 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265940AbUEUQkF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 12:40:05 -0400
Subject: Re: 2.6.6 breaks kmail (nfs related?)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andreas Amann <amann@physik.tu-berlin.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200405211727.14917.amann@physik.tu-berlin.de>
References: <200405131411.52336.amann@physik.tu-berlin.de>
	 <200405171331.35688.amann@physik.tu-berlin.de>
	 <1084809309.3669.17.camel@lade.trondhjem.org>
	 <200405211727.14917.amann@physik.tu-berlin.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1085157602.3666.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 21 May 2004 12:40:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 21/05/2004 klokka 11:27, skreiv Andreas Amann:

> In both cases the server was 2.4.25. Who is now wrong in this case, the client 
> or the server? To me it looks now, as if the server needs to be fixed, but I 
> am no expert. 

Yep. This is a server side bug. I just checked the dump, and the client
is indeed sending the correct filehandle (exactly the same one as in the
COMMIT just before it).

Hmm... It looks to me as if you are exporting that filesystem with the
"subtree_check" option enabled. Could you try to set "no_subtree_check"?
The subtree checking stuff breaks NFS in various subtle ways (including
renames etc), and is one of the more common sources of ESTALE errors.

Cheers,
  Trond
