Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271537AbRHPJMr>; Thu, 16 Aug 2001 05:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271538AbRHPJMh>; Thu, 16 Aug 2001 05:12:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55815 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S271537AbRHPJMW>; Thu, 16 Aug 2001 05:12:22 -0400
Date: Thu, 16 Aug 2001 04:43:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Daniel Phillips <phillips@innominate.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Write drop behind logic with used-once patch
Message-ID: <Pine.LNX.4.21.0108160423440.27203-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Daniel,

As far as I can see, the write drop behind logic with the used-once patch
is partly "gone" now: "check_used_once()" at generic_file_write() will set
all "write()n" pages to have age == PAGE_AGE_START (in case those pages
were not in cache before), which means they will be moved to the active
list later by page_launder(), effectively causing excessive pressure on
the current "active" pages since we have exponential page aging.

I'm I overlooking some here or my thinking is correct ?


