Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131046AbRA0RzB>; Sat, 27 Jan 2001 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130324AbRA0Ryv>; Sat, 27 Jan 2001 12:54:51 -0500
Received: from smtp1.free.fr ([212.27.32.5]:36106 "EHLO smtp1.free.fr")
	by vger.kernel.org with ESMTP id <S131046AbRA0Ryf>;
	Sat, 27 Jan 2001 12:54:35 -0500
To: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Subject: Re: stripping symbols from modules
Message-ID: <980618073.3a730b592258c@imp.free.fr>
Date: Sat, 27 Jan 2001 18:54:33 +0100 (MET)
From: Willy Tarreau <wtarreau@free.fr>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188095C@xsj02.sjs.agilent.com>
In-Reply-To: <FEEBE78C8360D411ACFD00D0B747797188095C@xsj02.sjs.agilent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 212.27.43.84
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

> Is there any way to strip symbols from modules .o files ?

there are many symbols you have to keep. You also have to keep modules args
and exported modules. I personnaly use this method which seems to work OK even
if it's really awful (although I'm not sure it will work under all
circumstances) :

for i in *.o; do
       objcopy -R __ksymtab -R .comment -R .note -x `nm $i |
          grep ' ? \(__module_parm_\)\|\(__ks..tab_\)' |
          sed -e 's/\(__module_parm_\)\(.*\)/\2/'
              -e 's/\(__ks..tab_\)\(.*\)/\2/' | cut -f3- -d' ' | sort -u |
          awk '{printf " -K "$1}'` $i
done


After this, I even compress the modules because you can often gain about a 2.5
ratio.

Cheers,
Willy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
