Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbUDNXoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 19:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262026AbUDNXiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 19:38:11 -0400
Received: from [62.241.33.80] ([62.241.33.80]:4370 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262035AbUDNXfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 19:35:34 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: lkml <linux-kernel@vger.kernel.org>
Subject: [SECURITY] CAN-2004-0177 (was: Re: [SECURITY] CAN-2004-0075)
Date: Thu, 15 Apr 2004 01:35:03 +0200
User-Agent: KMail/1.6.1
References: <20040414171147.GB23419@redhat.com> <200404142230.33553@WOLK>
In-Reply-To: <200404142230.33553@WOLK>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Tweedie <sct@redhat.com>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404150135.03714@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nqcfAtr9jjtlqfE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_nqcfAtr9jjtlqfE
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 14 April 2004 22:30, you wrote:

Hi again,

> Okay, now while we are at fixing security holes, is there any chance we
> can get the attached patch in?

Okay, we are at it, so what's about the attached one too? ;)

In WOLK for some time too. I am not 100% sure if this is correct, but I think 
it is. Andrew? Stephen?

----------------------------------------------------------------------
CAN-2004-0177
    Solar Designer discovered an information leak in the ext3 code of
    Linux.  In a worst case an attacker could read sensitive data such
    as cryptographic keys which would otherwise never hit disk media.
    Theodore Ts'o developed a correction for this.
----------------------------------------------------------------------

ciao, Marc

--Boundary-00=_nqcfAtr9jjtlqfE
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="8009_CAN-2004-0177-ext3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="8009_CAN-2004-0177-ext3.patch"

--- a/fs/jbd/journal.c	Mon Nov 10 00:12:14 2003
+++ b/fs/jbd/journal.c	Fri Feb 27 20:36:04 2004
@@ -599,6 +599,7 @@
 		return NULL;
 
 	bh = __getblk(journal->j_dev, blocknr, journal->j_blocksize);
+	memset(bh->b_data, 0, journal->j_blocksize);
 	bh->b_state |= (1 << BH_Dirty);
 	BUFFER_TRACE(bh, "return this buffer");
 	return journal_add_journal_head(bh);

--Boundary-00=_nqcfAtr9jjtlqfE--
