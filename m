Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288986AbSAFQWf>; Sun, 6 Jan 2002 11:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288987AbSAFQWZ>; Sun, 6 Jan 2002 11:22:25 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:48815 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S288986AbSAFQWN>;
	Sun, 6 Jan 2002 11:22:13 -0500
From: dewar@gnat.com
To: dewar@gnat.com, guerby@acm.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020106162213.37901F28C5@nile.gnat.com>
Date: Sun,  6 Jan 2002 11:22:13 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<But even in the case of the compiler reading more (and writing anyway),
I think it  is the compiler burden to prove that the extra stuff
"read" is not observable (in the sense of external
effect) at execution. In a memory-mapped I/O architecture
where there is a distinction on external effects between a byte read
and a word read (eg: a crash :),  the compiler can't get very far IMHO
(if it accepts the declaration of course).
>>

External effects are well defined in Ada, see 1.1.3(8) of the RM. The
case you mention is not explicitly listed here, so is not an external
effect in the Ada sense. The rule is not that anything observable be
unaffected (after all performance is observable), but that the 
six explicit items in section 1.1.3(8) are not observable. Here they
are for those who do not have the Ada RM at hand (it is not that
Ada is so significant here, as that perhaps we can get some clues
for the desirable behavior in GNU C)

    9  Any interaction with an external file (see A.7);

   10  The execution of certain code_statements (see 13.8); which code_
       statements cause external interactions is implementation defined.

   11  Any call on an imported subprogram (see Annex B), including any
       parameters passed to it;

   12  Any result returned or exception propagated from a main
       subprogram (see 10.2) or an exported subprogram (see Annex B) to
       an external caller;

   13  Any read or update of an atomic or volatile object (see C.6);

   14  The values of imported and exported objects (see Annex B) at the
       time of any other interaction with the external environment.

