Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135673AbRDXPGJ>; Tue, 24 Apr 2001 11:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135672AbRDXPF7>; Tue, 24 Apr 2001 11:05:59 -0400
Received: from web1103.mail.yahoo.com ([128.11.23.123]:32516 "HELO
	web1103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S135673AbRDXPFs>; Tue, 24 Apr 2001 11:05:48 -0400
Message-ID: <20010424150546.6917.qmail@web1103.mail.yahoo.com>
Date: Tue, 24 Apr 2001 17:05:46 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: capabilities carried over execve()
To: eric@sparrow.nad.adelphia.net
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I personnaly use this simple patch which allows me
to keep caps over execve(). It allows me to give a
few more rights to some trusted users, such as 
kill, insmod... without risking unlink, chown or 
so. I couldn't find any other way to achieve this.

If needed, I can send you the complete prog which
sets the requested capabilities upon login, 
eventually asking for a password and limited in 
time of day.

Regards,
Willy

--- linux-2.2.18-wt11/fs/exec.c Fri Feb 16 23:11:52
2001
+++ linux-2.2.18-wt11+caps/fs/exec.c    Thu Feb 22
20:45:33 2001
@@ -702,7 +702,10 @@
        cap_clear(bprm->cap_inheritable);
        cap_clear(bprm->cap_permitted);
        cap_clear(bprm->cap_effective);
-
+/*** FIXME: just a test : keep permitted and
effective ******/
+bprm->cap_permitted =
cap_intersect(current->cap_inheritable,current->cap_permitted);
+bprm->cap_effective =
cap_intersect(current->cap_inheritable,current->cap_effective);
+/*** /FIXME ****/
        /*  To support inheritance of root-permissions
and suid-root
          *  executables under compatibility mode, we
raise all three
          *  capability sets for the file.



___________________________________________________________
Do You Yahoo!? -- Pour faire vos courses sur le Net, 
Yahoo! Shopping : http://fr.shopping.yahoo.com
