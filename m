Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130074AbQKFTFV>; Mon, 6 Nov 2000 14:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbQKFTFL>; Mon, 6 Nov 2000 14:05:11 -0500
Received: from CC859385856-a.hnglo1.ov.nl.home.com ([212.120.96.103]:41220
	"EHLO debian.besselink") by vger.kernel.org with ESMTP
	id <S129920AbQKFTE7>; Mon, 6 Nov 2000 14:04:59 -0500
Date: Mon, 6 Nov 2000 20:18:50 +0100 (CET)
From: Leen Besselink <leen@wirehub.nl>
Reply-To: Leen Besselink <leen@wirehub.nl>
To: Jeff Dike <jdike@karaya.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Play Kernel Hangman!
In-Reply-To: <200011061631.LAA02504@ccure.karaya.com>
Message-ID: <Pine.LNX.3.96.1001106195143.2553B-100000@debian.besselink>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Jeff Dike wrote:

> After a stranger than usual late-night #kernelnewbies session on Thursday, I 
> was inspired to come up with Kernel Hangman.  This is the traditional game of 
> hangman, except that the words you have to guess are kernel symbols.
> 
> So, test your knowledge of kernel trivia and play it at 
> http://user-mode-linux.sourceforge.net/cgi-bin/hangman
> 
> 				Jeff

Actually, OpenBSD already has this (in the kernel !) After a kernel crash
ones, I got in the kerneldebugger. I didn't really know how to use it, but
I could play hangman. I just downloaded the source 
(pub/OpenBSD/2.7/srcsys.tar.gz) to be sure, here is a short excerpt from
sys/ddb/db_hangman.c:
---
static __inline char *
db_randomsym(lenp)
        size_t  *lenp;
{
        register char   *p, *q;
                /* choose random symtab */
        register db_symtab_t    stab = db_istab(db_random(db_nsymtabs));

                /* choose random symbol from the table */
        q = db_qualify(X_db_isym(stab,
db_random(X_db_nsyms(stab))),stab->name);

                /* don't show symtab name if there are less than 3 of 'em
*/
        if (db_nsymtabs < 3)
                while(*q++ != ':');

                /* strlen(q) && ignoring underscores and colons */
        for ((*lenp) = 0, p = q; *p; p++)
                if (ISALPHA(*p))
                        (*lenp)++;

        return q;
}

static char hangpic[]=
        "\n88888 \r\n"
          "9 7 6 \r\n"
          "97  5 \r\n"
          "9  423\r\n"
          "9   2 \r\n"
          "9  1 0\r\n"
          "9\r\n"
          "9  ";
static char substchar[]="\\/|\\/O|/-|";

---
and an other part:
---

void
db_hangman(addr, haddr, count, modif)
        db_expr_t addr;
        int     haddr;
        db_expr_t count;
        char    *modif;
{
        if (modif[0] == 's' && '0' <= modif[1] && modif[1] <= '9')
                skill = modif[1] - '0';
        else
                skill = 5;

        while (db_hangon());
}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
