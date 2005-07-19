Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVGSOvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVGSOvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVGSOvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:51:18 -0400
Received: from web8406.mail.in.yahoo.com ([202.43.219.154]:58500 "HELO
	web8406.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S261182AbVGSOvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:51:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MRupvNq8zQVRtZ8UGTIkl0aeHYwyXCoRy7wYXHFWQW9omgD5TtIi8fhLlIVosxp0VyATrEs1evtfygz2Z5QmtItqmgUfAoxSebASi4hm8i4UtvL+yRdX7q92kybI5JmMhbQkfUi5/KTL9AKyadg4jD1cKHhTjui16e0V5fItuAY=  ;
Message-ID: <20050719145114.19836.qmail@web8406.mail.in.yahoo.com>
Date: Tue, 19 Jul 2005 15:51:13 +0100 (BST)
From: KV Pavuram <kvpavuram@yahoo.co.in>
Subject: sigwait in multi-threaded application
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Are there any caveats of sigwait (on RT signals) in
multithreaded application?

As suggested in the man page, i call 

# define SIG35 35
# define SIG36 36

sigaddset (&set, SIG36) ;
pthread_sigmask (SIG_BLOCK, &set, NULL);

at the beginning of the program (in main) before I
create any threads.

Then i register a signal handler for SIG35. The signal
handler i call sigwait for SIG36 as

    sigaddset (&set, SIG36) ; 
    pthread_sigmask (SIG_BLOCK, &set, NULL) ;      
    sigwait (&set, &signum) ; 
    if (signum == SIG_TASKRESUME)
    {
        printf ("Task is received SIG36\n") ;
    }

Is this usage right? I see that some times if run
strace on the particular thread that is currently in
sigwait and then kill strace with Ctrl+C, the threads
starts hogging CPU? Why should Ctrl+C wake up sigwait
on SIG36??

Am I missing something?  (Linux 9, 2.4 kernel)

Regards,
Pav.



		
__________________________________________________________
How much free photo storage do you get? Store your friends 'n family snaps for FREE with Yahoo! Photos http://in.photos.yahoo.com
