Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289348AbSBJHzf>; Sun, 10 Feb 2002 02:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289352AbSBJHz0>; Sun, 10 Feb 2002 02:55:26 -0500
Received: from femail35.sdc1.sfba.home.com ([24.254.60.25]:3320 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S289348AbSBJHzN>; Sun, 10 Feb 2002 02:55:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: "Nivedita Singhvi" <nivedita@us.ibm.com>
Subject: [DOC PATCH] Re: tcp_keepalive_intvl vs tcp_keepalive_time?
Date: Sun, 10 Feb 2002 02:56:06 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF46DAF8B5.5C736002-ON65256B5C.0018A2C8@boulder.ibm.com>
In-Reply-To: <OF46DAF8B5.5C736002-ON65256B5C.0018A2C8@boulder.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020210075512.UHYV1888.femail35.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 February 2002 11:40 pm, Nivedita Singhvi wrote:
> > Would someone be kind enough to explain the difference between
> > tcp_keepalive_intvl and tcp_keepalive_time?
> > Documentation/filesystems/proc.txt says tcp_keepalive_time is the
>
> interval
>
> > between sending keepalive probes, but doesn't mention
>
> tcp_keepalive_intvl...
>
> tcp starts a keepalive timer for each connection. if the connection is idle
> for tcp_keepalive_time seconds, it starts sending probes to the other end.
> It sends a maximum of tcp_keepalive_probes each tcp_keepalive_intvl
> seconds apart, and if the other end hasnt responded by then, it drops the
> connection.

Thanks.

Patch to proc.txt:

--- linux/Documentation/filesystems/proc.txt    Wed Nov  7 17:39:36 2001
+++ linux/Documentation/filesystems/proc.bak    Sun Feb 10 02:46:55 2002
@@ -1421,8 +1421,14 @@
 tcp_keepalive_time
 ------------------

-How often  TCP  sends out keep alive messages, when keep alive is enabled. The
-default is 2 hours.
+Number of seconds a connection must remain inactive before sending the first
+keep alive probe, when keep alive is enabled. The default is 7200 (2 hours).
+
+tcp_keepalive_intvl
+-------------------
+
+Number of seconds a keep alive probe must go unanswered before sending
+another one.

 tcp_syn_retries
 ---------------




> not clear from the info here whats happening in your case...
> (stats?)

SuSE is being annoying in a way Red Hat wasn't.  The box has a 2.4.6
kernel on it, I'll probably upgrade that before pursuing this much further
(which I won't be in a position to do until I physically get back to
Austin...)  Since I've been playing with Linux From Scratch recently, I 
ight throw the system I've put together on there so I at least know what
the heck it's all doing. :)

What kind of packets are keepalive packets, by the way?  (I don't think
the firewall rules are filtering them out, but I can't be sure.)

> > Rob
>
> thanks,
> Nivedita

Rob again. :)
