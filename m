Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUHSCOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUHSCOn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 22:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUHSCOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 22:14:43 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:25586 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267994AbUHSCOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 22:14:36 -0400
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.8.0
From: Albert Cahalan <albert@users.sf.net>
To: mmazur@pld-linux.org
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1092872470.5761.1993.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 18 Aug 2004 19:41:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For IA-64 and MIPS, and for any other arch with
variable page sizes, you need something like this:

////////////////////////////////////////
extern int getpagesize(void);

#define PAGE_SIZE ((unsigned long)(getpagesize()))

// This is a gcc statement-expression.
// You might want the __extension__ keyword.
#define PAGE_SHIFT ({          \
  int _PAGE_SIZE = PAGE_SIZE;  \
  (_PAGE_SIZE > 16*1024)       \   
  ?  (_PAGE_SIZE == 32*1024)   \  
     ? 15ul                      \  
     : 16ul                      \  
  :  (_PAGE_SIZE == 8*1024)     \
     ? 13ul                      \  
     :  (_PAGE_SIZE == 4*1024)  \
        ? 12ul                   \
        : 14ul                  \
  ;                           \
})
//////////////////////////////////////////


