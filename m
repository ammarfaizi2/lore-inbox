Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273350AbRISKLa>; Wed, 19 Sep 2001 06:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274029AbRISKLU>; Wed, 19 Sep 2001 06:11:20 -0400
Received: from [203.195.134.252] ([203.195.134.252]:1284 "HELO
	mindgames.noida.webyarn.com") by vger.kernel.org with SMTP
	id <S273350AbRISKLP>; Wed, 19 Sep 2001 06:11:15 -0400
Date: Wed, 19 Sep 2001 15:53:32 +0530
From: Sandip Bhattacharya <sandip@webyarn.com>
To: linux-kernel@vger.kernel.org
Subject: procfs feature or bug?
Message-ID: <20010919155332.A980@mindsw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Organisation: Mindframe Software 
X-Os: Linux mindgames.noida.webyarn.com 2.4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Do cc me replies. Thanks.]

Hi!

I was trying out the multipage procfs entries, when i found out that i
was having a problem.  

I am trying to use the "hack" by Paul Russell to allow mangling of
filepos using ``*start'' entries as my personal page offset. Now, for
multipage entries, whatever i set as *start should be coming back to
me as offset when the next page is called.

But in fs/proc/generic.c in proc_file_read() at the end we have (
after the first page has been "copied_to_user")

 *ppos += start < page ? (long) start : n;

But this _adds_ the contents of start to the offset, in the case where
I am supplying the offset in ``start''. Shouldn't this just be
_replacing_ ? 'Cause in this case the offsets get cumulatively added,
causing an oops at the end for me :(

Or am I missing something big???

- Sandip

--
-----------------------------------------------------------
Sandip Bhattacharya
Office: sandip@mindsw.com       Home: sandipb@bigfoot.com
Mindframe Software
-----------------------------------------------------------
