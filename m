Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264961AbUFLX67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbUFLX67 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 19:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbUFLX67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 19:58:59 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:20864 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264961AbUFLX65 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 19:58:57 -0400
Subject: Re: In-kernel Authentication Tokens (PAGs)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com>
References: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
	 <1087080664.4683.8.camel@lade.trondhjem.org>
	 <D822E85F-BCC8-11D8-888F-000393ACC76E@mac.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1087084736.4683.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 12 Jun 2004 19:58:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 12/06/2004 klokka 19:33, skreiv Kyle Moffett:

> - Designed for AFS
> 
> I designed this because I would like to see a ticket/token storage 
> mechanism
> in the kernel.  I would like this to be something that could be a 
> Kerberos V5
> credentials cache, an RSA key storage agent (like ssh-agent), and a 
> generic
> remote filesystem token storage.

So this would be more like an in-kernel keyring then?

> - A token can only be on one PAG
> 
> True in my design, but in order to access the token you open() it, 
> which returns
> a filehandle that can be passed to any other program over a UNIX socket.
> This could be easily extended to allow the original user to 
> invalidate/close the
> other user's filehandle.  Also, the design allows each PAG to have a 
> parent,
> so it forms a tree (Must be non-cyclic).  This allows multiple 
> processes to share
> a set of global tokens in a parent PAG, and each have their own sub-PAGs
> that they can work in without disturbing the global token set.  Linus 
> even
> mentions that perhaps a list of PAGs could handle that issue, but with 
> that the
> priority is unintuitive, whereas with a tree one can match the process 
> tree
> much more accurately and without much effort.  Even still, my design 
> makes it
> simple to add the ability for a token to be in more than one PAG.

How does it cope with lifetime issues such as token renewal and
invalidation?

Does it provide for notifiers in case of invalidation, renewal or token
expiration?

For NFSv4 for instance, this is important, since the client will want to
evict all state if the user's credential expires.

Cheers,
  Trond
