Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271683AbRHQQdQ>; Fri, 17 Aug 2001 12:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271479AbRHQQdG>; Fri, 17 Aug 2001 12:33:06 -0400
Received: from sitebco-home-5-17.urbanet.ch ([194.38.85.209]:772 "EHLO
	vulcan.alphanet.ch") by vger.kernel.org with ESMTP
	id <S271683AbRHQQcv>; Fri, 17 Aug 2001 12:32:51 -0400
Date: Fri, 17 Aug 2001 18:32:47 +0200
From: Marc SCHAEFER <schaefer@alphanet.ch>
Message-Id: <200108171632.SAA00941@vulcan.alphanet.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: ext2 not NULLing deleted files?
Newsgroups: alphanet.ml.linux.kernel
In-Reply-To: <01081709381000.08800@haneman>
Organization: ALPHANET NF -- Not for profit telecom research
X-Newsreader: TIN [UNIX 1.3 unoff BETA 970705; i586 Linux 2.0.38]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <01081709381000.08800@haneman> you wrote:

> I just recognized there's an "undelete" now for ext2 file systems [a KDE 

not new.

> "The Other OS" in its professional version does of course clear the deleted 

(assuming NT)

No it doesn't, and there even has been cases in the past where its
journaling filesystem was, under some conditions, extending files
with old data blocks without deleting them (a bit like the OLE `let's
put anything which is in RAM in this MS-Word file'), allowing other
users to snoop on each other's data / deleted data [no references
sorry, from memory].

Special care, as far as I understand it, must be taken when allocating
fs data blocks. The following sequence must be followed:

   1. reserve them
   2. clear them
   3. mark them as allocated.

if 2 is too expensive, maybe it's sufficient to mark them as dirty
and zero them in memory. But what happens if the system crashes, with
the metadata to the disk (block allocated), but the data block not
yet filled/zeroed ?

Maybe some flags somewhere telling that those data blocks are allocated
but not yet committed ?

