Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131029AbQL2PZT>; Fri, 29 Dec 2000 10:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131331AbQL2PZJ>; Fri, 29 Dec 2000 10:25:09 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:40686 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S131029AbQL2PY5>;
	Fri, 29 Dec 2000 10:24:57 -0500
Date: Fri, 29 Dec 2000 15:53:27 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Albert Cranford <ac9410@bellsouth.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Stefan Traby <stefan@hello-penguin.com>, Andi Kleen <ak@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test13-pre5
Message-ID: <20001229155327.A11313@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <Pine.LNX.4.10.10012281712180.1231-100000@penguin.transmeta.com> <3A4BE396.8A48A3F4@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A4BE396.8A48A3F4@bellsouth.net>; from ac9410@bellsouth.net on Fri, Dec 29, 2000 at 01:06:30AM +0000
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-test10-fijiji2 (i686)
X-APM: 100% 200 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 01:06:30AM +0000, Albert Cranford wrote:
> Simply executing
>          *p++ = htonl(fl->fl_pid);
> before 
>          start = loff_t_to_s64(fl->fl_start);
> also works.

Yes, confirmed.
Since you're located in Florida I vote for this and I hope that
Linus will elect it. :)


--- linux/fs/lockd/xdr4.c.orig	Fri Dec 29 01:35:32 2000
+++ linux/fs/lockd/xdr4.c	Fri Dec 29 14:56:07 2000
@@ -167,13 +167,13 @@
 	 || (fl->fl_end > NLM4_OFFSET_MAX && fl->fl_end != OFFSET_MAX))
 		return NULL;
 
+	*p++ = htonl(fl->fl_pid);
 	start = loff_t_to_s64(fl->fl_start);
 	if (fl->fl_end == OFFSET_MAX)
 		len = 0;
 	else
 		len = loff_t_to_s64(fl->fl_end - fl->fl_start + 1);
 
-	*p++ = htonl(fl->fl_pid);
 	p = xdr_encode_hyper(p, start);
 	p = xdr_encode_hyper(p, len);

-- 

  ciao - 
    Stefan

"                export PS1="((((((((((((rms))))))))))))# "              "

Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
