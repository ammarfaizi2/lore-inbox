Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLORAn>; Fri, 15 Dec 2000 12:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLORAc>; Fri, 15 Dec 2000 12:00:32 -0500
Received: from picard.csihq.com ([204.17.222.1]:61455 "EHLO picard.csihq.com")
	by vger.kernel.org with ESMTP id <S129289AbQLORA0>;
	Fri, 15 Dec 2000 12:00:26 -0500
Message-ID: <03bc01c066b4$3252d690$e1de11cc@csihq.com>
From: "Mike Black" <mblack@csihq.com>
To: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: 2.2.18 signal.h
Date: Fri, 15 Dec 2000 11:29:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/signal.h

There's a couple like this -- isn't this case statement upside down???

extern inline void siginitset(sigset_t *set, unsigned long mask)
{
        set->sig[0] = mask;
        switch (_NSIG_WORDS) {
        default:
                memset(&set->sig[1], 0, sizeof(long)*(_NSIG_WORDS-1));
                break;
        case 2: set->sig[1] = 0;
        case 1:
        }
}

gcc is complaining:
/usr/src/linux/include/linux/signal.h:193: warning: deprecated use of label
at end of compound statement

________________________________________
Michael D. Black   Principal Engineer
mblack@csihq.com  321-676-2923,x203
http://www.csihq.com  Computer Science Innovations
http://www.csihq.com/~mike  My home page
FAX 321-676-2355

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
