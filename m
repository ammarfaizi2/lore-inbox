Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268927AbRHBNBq>; Thu, 2 Aug 2001 09:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268925AbRHBNBg>; Thu, 2 Aug 2001 09:01:36 -0400
Received: from ha1.rdc2.nsw.optushome.com.au ([203.164.2.50]:30343 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S268919AbRHBNB3>; Thu, 2 Aug 2001 09:01:29 -0400
From: Manfred Bartz <mbartz@optushome.com.au>
Message-ID: <20010802103447.992.qmail@optushome.com.au>
To: linux-kernel@vger.kernel.org
Subject: setsockopt(..,SO_RCVBUF,..) sets wrong value
Organization: yes
Date: 02 Aug 2001 20:34:47 +1000
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do a setsockopt(..,SO_RCVBUF,..) and then read the value back
with getsockopt(), the reported value is exactly twice of what I set.

Running the same code on Solaris and on DEC UNIX reports back the
exact size I set.

Looking at the code it seems that the  *2  should not be there:

>From /usr/src/linux/net/core/sock.c:

int sock_setsockopt(...

		case SO_SNDBUF:

			sk->sndbuf = max(val*2,SOCK_MIN_SNDBUF);

		case SO_RCVBUF:
			/* FIXME: is this lower bound the right one? */
			sk->rcvbuf = max(val*2,SOCK_MIN_RCVBUF);
			break;


-- 
Manfred Bartz
