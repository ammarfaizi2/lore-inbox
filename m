Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSDMRfJ>; Sat, 13 Apr 2002 13:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293060AbSDMRfI>; Sat, 13 Apr 2002 13:35:08 -0400
Received: from angelo.kcl.ac.uk ([137.73.66.5]:39095 "EHLO angelo.kcl.ac.uk")
	by vger.kernel.org with ESMTP id <S293048AbSDMRfH>;
	Sat, 13 Apr 2002 13:35:07 -0400
Date: Sat, 13 Apr 2002 18:30:40 +0100 (BST)
From: KONSTANTINOS BOUKIS <konstantinos.boukis@kcl.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Problem with macro IN6_ARE_ADDR_EQUAL
Message-ID: <Pine.GSO.4.21.0204131822550.7244-100000@angelo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found out that the definition of the macro IN6_ARE_ADDR_EQUAL
in the file netinet/in.h is erroneous. In kernel 2.4.16 it is

#define IN6_ARE_ADDR_EQUAL(a,b) \
	((((uint32_t *) (a))[0] == ((uint32_t *) (b))[0]) && \
	 (((uint32_t *) (a))[1] == ((uint32_t *) (b))[2]) && \
	 (((uint32_t *) (a))[2] == ((uint32_t *) (b))[1]) && \
	 (((uint32_t *) (a))[3] == ((uint32_t *) (b))[3]))

This macro checks the a[1] with the b[2] instead of b[1] and also
the a[2] with the b[1] instead of b[2], as a result it returns false
for equal ipv6 addresses.
costas

