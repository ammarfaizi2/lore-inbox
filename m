Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbTB0S3b>; Thu, 27 Feb 2003 13:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbTB0S3b>; Thu, 27 Feb 2003 13:29:31 -0500
Received: from pop.gmx.de ([213.165.64.20]:19449 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S266010AbTB0S33> convert rfc822-to-8bit;
	Thu, 27 Feb 2003 13:29:29 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Torsten Foertsch <torsten.foertsch@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Capabilities question
Date: Thu, 27 Feb 2003 19:38:14 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302271938.19362.torsten.foertsch@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

what is the right way to get the current capability setting inherited through 
execve()?

My goal is a wrapper program that sets the needed capabilities and then 
execve()s the real program. These capabilities should also be inherited if 
the real program spawns childs via fork/exec.

Is that possible?

I read the appropriate parts of fs/exec.c where 
/*
 * This function is used to produce the new IDs and capabilities
 * from the old ones and the file's capabilities.
 *
 * The formula used for evolving capabilities is:
 *
 *       pI' = pI
 * (***) pP' = (fP & X) | (fI & pI)
 *       pE' = pP' & fE          [NB. fE is 0 or ~0]
 *
 * I=Inheritable, P=Permitted, E=Effective // p=process, f=file
 * ' indicates post-exec(), and X is the global 'cap_bset'.
 *
 */
is implemented. The problem is that fP and fE are either 0 or ~0 depending on 
the current uid or the uid of the file to be executed (if S_ISUID). Thus pP' 
is only masked by cap_bset which is a global constant (0xfffffeff).

Torsten
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+XlsbwicyCTir8T4RAjaaAJ9dU8E0YWy1fBnf6OdIX0wr7aQQ2gCgwObJ
aSAxVyLvV0n4MN4E84VVERg=
=YE3a
-----END PGP SIGNATURE-----
