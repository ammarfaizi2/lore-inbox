Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbVHIQIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbVHIQIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 12:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbVHIQIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 12:08:04 -0400
Received: from pat.uio.no ([129.240.130.16]:58559 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964855AbVHIQIB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 12:08:01 -0400
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <OF8B842185.9331BF0D-ON88257058.0054CAEE-88257058.0056B6B6@us.ibm.com>
References: <OF8B842185.9331BF0D-ON88257058.0054CAEE-88257058.0056B6B6@us.ibm.com>
Content-Type: text/plain
Date: Tue, 09 Aug 2005 12:07:41 -0400
Message-Id: <1123603661.8245.78.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.425, required 12,
	autolearn=disabled, AWL 2.39, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 09.08.2005 Klokka 08:47 (-0700) skreiv Bryan Henderson:
> >Intents are meant as optimisations, not replacements for existing
> >operations. I'm therefore not really comfortable about having them
> >return errors at all.
> 
> That's true of normal intents, but not what are called intents here.  A 
> normal intent merely expresses an intent, and it can be totally ignored 
> without harm to correctness.  But these "intents" were designed to be 
> responded to by actually performing the foreshadowed operation now - 
> irreversibly.
> 
> Linux needs an atomic lookup/open/create in order to participate in a 
> shared filesystem and provide a POSIX interface (where shared filesystem 
> means a filesystem that is simultaneously accessed by something besides 
> the Linux system in question).  Some operating systems do this simply with 
> a VFS lookup/open/create function.  Linux does it with this intents 
> interface.
> 
> It's hard to merge the concepts in code or in one's mind, which is why 
> we're here now.  A filesystem driver that needs to do atomic 
> lookup/open/create has to bend over backwards to split the operation 
> across the three filesystem driver calls that Linux wants to make.
> 
> I've always preferred just to have a new inode operation for 
> lookup/open/create (mirroring the POSIX open operation, used for all opens 
> if available), but if enough arguments to lookup can do it, that's 
> practically as good.  But that means returning final status from lookup, 
> and not under any circumstance proceeding to create or open when the 
> filesystem driver has said the entire operation is complete.

Have you looked at how we're dealing with this in NFSv4?

Cheers,
  Trond

