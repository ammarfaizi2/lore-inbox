Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbULADGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbULADGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 22:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbULADGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 22:06:50 -0500
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:40670 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261188AbULADGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 22:06:48 -0500
Subject: sparse warnings in string.h
From: Steve French <smfrench@austin.rr.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1101870601.6580.16.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 30 Nov 2004 21:10:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparse generates warnings as follows:

 include/asm/string.h:384:26: warning: cast truncates bits from constant
 	value (bdbdbdbd becomes bd)
 include/asm/string.h:387:27: warning: cast truncates bits from constant
 	value (bdbdbdbd becomes bdbd)
 include/asm/string.h:390:27: warning: cast truncates bits from constant
 	value (bdbdbdbd becomes bdbd)
 include/asm/string.h:391:30: warning: cast truncates bits from constant
	value (bdbdbdbd becomes bd)


on two of the cifs vfs C files because of include/asm/string.h due to
the the following case statement in the common include file:

static inline void * __constant_c_and_count_memset(void * s, unsigned
long pattern, size_t count)
{
        switch (count) {
                case 0:
                        return s;
                case 1:
                        *(unsigned char *)s = pattern;
                        return s;
                case 2:
                        *(unsigned short *)s = pattern;
                        return s;
                case 3:
                        *(unsigned short *)s = pattern;
                        *(2+(unsigned char *)s) = pattern;


Any ideas of how to get around these sparse warnings (they are the only
ones that appear in my code)?  I suspect that no one wants to modify
string.h to eliminate the warning because of the comments about compiler
optimization.

