Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbUBTUbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUBTU1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:27:00 -0500
Received: from mail.medent.com ([65.114.41.3]:36252 "HELO medent.com")
	by vger.kernel.org with SMTP id S261322AbUBTUZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:25:44 -0500
From: "John Chatelle" <johnch@medent.com>
To: linux-kernel@vger.kernel.org
Subject: High read Latency test (Anticipatory I/O scheduler)
Date: Fri, 20 Feb 2004 15:20:22 -0500
Message-Id: <20040220202023.M9162@medent.com>
X-Mailer: Open WebMail 2.10 20030617
X-OriginatingIP: 65.114.41.101 (johnch)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-2
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I haven't seen much duplicated results regarding the Robert Love article 
in the February 2004 Linux Journal article, also reachable in the hyperlink:
          http://www.linuxjournal.com/article.php?sid=6931

 Although the 1st simple test: "Write starved reads" gets results comparable
to the results reported in the Article, Our results for the 2nd test: "High 
Read latency" delivers results opposite our expectations...
 
Kernel 2.6.2 Results: (Anticipatory I/O scheduler).

real    43m41.138s       Nearly 44 minutes! 2nd run similar.
user    0m4.715s
sys     0m11.179s

Kernel 2.4.20-28.7p21gsmp Results:

real    0m41.535s        Only 42 seconds!   2nd run similar.
user    0m4.720s
sys     0m15.470s

Our dmesg shows wer're running the Anticipatory scheduler when testing under
the 2.6.2 kernel. 

The 2 shell scripts, StreamingRead.sh and WHR.sh (bash, actually), implement 
the test:

#StreamingRead.sh       --simple 4 line shell script:
   while true
   do
     cat ../data/oneGBfile >/dev/null
   done

#WHR.sh                -- simple 2 (or 3) line shell script.
   StreamingRead.sh &
   time find /usr/src/linux-2.4.20-18.7  -type f -exec cat \
     '{}' ';' > /dev/null

   I'm reading a 1G binary garbage file repeatedly while timing 
the transversal and reading of the 2.4 Kernel source tree, just as the test 
2 example shows in the article.  I would think I/O anticipating the 1G 
garbage file would be likely, where the I/O anticipation of the reading of 
the source tree under the 'find' command would be far choppier and more 
difficult.The 'time' command, however measures the less anticipatory and 
choppier reads of the 'find' command!  I therefore see the results of table 
1 for test 2 to be very counter intuitive!  

  Has anyone else seen such divergent results compared to those reported in 
the article?  Does anyone else see the same results with the anticipatory 
I/O scheduler?  


    

John Chatelle 
johnch@medent.com 
Community Computer Service 
15 Hulbert Street - P.O. Box 980 
Auburn, New York  13021 
Phone:  (315)-255-1751 
Fax:    (315)-255-3539


--
This message and any attachments may contain information that is protected
by law as privileged and confidential, and is transmitted for the sole use
of the intended recipient(s). If you are not the intended recipient, you
are hereby notified that any use, dissemination, copying or retention of
this e-mail or the information contained herein is strictly prohibited. If
you have received this e-mail in error, please immediately notify the
sender by e-mail, and permanently delete this e-mail.



-- 
This message has been scanned for viruses and
dangerous content by MailScanner.


