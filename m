Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292829AbSCWLk0>; Sat, 23 Mar 2002 06:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSCWLkQ>; Sat, 23 Mar 2002 06:40:16 -0500
Received: from web10307.mail.yahoo.com ([216.136.130.85]:40210 "HELO
	web10307.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292829AbSCWLkF>; Sat, 23 Mar 2002 06:40:05 -0500
Message-ID: <20020323114004.92117.qmail@web10307.mail.yahoo.com>
Date: Sat, 23 Mar 2002 11:40:04 +0000 (GMT)
From: "=?iso-8859-1?q?J.D.=20Hood?=" <jdthood@yahoo.co.uk>
Subject: Re: proc_file_read() hack?
To: Todd Inglett <tinglett@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In http://marc.theaimsgroup.com/?l=linux-kernel&m=101304602932539&w=2
I posted a patch which includes the following comment:

+			/*
+			 * How to be a proc read function
+			 * ------------------------------
+			 * Prototype:
+			 *    int f(char *buffer, char **start, off_t offset,
+			 *          int count, int *peof, void *dat)
+			 *
+			 * Assume that the buffer is "count" bytes in size.
+			 *
+			 * If you know you have supplied all the data you
+			 * have, set *peof.
+			 *
+			 * You have three ways to return data:
+			 * 0) Leave *start = NULL.  (This is the default.)
+			 *    Put the data of the requested offset at that
+			 *    offset within the buffer.  Return the number (n)
+			 *    of bytes there are from the beginning of the
+			 *    buffer up to the last byte of data.  If the
+			 *    number of supplied bytes (= n - offset) is 
+			 *    greater than zero and you didn't signal eof
+			 *    and the reader is prepared to take more data
+			 *    you will be called again with the requested
+			 *    offset advanced by the number of bytes 
+			 *    absorbed.  This interface is useful for files
+			 *    no larger than the buffer.
+			 * 1) Set *start = an unsigned long value less than
+			 *    the buffer address but greater than zero.
+			 *    Put the data of the requested offset at the
+			 *    beginning of the buffer.  Return the number of
+			 *    bytes of data placed there.  If this number is
+			 *    greater than zero and you didn't signal eof
+			 *    and the reader is prepared to take more data
+			 *    you will be called again with the requested
+			 *    offset advanced by *start.  This interface is
+			 *    useful when you have a large file consisting
+			 *    of a series of blocks which you want to count
+			 *    and return as wholes.
+			 *    (Hack by Paul.Russell@rustcorp.com.au)
+			 * 2) Set *start = an address within the buffer.
+			 *    Put the data of the requested offset at *start.
+			 *    Return the number of bytes of data placed there.
+			 *    If this number is greater than zero and you
+			 *    didn't signal eof and the reader is prepared to
+			 *    take more data you will be called again with the
+			 *    requested offset advanced by the number of bytes
+			 *    absorbed.
+			 */

This patch was included in David Jones's patches for the 2.5
series.

> I'm trying to understand this little hack in 2.4.18's (and earlier)
> fs/proc/generic.c:
> /* This is a hack to allow mangling of file pos independent
>  * of actual bytes read.  Simply place the data at page,
>  * return the bytes, and set `start' to the desired offset
>  * as an unsigned int. - Paul.Russell@rustcorp.com.au
>  */
> I take it to mean that if I return a small integer for "start" instead 
> of a ptr the hack will kick in.  However it compares pointers instead. 

That's why it's called a "hack".

> I'll attach a patch that does it the way I am thinking -- but I may be 
> misunderstanding the comment.

You are misunderstanding it.

--
Thomas Hood


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
