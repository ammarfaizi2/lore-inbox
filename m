Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130229AbRAKOPF>; Thu, 11 Jan 2001 09:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130306AbRAKOOz>; Thu, 11 Jan 2001 09:14:55 -0500
Received: from smtp-out1.bellatlantic.net ([199.45.40.143]:12445 "EHLO
	smtp-out1.bellatlantic.net") by vger.kernel.org with ESMTP
	id <S130229AbRAKOOp>; Thu, 11 Jan 2001 09:14:45 -0500
Message-ID: <3A5DBFBC.88DFEBD7@neuronet.pitt.edu>
Date: Thu, 11 Jan 2001 09:14:20 -0500
From: "Rafael E. Herrera" <raffo@neuronet.pitt.edu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Juchem <juchem@uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bugreporting script - second try
In-Reply-To: <Pine.LNX.4.30.0101111300440.21849-100000@gandalf.math.uni-mannheim.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Juchem wrote:
>   http://www.brightice.de/src/bugreport.sh

I have a suggestion, there is a kernel patch to add a config.gz entry in
the /proc fs. It reflects the configuration used in building the running
kernel, which may differ from the one you have in /usr/src/linux. It's
part of the suse distribution. The attached patch will use it, although
you may want to add code to ask the user which one to use.

--- bugreport.sh        Thu Jan 11 09:09:00 2001
+++ bugreport.sh_orig   Thu Jan 11 08:53:21 2001
@@ -478,16 +478,11 @@
 
 
     # kernel config
-    if [ -f "/proc/config.gz" ]
+    if [ -f "$krn_srcdir/.config" ]
     then
-        dot_config=`gzip -d < /proc/config.gz|grep -v "^#"|grep CONFIG`
+        dot_config=`cat $krn_srcdir/.config|grep -v "^#"|grep CONFIG`
     else
-        if [ -f "$krn_srcdir/.config" ]
-        then
-            dot_config=`cat $krn_srcdir/.config|grep -v "^#"|grep
CONFIG`
-        else
-           dot_config="not found"
-        fi
+       dot_config="not found"
     fi
 }

-- 
     Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
