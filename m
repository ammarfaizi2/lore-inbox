Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSGJUP0>; Wed, 10 Jul 2002 16:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSGJUPZ>; Wed, 10 Jul 2002 16:15:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:10408 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317598AbSGJUPY> convert rfc822-to-8bit; Wed, 10 Jul 2002 16:15:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Perches, Joe" <joe.perches@spirentcom.com>
Subject: Re: Chatserver workload simulator by Bill Hartner?
Date: Wed, 10 Jul 2002 13:17:39 -0700
User-Agent: KMail/1.4.1
References: <629E717C12A8694A88FAA6BEF9FFCD440540AA@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440540AA@brigadoon.spirentcom.com>
Cc: "'Dave Hansen'" <haveblue@us.ibm.com>,
       Anders Fugmann <afu@fugmann.dhs.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       Rick Lindsley <ricklind@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207101317.39447.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 July 2002 09:35 am, Perches, Joe wrote:
> It's on the Linux Benchmark Suite site with several
> other useful tools...
>
> http://lbs.sourceforge.net/
> -

The chat-1.0.1.tar.gz on that page still has a memory free/use bug with the ti 
array.  I sent the patch to bhartner, but maybe he's not maintaining it 
anymore.  It only seems to cause trouble when running heavy loads.  (Maybe 
large blocks of memory get coalesced, or something.)  Anyway, here it is:

--- chat_s.c.df	Tue Jun  4 17:37:03 2002
+++ chat_s.c	Thu Jun 20 15:18:51 2002
@@ -515,7 +515,6 @@
 	int exit_rc = 0;
 	int rc = 0;
 	
-	free(ti);
 	free(s_send_stack);
 	free(s_receive_stack);
 	
@@ -533,6 +532,8 @@
 		}	
 	}
 
+	free(ti);
+
 	return(exit_rc);
 }
 


-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

