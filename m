Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVHIPrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVHIPrI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbVHIPrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:47:08 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:54423 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964828AbVHIPrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:47:06 -0400
In-Reply-To: <1123594460.8245.15.camel@lade.trondhjem.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>
MIME-Version: 1.0
Subject: Re: [RFC] atomic open(..., O_CREAT | ...)
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF8B842185.9331BF0D-ON88257058.0054CAEE-88257058.0056B6B6@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Tue, 9 Aug 2005 08:47:03 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M6_06302005 Beta 4|June
 30, 2005) at 08/09/2005 11:47:02,
	Serialize complete at 08/09/2005 11:47:02
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Intents are meant as optimisations, not replacements for existing
>operations. I'm therefore not really comfortable about having them
>return errors at all.

That's true of normal intents, but not what are called intents here.  A 
normal intent merely expresses an intent, and it can be totally ignored 
without harm to correctness.  But these "intents" were designed to be 
responded to by actually performing the foreshadowed operation now - 
irreversibly.

Linux needs an atomic lookup/open/create in order to participate in a 
shared filesystem and provide a POSIX interface (where shared filesystem 
means a filesystem that is simultaneously accessed by something besides 
the Linux system in question).  Some operating systems do this simply with 
a VFS lookup/open/create function.  Linux does it with this intents 
interface.

It's hard to merge the concepts in code or in one's mind, which is why 
we're here now.  A filesystem driver that needs to do atomic 
lookup/open/create has to bend over backwards to split the operation 
across the three filesystem driver calls that Linux wants to make.

I've always preferred just to have a new inode operation for 
lookup/open/create (mirroring the POSIX open operation, used for all opens 
if available), but if enough arguments to lookup can do it, that's 
practically as good.  But that means returning final status from lookup, 
and not under any circumstance proceeding to create or open when the 
filesystem driver has said the entire operation is complete.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems

