Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbTIVVff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 17:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTIVVff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 17:35:35 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:26306 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261980AbTIVVfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 17:35:30 -0400
Message-ID: <3F6F6B1B.9040609@nortelnetworks.com>
Date: Mon, 22 Sep 2003 17:35:23 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compiler warnings and syscall macros
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to figure something out.  For ppc, in asm/unistd.h, 
__syscall_nr is defined as:


#define __syscall_nr(nr, type, name, args...)	\
	unsigned long __sc_ret, __sc_err;	\
	{					\
<snipped for brevity>
	}					\
	if (__sc_err & 0x10000000)		\
	{					\
		errno = __sc_ret;		\
		__sc_ret = -1;			\
	}					\
	return (type) __sc_ret


Whenever I use this in my code, I get compiler warnings about the 
statment "__sc_ret = -1" since it is assigning a negative value to an 
unsigned int.

Would it hurt anything if I put in an explicit cast, like this?

__sc_ret = (unsigned long) -1;

This seems to get rid of the warnings, and I can't imagine it hurting 
anything.

Am I missing something bad here?


Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

