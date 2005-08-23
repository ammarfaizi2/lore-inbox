Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbVHWTH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbVHWTH1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 15:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbVHWTH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 15:07:27 -0400
Received: from mail.solid.co.at ([193.83.215.58]:29907 "EHLO
	mail.solid-soft.at") by vger.kernel.org with ESMTP id S932325AbVHWTH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 15:07:27 -0400
Message-ID: <430B73E9.7080207@solid-soft.at>
Date: Tue, 23 Aug 2005 21:07:21 +0200
From: Robert Valentan <R.Valentan@solid-soft.at>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI tape problems: 2.6.12, DLT 7000, Adaptec AIC7xxx
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(and  Re: Linux-2.6.13-rc6: aic7xxx testers please..  )

Hi!

I have also the problem with a dlt drive HP C9264CB (with
media changer). After I have discovered, that after a

rmmod st ; modprobe st

the tape is working again, I take same "readings" in the
code of st.c.
I think, I have detect a bug. The st_buf_fragment[] should
begin after the scatterlist[]

*** st.c.orig   2005-08-23 20:43:17.304704439 +0200
--- st.c        2005-08-23 20:43:45.402087696 +0200
***************
*** 3530,3536 ****
         tb->use_sg = max_sg;
         if (segs > 0)
                 tb->b_data = page_address(tb->sg[0].page);
!       tb->frp = (struct st_buf_fragment *)(&(tb->sg[0]) + max_sg);

         tb->in_use = 1;
         tb->dma = need_dma;
--- 3530,3536 ----
         tb->use_sg = max_sg;
         if (segs > 0)
                 tb->b_data = page_address(tb->sg[0].page);
!       tb->frp = (struct st_buf_fragment *)(&(tb->sg[max_sg])); 

         tb->in_use = 1;
         tb->dma = need_dma;



I have it not tested, because the tape drive is in a datacenter
of a provider, and "killing" the kernel will not be repairable
with an ssh-connect ;-(  I can't get the tape out off the data-
center before friday..

wbr
-- 
Robert Valentan
